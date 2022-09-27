import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../first_filter.dart';
import '../param_controller.dart';
import '../check_condition.dart';

import 'custom_datepicker.dart';
import 'custom_oxdropdown.dart';

class ConditionalDate extends StatelessWidget {
  const ConditionalDate({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final CapitalGainsParameter controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.param.value["취득시 종류"] == null) {
        return Container();
      }

      if (controller.param.value["분양권"] == null &&
          !filterMap[controller.param.value["양도시 종류"]]
                      [controller.param.value["취득 원인"]]
                  [controller.param.value["취득시 종류"]]
              .containsKey("data")) {
        return Container(); // 분양권 추가 정보를 받을 때까지 기다림
      }

      var additionalInfo = [];
      if (controller.param.value["분양권"] == null) {
        additionalInfo = filterMap[controller.param.value["양도시 종류"]]
                [controller.param.value["취득 원인"]]
            [controller.param.value["취득시 종류"]]["data"];
      } else {
        additionalInfo = filterMap[controller.param.value["양도시 종류"]]
                    [controller.param.value["취득 원인"]]
                [controller.param.value["취득시 종류"]]
            [controller.param.value["분양권"]]["data"];
      }

      List<Widget> widgets = [];
      widgets.add(Divider());
      widgets.add(Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Text("취득일 등 추가 정보",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4),
      ));

      for (Map widgetItem in additionalInfo) {
        if (checkCondition(widgetItem["condition"])) {
          if (widgetItem["type"] == "date") {
            widgets.add(CustomDatePicker(widgetItem["keyValue"]));
          } else {
            widgets.add(CustomOXDropdownButton(widgetItem["keyValue"]));
          }
        }
      }
      return Column(
        children: widgets,
      );
    });
  }
}
