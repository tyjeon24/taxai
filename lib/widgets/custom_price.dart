import 'package:flutter/material.dart';
import '../param_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'custom_title.dart';

String formatPrice(String? priceString) {
  String formattedPrice = "";
  if (priceString == null || priceString == "") {
    return "0원";
  }
  int price = int.parse(priceString);

  List<String> formatStrings = ["원", "만", "억", "조"];

  for (String formatString in formatStrings) {
    if (price % 10000 > 0) {
      formattedPrice = "${price % 10000}${formatString} ${formattedPrice}";
    }
    price = price ~/ 10000;
  }

  if (!formattedPrice.contains("원")) {
    formattedPrice = "${formattedPrice}원";
  }

  return formattedPrice;
}

class CustomPrice extends StatelessWidget {
  String keyValue = "";
  CustomPrice(this.keyValue);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CapitalGainsParameter>();

    return Obx(() {
      return FractionallySizedBox(
        widthFactor: 0.5,
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTitle(keyValue),
              TextField(
                decoration: InputDecoration(
                  hintText: "가격을 입력해주세요.",
                  prefixIcon: Icon(
                    Icons.attach_money,
                  ),
                ),
                maxLength: 16, // 9999조까지 입력 가능
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (newPrice) =>
                    controller.setParam(keyValue, newPrice),
              ),
              Text(formatPrice(controller.param.value[keyValue]),
                  style: Theme.of(context).textTheme.caption)
            ],
          ),
        ),
      );
    });
  }
}
