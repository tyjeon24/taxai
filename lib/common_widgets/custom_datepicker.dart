import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'custom_sidetitle.dart';

class CustomDatePicker extends StatelessWidget {
  final int index;

  final String keyValue;
  final String title;
  final controller;
  final textController = TextEditingController();

  CustomDatePicker(
      {Key? key,
      required this.index,
      required this.keyValue,
      required this.title,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // 외부의 Obx와 별개로 내부에서 Obx를 한번 더 호출하는 이유는 드랍다운 값 선택 시 해당 값이 드롭다운에 표기되도록 렌더링하기 위함입니다(setState() 역할)
      return Row(
        children: [
          Expanded(flex: 7, child: CustomSideTitle(title)),
          Flexible(flex: 1, child: Container()),
          Expanded(
            flex: 20,
            child: TextField(
              decoration: InputDecoration(
                hintText: "날짜 입력",
                hintStyle: TextStyle(fontSize: 12),
                prefixIcon: Icon(
                  Icons.edit_calendar,
                ),
              ),
              controller: TextEditingController(
                  text: controller.param[index][keyValue] == null
                      ? ""
                      : controller.param[index][keyValue]),
              readOnly: true,
              onTap: () {
                Future<DateTime?> future = showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1970),
                    lastDate: DateTime(2100),
                    builder: (BuildContext context, Widget? child) {
                      return Theme(data: ThemeData.light(), child: child!);
                    });

                future.then((date) {
                  if (date != null) {
                    controller.setParam(index, keyValue,
                        DateFormat('yyyy-MM-dd').format(date).toString());
                    textController.text =
                        DateFormat('yyyy-MM-dd').format(date).toString();
                  }
                });
              },
            ),
          ),
        ],
      );
    });
  }
}
