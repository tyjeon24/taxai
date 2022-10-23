import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custom_title.dart';

class CustomOXDropdownButton extends StatelessWidget {
  List<Map> contents = [
    {"displayed": "O", "value": true},
    {"displayed": "X", "value": false}
  ];

  CustomOXDropdownButton(
      {Key? key,
      required this.index,
      required this.keyValue,
      required this.controller})
      : super(key: key);

  final int index;
  final String keyValue;
  final controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // 외부의 Obx와 별개로 내부에서 Obx를 한번 더 호출하는 이유는 드랍다운 값 선택 시 해당 값이 드롭다운에 표기되도록 렌더링하기 위함입니다(setState() 역할)
      return FractionallySizedBox(
        widthFactor: 0.7,
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTitle(keyValue),
              DropdownButton(
                value: controller.param[index][keyValue] ?? null,
                items: contents.map((item) {
                  return DropdownMenuItem<bool>(
                      child: FittedBox(child: Text(item["displayed"])),
                      value: item["value"]);
                }).toList(),
                onChanged: (selectedValue) {
                  controller.setParam(index, keyValue, selectedValue);
                },
              )
            ],
          ),
        ),
      );
    });
  }
}
