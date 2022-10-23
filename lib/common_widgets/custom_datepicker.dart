import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'custom_title.dart';

class CustomDatePicker extends StatelessWidget {
  CustomDatePicker(
      {Key? key,
      required this.index,
      required this.keyValue,
      required this.controller})
      : super(key: key);

  final int index;
  final String keyValue;
  final controller;

  final textController = TextEditingController();

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
              TextField(
                decoration: InputDecoration(
                  hintText: "날짜를 입력해주세요.",
                  prefixIcon: Icon(
                    Icons.edit_calendar,
                  ),
                ),
                controller: TextEditingController(
                    text: controller.param[index][keyValue] == null
                        ? ""
                        : DateFormat('yyyy-MM-dd')
                            .format(controller.param[index][keyValue])
                            .toString()),
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
                      controller.setParam(index, keyValue, date);
                      textController.text =
                          DateFormat('yyyy-MM-dd').format(date).toString();
                    }
                  });
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
