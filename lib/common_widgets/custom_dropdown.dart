import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custom_sidetitle.dart';
import 'package:capgain/colorbase.dart';

class CustomDropdownButton extends StatelessWidget {
  const CustomDropdownButton(
      {Key? key,
      required this.index,
      required this.keyValue,
      required this.title,
      required this.contents,
      required this.controller,
      this.tooltip = ""})
      : super(key: key);

  final int index;
  final String keyValue;
  final String title;
  final String tooltip;
  final List? contents;
  final controller;
  @override
  Widget build(BuildContext context) {
    if (contents == null) {
      return Container();
    }

    return Obx(() {
      // 외부의 Obx와 별개로 내부에서 Obx를 한번 더 호출하는 이유는 드랍다운 값 선택 시 해당 값이 드롭다운에 표기되도록 렌더링하기 위함입니다(setState() 역할)
      return Row(
        children: [
          if (tooltip != "") ...[
            Expanded(
                flex: 7,
                child: Tooltip(
                    decoration: BoxDecoration(color: tooltipBackgroundColor),
                    textStyle: TextStyle(color: tooltipFontColor),
                    message: tooltip,
                    child: Badge(
                        badgeContent: Icon(Icons.question_mark_rounded,
                            color: Colors.white),
                        badgeColor: badgeColor,
                        child: CustomSideTitle(title))))
          ],
          if (tooltip == "") ...[
            Expanded(flex: 7, child: CustomSideTitle(title))
          ],
          Flexible(flex: 1, child: Container()),
          Expanded(
            flex: 20,
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
                if (keyValue == "sell_type") {
                  // 양도시 종류가 변경되었을 때 세부 카테고리 값들 제거
                  controller.param[index]
                      .removeWhere((key, value) => key == "분양권");
                  controller.param[index]
                      .removeWhere((key, value) => key == "buy_type");
                  controller.param[index]
                      .removeWhere((key, value) => key == "buy_cause");
                } else if (keyValue == "buy_cause") {
                  // 취득 원인이 변경되었을 때 세부 카테고리 값들 제거
                  controller.param[index]
                      .removeWhere((key, value) => key == "분양권");
                  controller.param[index]
                      .removeWhere((key, value) => key == "buy_type");
                } else if (keyValue == "buy_type") {
                  // 취득시 종류가 변경되었을 때 세부 카테고리 값들 제거
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