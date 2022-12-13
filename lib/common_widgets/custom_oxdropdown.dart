import 'package:capgain/components/colorbase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custom_sidetitle.dart';

class CustomOXDropdownButton extends StatelessWidget {
  List<Map> contents = [
    {"displayed": "O", "value": true},
    {"displayed": "X", "value": false}
  ];

  final int index;

  final String keyValue;
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  CustomOXDropdownButton(
      {Key? key,
      required this.index,
      required this.keyValue,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // 외부의 Obx와 별개로 내부에서 Obx를 한번 더 호출하는 이유는 드랍다운 값 선택 시 해당 값이 드롭다운에 표기되도록 렌더링하기 위함입니다(setState() 역할)
      return Container(
        margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: Row(
          children: [
            Expanded(flex: 7, child: CustomSideTitle(keyValue)),
            Flexible(flex: 1, child: Container()),
            Flexible(
              flex: 20,
              child: Container(
                padding: EdgeInsets.zero,
                decoration: BoxDecoration(
                  color: toggleNotSelected,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: ToggleButtons(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  fillColor: toggleSelected,
                  selectedColor: Colors.black,
                  children: [
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.0),
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text("O")),
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.0),
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text("X"))
                  ],
                  isSelected: [
                    // ignore: prefer_if_null_operators
                    controller.param[index][keyValue] == null
                        ? false
                        : controller.param[index][keyValue],
                    controller.param[index][keyValue] == null
                        ? false
                        : !controller.param[index][keyValue]
                  ],
                  onPressed: ((idx) {
                    if (idx == 0) {
                      controller.param[index][keyValue] = true;
                    } else {
                      controller.param[index][keyValue] = false;
                    }
                  }),
                ),
              ),
              // child: DropdownButton(
              //   value: controller.param[index][keyValue] ?? null,
              //   items: contents.map((item) {
              //     return DropdownMenuItem<bool>(
              //         child: FittedBox(child: Text(item["displayed"])),
              //         value: item["value"]);
              //   }).toList(),
              //   onChanged: (selectedValue) {
              //     controller.setParam(index, keyValue, selectedValue);
              //   },
              // ),
            ),
          ],
        ),
      );
    });
  }
}
