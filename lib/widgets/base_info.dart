import 'package:flutter/material.dart';
import 'custom_address.dart';
import 'custom_dropdown.dart';
import 'custom_oxdropdown.dart';
import 'custom_title.dart';

import 'package:get/get.dart';

import '../first_filter.dart';
import '../param_controller.dart';

class BaseInfo extends StatelessWidget {
  const BaseInfo({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final CapitalGainsParameter controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      List<Widget> widgets = [];

      widgets.add(Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Text("기본 정보",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4),
      )); // 제목

      widgets.add(FractionallySizedBox(
        widthFactor: 0.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTitle("주소"),
            TextField(
              maxLines: null,
              decoration: InputDecoration(
                hintText: "주소를 입력해주세요.",
                prefixIcon: Icon(
                  Icons.place,
                ),
              ),
              controller: TextEditingController(
                  text: controller.param.value["fullAddress"] ?? ""),
              readOnly: true,
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("주소 검색"),
                        content: CustomAddress(),
                      );
                    });
              },
            ),
          ],
        ),
      )); // 1. 주소

      widgets.add(CustomDropdownButton(
          baseInfo[2]["smallTitle"], baseInfo[2]["contents"])); // 2. 양도시 종류

      if (controller.param.value[baseInfo[2]["smallTitle"]] != null) {
        widgets.add(CustomDropdownButton(
            baseInfo[3]["smallTitle"],
            filtermap1[controller
                .param.value[baseInfo[2]["smallTitle"]]])); // 3. 취득 원인
      }
      if (controller.param.value["취득 원인"] == "상속") {
        // 19.5 상속시 동일세대원 여부(20220913 추가)
        widgets.add(CustomOXDropdownButton("상속시 동일세대원 여부"));
      }
      if (controller.param.value[baseInfo[3]["smallTitle"]] != null) {
        // 취득시 종류
        widgets.add(CustomDropdownButton(
            baseInfo[4]["smallTitle"],
            filtermap2[controller.param.value["양도시 종류"]]
                [controller.param.value["취득 원인"]])); // // 4. 취득시 종류
      }
      if (controller.param.value["취득시 종류"] != null &&
          filterMap[controller.param.value["양도시 종류"]]
                      [controller.param.value["취득 원인"]]
                  [controller.param.value["취득시 종류"]] !=
              null &&
          !filterMap[controller.param.value["양도시 종류"]]
                      [controller.param.value["취득 원인"]]
                  [controller.param.value["취득시 종류"]]
              .keys
              .toList()
              .contains("data")) {
        widgets.add(CustomDropdownButton(
            "분양권",
            filterMap[controller.param.value["양도시 종류"]]
                        [controller.param.value["취득 원인"]]
                    [controller.param.value["취득시 종류"]]
                .keys
                .toList()));
      }

      return Column(
        children: widgets,
      );
    });
  }
}
