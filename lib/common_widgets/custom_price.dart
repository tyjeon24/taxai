import 'package:badges/badges.dart';
import 'package:taxai/components/colorbase.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/scheduler.dart';

import 'custom_sidetitle.dart';

String formatPrice(String? priceString) {
  String formattedPrice = "";
  if (priceString == null || priceString == "") {
    return "0원";
  }
  int price = int.parse(priceString);

  List<String> formatStrings = ["원", "만", "억", "조"];

  for (String formatString in formatStrings) {
    if (price % 10000 > 0) {
      formattedPrice = "${price % 10000}$formatString $formattedPrice";
    }
    price = price ~/ 10000;
  }

  if (!formattedPrice.contains("원")) {
    formattedPrice = "$formattedPrice원";
  }

  return formattedPrice;
}

class CustomPrice extends StatelessWidget {
  final int index;

  final String keyValue;
  final String title;
  final String tooltip;
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  CustomPrice(
      {Key? key,
      required this.index,
      required this.keyValue,
      required this.title,
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
                    hintText: "가격을 입력해주세요.",
                    prefixIcon: Icon(
                      Icons.attach_money,
                    ),
                    counterText: "",
                  ),
                  maxLength: 16, // 9999조까지 입력 가능
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (newPrice) {
                    controller.setParam(index, keyValue, newPrice);

                    if (keyValue == "liquid_cost" &&
                        newPrice.toString() != "0") {
                      // 납부한 분담금, 지급받은 청산금은 하나만 적용
                      SchedulerBinding.instance.addPostFrameCallback((_) =>
                          controller.setParam(index, "contri_cost", "0"));
                    }

                    if (keyValue == "contri_cost" &&
                        newPrice.toString() != "0") {
                      // 납부한 분담금, 지급받은 청산금은 하나만 적용
                      SchedulerBinding.instance.addPostFrameCallback((_) =>
                          controller.setParam(index, "liquid_cost", "0"));
                    }
                  },
                ),
                // Text(formatPrice(controller.param[index][keyValue]),
                //     style: Theme.of(context).textTheme.caption)
              ],
            ),
          ),
        ],
      );
    });
  }
}
