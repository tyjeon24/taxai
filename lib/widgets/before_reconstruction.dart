import 'package:flutter/material.dart';
import 'custom_datepicker.dart';
import 'custom_price.dart';
import '../param_controller.dart';
import 'package:get/get.dart';

class BeforeReconstruction extends StatelessWidget {
  const BeforeReconstruction({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final CapitalGainsParameter controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.param.value["취득시 종류"] != "재건축전 주택") {
        return Container();
      }

      return Column(
        children: [
          CustomDatePicker("관리처분계획인가일"),
          CustomDatePicker("사업시행인가일"),
          CustomPrice("종전 주택의 평가액"),
          CustomPrice("납부한 분담금 또는 지급받은 청산금"),
        ],
      );
    });
  }
}
