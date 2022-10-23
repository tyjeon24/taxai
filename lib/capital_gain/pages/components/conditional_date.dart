import 'package:capgain/capital_gain/constants/first_filter.dart';
import 'package:capgain/capital_gain/functions/check_condition.dart';
import 'package:capgain/common_widgets/custom_datepicker.dart';
import 'package:capgain/common_widgets/custom_oxdropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConditionalDate extends StatelessWidget {
  const ConditionalDate({
    Key? key,
    required this.index,
    required this.controller,
  }) : super(key: key);

  final int index;
  final controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.param[index]["취득시 종류"] == null) {
        return Container();
      }

      if (controller.param[index]["분양권"] == null &&
          !filterMap[controller.param[index]["양도시 종류"]]
                      [controller.param[index]["취득 원인"]]
                  [controller.param[index]["취득시 종류"]]
              .containsKey("data")) {
        return Container(); // 분양권 추가 정보를 받을 때까지 기다림
      }

      var additionalInfo = [];
      if (controller.param[index]["분양권"] == null) {
        additionalInfo = filterMap[controller.param[index]["양도시 종류"]]
                [controller.param[index]["취득 원인"]]
            [controller.param[index]["취득시 종류"]]["data"];
      } else {
        additionalInfo = filterMap[controller.param[index]["양도시 종류"]]
                    [controller.param[index]["취득 원인"]]
                [controller.param[index]["취득시 종류"]]
            [controller.param[index]["분양권"]]["data"];
      }

      List<Widget> widgets = [];
      widgets.add(Divider());

      widgets.add(FractionallySizedBox(
        widthFactor: 0.7,
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0, bottom: 30.0),
          child: Text("2. 취득일 등 추가 정보",
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.headline4?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(200, 0, 0, 0))),
        ),
      )); //

      for (Map widgetItem in additionalInfo) {
        bool checkedResult = checkCondition(index, widgetItem["condition"]);
        if (checkedResult) {
          if (widgetItem["type"] == "date") {
            widgets.add(CustomDatePicker(
                index: index,
                keyValue: widgetItem["keyValue"],
                controller: controller));
          } else {
            widgets.add(CustomOXDropdownButton(
                index: index,
                keyValue: widgetItem["keyValue"],
                controller: controller));
          }
        }
      }
      return Column(
        children: widgets,
      );
    });
  }
}
