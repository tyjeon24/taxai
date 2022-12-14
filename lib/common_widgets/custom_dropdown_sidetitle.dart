import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custom_sidetitle.dart';

class CustomDropdownButtonWithSidetitle extends StatelessWidget {
  final int index;

  final String keyValue;
  final List? contents;
  final controller;
  CustomDropdownButtonWithSidetitle(
      {Key? key,
      required this.index,
      required this.keyValue,
      required this.contents,
      required this.controller})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (contents == null) {
      return Container();
    }

    return Obx(() {
      // 외부의 Obx와 별개로 내부에서 Obx를 한번 더 호출하는 이유는 드랍다운 값 선택 시 해당 값이 드롭다운에 표기되도록 렌더링하기 위함입니다(setState() 역할)
      return Row(
        children: [
          Flexible(flex: 7, child: CustomSideTitle(keyValue)),
          Flexible(flex: 1, child: Container()),
          Flexible(
            flex: 7,
            child: DropdownButton(
              isExpanded: true,
              value: contents!.contains(controller.param[index][keyValue])
                  ? controller.param[index][keyValue]
                  : null,
              items: contents?.map((item) {
                return DropdownMenuItem<String>(
                    child: FittedBox(child: Text(item)), value: item);
              }).toList(),
              onChanged: (selectedValue) {
                controller.setParam(index, keyValue, selectedValue);
                if (keyValue == "양도시 종류") {
                  controller.param[index]
                      .removeWhere((key, value) => key == "분양권");
                  controller.param[index]
                      .removeWhere((key, value) => key == "취득시 종류");
                  controller.param[index]
                      .removeWhere((key, value) => key == "취득 원인");
                } else if (keyValue == "취득 원인") {
                  controller.param[index]
                      .removeWhere((key, value) => key == "분양권");
                  controller.param[index]
                      .removeWhere((key, value) => key == "취득시 종류");
                } else if (keyValue == "취득시 종류") {
                  controller.param[index]
                      .removeWhere((key, value) => key == "분양권");
                }
              },
            ),
          ),
        ],
      );
    });
  }
}
