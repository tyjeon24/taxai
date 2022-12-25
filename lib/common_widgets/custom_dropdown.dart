import 'package:badges/badges.dart';
import 'package:taxai/components/colorbase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custom_sidetitle.dart';

class CustomDropdownButton extends StatelessWidget {
  final int index;

  final String keyValue;
  final String title;
  final bool needTitle;
  final String tooltip;
  final List? contents;
  final controller;
  const CustomDropdownButton(
      {Key? key,
      required this.index,
      required this.keyValue,
      required this.title,
      required this.contents,
      required this.controller,
      this.needTitle = true,
      this.tooltip = ""})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (contents == null) {
      return Container();
    }

    return Obx(() {
      // 외부의 Obx와 별개로 내부에서 Obx를 한번 더 호출하는 이유는 드랍다운 값 선택 시 해당 값이 드롭다운에 표기되도록 렌더링하기 위함입니다(setState() 역할)
      var displayedValue = null;
      if (controller.param[index][keyValue] != null) {
        if (controller.param[index][keyValue] == true) {
          displayedValue = "O";
        } else if (controller.param[index][keyValue] == false) {
          displayedValue = "X";
        } else {
          displayedValue = controller.param[index][keyValue];
        }
      }
      return Row(
        children: [
          if (needTitle) ...[
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
          ],
          Flexible(flex: 1, child: Container()),
          Expanded(
            flex: 20,
            child: DropdownButton(
              isExpanded: true,
              value: displayedValue,
              items: keyValue == ""
                  ? null
                  : contents?.map((item) {
                      return DropdownMenuItem<String>(
                          child: FittedBox(child: Text(item)), value: item);
                    }).toList(),
              onChanged: (selectedValue) {
                if (selectedValue.runtimeType == String &&
                    selectedValue == "O") {
                  controller.setParam(index, keyValue, true);
                } else if (selectedValue.runtimeType == String &&
                    selectedValue == "X") {
                  controller.setParam(index, keyValue, false);
                } else {
                  controller.setParam(index, keyValue, selectedValue);
                }

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
