import 'package:capgain/common_widgets/custom_dropdown.dart';
import 'package:capgain/common_widgets/custom_oxdropdown.dart';
import 'package:capgain/common_widgets/custom_price.dart';
import 'package:capgain/param_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:capgain/common_widgets/custom_percent.dart';
import 'package:capgain/common_widgets/custom_address.dart';

class HoldingTaxPage extends StatelessWidget {
  final holdingController = Get.put(HoldingController());

  HoldingTaxPage({super.key});

  @override
  Widget build(BuildContext context) {
    holdingController.setParam(0, "init", "init");
    holdingController.setParam(1, "init", "init");
    holdingController.setParam(2, "init", "init");
    holdingController.setParam(3, "init", "init");
    holdingController.setParam(4, "init", "init");
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
  final controller = Get.find<HoldingController>();

  Contents({super.key});
  @override
  Widget build(BuildContext context) {
    List<String> owners = const [
      "본인",
      "가족 구성원 A",
      "가족 구성원 B",
      "가족 구성원 C",
      "가족 구성원 D"
    ];
    return Obx(() {
      print(controller.param.value);
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomDropdownButton(
              index: 0,
              keyValue: "주택수 선택",
              contents: const [
                "1세대 1주택",
                "1세대 2주택",
                "1세대 3주택",
                "1세대 4주택",
                "1세대 5주택"
              ],
              controller: controller),
          Obx(() {
            print(controller.param.value);
            if (controller.param[0]["주택수 선택"] != null &&
                controller.param[0]["주택수 선택"] == "1세대 1주택") {
              return Column(children: [
                CustomAddress(index: 0, controller: controller),
                CustomDropdownButton(
                    index: 0,
                    keyValue: "소유주",
                    contents: owners,
                    controller: controller)
              ]);
            }
            return Container();
          }),
          Obx(() {
            print(controller.param.value);
            if (controller.param[0]["주택수 선택"] != null &&
                controller.param[0]["주택수 선택"] == "1세대 2주택") {
              return Column(children: [
                CustomAddress(index: 0, controller: controller),
                CustomDropdownButton(
                    index: 0,
                    keyValue: "소유주",
                    contents: owners,
                    controller: controller),
                CustomAddress(index: 1, controller: controller),
                CustomDropdownButton(
                    index: 1,
                    keyValue: "소유주",
                    contents: owners,
                    controller: controller),
              ]);
            }
            return Container();
          }),
          Obx(() {
            print(controller.param.value);
            if (controller.param[0]["주택수 선택"] != null &&
                controller.param[0]["주택수 선택"] == "1세대 3주택") {
              return Column(children: [
                CustomAddress(index: 0, controller: controller),
                CustomDropdownButton(
                    index: 0,
                    keyValue: "소유주",
                    contents: owners,
                    controller: controller),
                CustomAddress(index: 1, controller: controller),
                CustomDropdownButton(
                    index: 1,
                    keyValue: "소유주",
                    contents: owners,
                    controller: controller),
                CustomAddress(index: 2, controller: controller),
                CustomDropdownButton(
                    index: 2,
                    keyValue: "소유주",
                    contents: owners,
                    controller: controller),
              ]);
            }
            return Container();
          }),
          Obx(() {
            print(controller.param.value);
            if (controller.param[0]["주택수 선택"] != null &&
                controller.param[0]["주택수 선택"] == "1세대 4주택") {
              return Column(children: [
                CustomAddress(index: 0, controller: controller),
                CustomDropdownButton(
                    index: 0,
                    keyValue: "소유주",
                    contents: owners,
                    controller: controller),
                CustomAddress(index: 1, controller: controller),
                CustomDropdownButton(
                    index: 1,
                    keyValue: "소유주",
                    contents: owners,
                    controller: controller),
                CustomAddress(index: 2, controller: controller),
                CustomDropdownButton(
                    index: 2,
                    keyValue: "소유주",
                    contents: owners,
                    controller: controller),
                CustomAddress(index: 3, controller: controller),
                CustomDropdownButton(
                    index: 3,
                    keyValue: "소유주",
                    contents: owners,
                    controller: controller),
              ]);
            }
            return Container();
          }),
          Obx(() {
            print(controller.param.value);
            if (controller.param[0]["주택수 선택"] != null &&
                controller.param[0]["주택수 선택"] == "1세대 5주택") {
              return Column(children: [
                CustomAddress(index: 0, controller: controller),
                CustomDropdownButton(
                    index: 0,
                    keyValue: "소유주",
                    contents: owners,
                    controller: controller),
                CustomAddress(index: 1, controller: controller),
                CustomDropdownButton(
                    index: 1,
                    keyValue: "소유주",
                    contents: owners,
                    controller: controller),
                CustomAddress(index: 2, controller: controller),
                CustomDropdownButton(
                    index: 2,
                    keyValue: "소유주",
                    contents: owners,
                    controller: controller),
                CustomAddress(index: 3, controller: controller),
                CustomDropdownButton(
                    index: 3,
                    keyValue: "소유주",
                    contents: owners,
                    controller: controller),
                CustomAddress(index: 4, controller: controller),
                CustomDropdownButton(
                    index: 4,
                    keyValue: "소유주",
                    contents: owners,
                    controller: controller),
              ]);
            }
            return Container();
          }),
          CustomPercent(index: 0, keyValue: "주택지분", controller: controller),
          if (controller.param[0]["주택수 선택"] != null &&
              controller.param[0]["주택수 선택"] != "1세대 1주택") ...[
            CustomOXDropdownButton(
                index: 0, keyValue: "1세대 1주택으로 보는경우", controller: controller)
          ],
          if (controller.param[0]["주택수 선택"] != null &&
              controller.param[0]["주택수 선택"] == "1세대 1주택") ...[
            CustomDropdownButton(
                index: 0,
                keyValue: "보유기간",
                contents: const ["5년미만", "5년이상", "10년이상", "15년이상"],
                controller: controller),
            CustomDropdownButton(
                index: 0,
                keyValue: "연령입력",
                contents: const ["60세미만", "60세이상", "65세이상", "70세이상"],
                controller: controller)
          ],
          CustomPrice(index: 0, keyValue: "직전년도 재산세액", controller: controller),
          CustomPrice(
              index: 0, keyValue: "직전년도 종합부동산세액", controller: controller),
        ],
      );
    });
  }
}
