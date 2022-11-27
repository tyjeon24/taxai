import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'custom_sidetitle.dart';
import 'package:capgain/colorbase.dart';
import 'package:badges/badges.dart';

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
  CustomPrice(
      {Key? key,
      required this.index,
      required this.keyValue,
      required this.title,
      required this.controller,
      this.tooltip = ""})
      : super(key: key);

  final int index;
  final String keyValue;
  final String title;
  final String tooltip;
  // ignore: prefer_typing_uninitialized_variables
  final controller;

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
                  onChanged: (newPrice) =>
                      controller.setParam(index, keyValue, newPrice),
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
