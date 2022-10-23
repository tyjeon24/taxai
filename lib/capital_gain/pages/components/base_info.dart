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
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CapitalGainsParameter>();
    return Obx(() {
      List<Widget> widgets = [];

      widgets.add(FractionallySizedBox(
        widthFactor: 0.7,
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0, bottom: 30.0),
          child: Text("1. 기본 정보",
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.headline4?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(200, 0, 0, 0))),
        ),
      )); // 제목

      widgets.add(FractionallySizedBox(
        widthFactor: 0.7,
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
                  text: controller.param[index]["fullAddress"] ?? ""),
              readOnly: true,
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("주소 검색"),
                        content:
                            CustomAddress(index: index, controller: controller),
                      );
                    });
              },
            ),
          ],
        ),
      )); // 1. 주소

      widgets.add(CustomDropdownButton(
          index: index,
          keyValue: baseInfo[2]["smallTitle"],
          contents: baseInfo[2]["contents"],
          controller: controller)); // 2. 양도시 종류

      if (controller.param[index][baseInfo[2]["smallTitle"]] != null) {
        widgets.add(CustomDropdownButton(
            index: index,
            keyValue: baseInfo[3]["smallTitle"],
            contents:
                filtermap1[controller.param[index][baseInfo[2]["smallTitle"]]],
            controller: controller)); // 3. 취득 원인
      }
      if (controller.param[index]["취득 원인"] == "상속") {
        // 19.5 상속시 동일세대원 여부(20220913 추가)
        widgets.add(CustomOXDropdownButton(
            index: index, keyValue: "상속시 동일세대원 여부", controller: controller));
      }
      if (controller.param[index][baseInfo[3]["smallTitle"]] != null) {
        // 취득시 종류
        widgets.add(CustomDropdownButton(
            index: index,
            keyValue: baseInfo[4]["smallTitle"],
            contents: filtermap2[controller.param[index]["양도시 종류"]]
                [controller.param[index]["취득 원인"]],
            controller: controller)); // // 4. 취득시 종류
      }
      if (controller.param[index]["취득시 종류"] != null &&
          filterMap[controller.param[index]["양도시 종류"]]
                      [controller.param[index]["취득 원인"]]
                  [controller.param[index]["취득시 종류"]] !=
              null &&
          !filterMap[controller.param[index]["양도시 종류"]]
                      [controller.param[index]["취득 원인"]]
                  [controller.param[index]["취득시 종류"]]
              .keys
              .toList()
              .contains("data")) {
        widgets.add(CustomDropdownButton(
            index: index,
            keyValue: "분양권",
            contents: filterMap[controller.param[index]["양도시 종류"]]
                        [controller.param[index]["취득 원인"]]
                    [controller.param[index]["취득시 종류"]]
                .keys
                .toList(),
            controller: controller));
      }

      return Column(
        children: widgets,
      );
    });
  }
}
