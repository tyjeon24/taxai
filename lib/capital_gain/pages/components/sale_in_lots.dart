import 'package:taxai/common_widgets/custom_price.dart';
import 'package:taxai/components/param_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SaleInLots extends StatelessWidget {
  final int index;

  const SaleInLots({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CapitalGainsParameter>();
    return Obx(() {
      if (controller.param[index]["sell_type"] == "분양권(2020년 이전 취득)" ||
          controller.param[index]["sell_type"] == "분양권(2021년 이후 취득)") {
        return CustomPrice(
          index: index,
          keyValue: "sale_cost",
          title: "분양가액",
          tooltip: "최초 분양가액을 입력해 주세요.",
          controller: controller,
        );
      } else {
        controller.param[index].removeWhere((key, value) => key == "sale_cost");
      }

      return Container();
    });
  }
}
