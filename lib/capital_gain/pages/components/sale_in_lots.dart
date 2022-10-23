import 'package:capgain/common_widgets/custom_price.dart';
import 'package:capgain/param_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SaleInLots extends StatelessWidget {
  const SaleInLots({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CapitalGainsParameter>();
    return Obx(() {
      if (controller.param[index]["양도시 종류"] == "분양권(2021년 이전 취득)" ||
          controller.param[index]["양도시 종류"] == "분양권(2022년 이후 취득)") {
        return CustomPrice(
          index: index,
          keyValue: "분양가액",
          controller: controller,
        );
      }

      return Container();
    });
  }
}
