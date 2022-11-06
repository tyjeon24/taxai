import 'dart:convert';

import 'package:capgain/common_widgets/custom_dropdown.dart';
import 'package:capgain/common_widgets/custom_oxdropdown.dart';
import 'package:capgain/common_widgets/custom_price.dart';
import 'package:capgain/param_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class HoldingTaxPage extends StatelessWidget {
  final estateController = Get.put(EstateController());

  @override
  Widget build(BuildContext context) {
    estateController.setParam(0, "init", "init");
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Color(0xFFF6F6F8),
          margin: EdgeInsets.all(30.0),
          child: ListView(
            children: [
              Column(children: [Contents()])
            ],
          ),
        ),
      ),
    );
  }
}

class Contents extends StatelessWidget {
  final controller = Get.find<EstateController>();

  Contents({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      print(controller.param.value);
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomDropdownButton(
              index: 0,
              keyValue: "연령입력",
              contents: const ["60세미만", "60세이상", "65세이상", "70세이상"],
              controller: controller)
        ],
      );
    });
  }
}
