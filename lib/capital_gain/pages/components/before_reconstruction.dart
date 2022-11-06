import 'package:capgain/common_widgets/custom_datepicker.dart';
import 'package:capgain/common_widgets/custom_dropdown.dart';
import 'package:capgain/common_widgets/custom_price.dart';
import 'package:capgain/param_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BeforeReconstruction extends StatelessWidget {
  const BeforeReconstruction({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CapitalGainsParameter>();
    return Obx(() {
      if (controller.param[index]["취득시 종류"] != "재건축전 주택") {
        return Container();
      }

      return Column(
        children: [
          CustomDatePicker(
              index: index, keyValue: "관리처분계획인가일", controller: controller),
          CustomDatePicker(
              index: index, keyValue: "사업시행인가일", controller: controller),
          CustomPrice(
              index: index, keyValue: "종전 주택의 평가액", controller: controller),
          CustomPrice(
              index: index,
              keyValue: "납부한 분담금 또는 지급받은 청산금",
              controller: controller),
          CustomDropdownButton(
              index: index,
              keyValue: "신주택 거주기간",
              contents: const [
                "1년미만",
                "2년미만",
                "3년이상",
                "4년이상",
                "5년이상",
                "6년이상",
                "7년이상",
                "8년이상",
                "9년이상",
                "10년이상"
              ],
              controller: controller)
        ],
      );
    });
  }
}
