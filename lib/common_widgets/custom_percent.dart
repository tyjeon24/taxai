import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:taxai/components/colorbase.dart';

import 'custom_sidetitle.dart';

String formatPercent(String? percentString) {
  if (percentString == null || percentString == "") {
    return "0%";
  }
  int percent = int.parse(percentString);

  if (percent > 100) {
    return "100%";
  }

  return "$percent%";
}

class CustomPercent extends StatelessWidget {
  final int index;
  final String title;
  final String keyValue;
  final String tooltip;
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  CustomPercent(
      {Key? key,
      required this.index,
      required this.title,
      required this.keyValue,
      required this.controller,
      this.tooltip = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      controller.param[index][keyValue];
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                    decoration: InputDecoration(
                        hintText: "%값을 입력해주세요",
                        prefixIcon: Icon(
                          Icons.percent,
                        ),
                        counterText: ""),
                    maxLength: 3, // 100까지 입력 가능
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (newPrice) {
                      if (int.parse(newPrice) > 100) {
                        controller.setParam(index, keyValue, "100");
                      } else {
                        controller.setParam(index, keyValue, newPrice);
                      }
                    }),
                // Text(formatPercent(controller.param[index][keyValue]),
                //     style: Theme.of(context).textTheme.caption)
              ],
            ),
          ),
        ],
      );
    });
  }
}
