import 'package:capgain/capital_gain/pages/components/base_info.dart';
import 'package:capgain/capital_gain/pages/components/before_reconstruction.dart';
import 'package:capgain/capital_gain/pages/components/common_additional_info.dart';
import 'package:capgain/capital_gain/pages/components/conditional_date.dart';
import 'package:capgain/capital_gain/pages/components/rent_house.dart';
import 'package:capgain/capital_gain/pages/components/rural_house.dart';
import 'package:capgain/capital_gain/pages/components/sale_in_lots.dart';
import 'package:capgain/capital_gain/pages/components/special_tax_dropdowns.dart';
import 'package:capgain/common_widgets/custom_datepicker.dart';
import 'package:capgain/common_widgets/custom_dropdown.dart';
import 'package:capgain/common_widgets/custom_oxdropdown.dart';
import 'package:capgain/param_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CapitalGainsTaxPage extends StatelessWidget {
  final mainController = Get.put(CapitalGainsParameter());
  final customController = Get.put(MyCustomParameter());

  CapitalGainsTaxPage({super.key});

  @override
  Widget build(BuildContext context) {
    mainController.setParam(0, "init", DateTime.now());
    mainController.setParam(1, "init", DateTime.now());
    mainController.setParam(2, "init", DateTime.now());
    mainController.setParam(3, "init", DateTime.now());
    customController.setParam(1, "init", DateTime.now());
    customController.setParam(2, "init", DateTime.now());
    customController.setParam(3, "init", DateTime.now());
    final controller = Get.find<CapitalGainsParameter>();
    List<Widget> contents = [];
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Color(0xFFF6F6F8),
          margin: EdgeInsets.all(30.0),
          child: ListView(
            children: [
              CustomDropdownButton(
                  index: 0,
                  keyValue: "주택 수",
                  contents: const ["1", "2", "3"],
                  controller: controller),
              // 양도예정일
              CustomDatePicker(
                  index: 0, keyValue: "양도예정일", controller: controller),
              Obx(() {
                if (controller.param[0]["주택 수"] != null) {
                  if (controller.param[0]["주택 수"] == "1") {
                    contents = [Contents(index: 1)];
                  }
                  if (controller.param[0]["주택 수"] == "2") {
                    contents = [Contents(index: 1), Contents(index: 2)];
                  }
                  if (controller.param[0]["주택 수"] == "3") {
                    contents = [
                      Contents(index: 1),
                      Contents(index: 2),
                      Contents(index: 3)
                    ];
                  }
                }
                return Column(children: contents);
              })
            ],
          ),
        ),
      ),
    );
  }
}

class Contents extends StatelessWidget {
  Contents({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  final controller = Get.find<CapitalGainsParameter>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      print(controller.param.value);
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BaseInfo(index: index), // 1~5 기본 정보
          ConditionalDate(index: index, controller: controller), // 6 취득일 등
          CommonAdditionalInfo(
              index: index, controller: controller), // 7~10 공통 추가정보
          // 11~14 자동파악(생략)
          BeforeReconstruction(index: index), // 15~20 취득시 종류가 재건축전 주택일 때만

          if (controller.param[index]["취득 원인"] != null &&
              controller.param[index]["취득 원인"] == "상속") ...[
            Tooltip(
              message: """피상속인의 주택이 1주택이라면 o를 입력해주세요
피상속인이 2주택 이상을 상속하는 경우 피상속인 기준으로 아래의 요건순서에 따라
선순위에 해당하는 주택인지 확인해주세요
① 피상속인이 소유한 기간이 가장 긴 1주택
② 피상속인이 거주한 기간이 가장 긴 1주택
③ 피상속인이 상속개시 당시 거주한 1주택
④ 기준시가가 가장 높은 1주택(기준시가가 같은 경우에는 상속인이 선택하는 1주택)""",
              child: CustomOXDropdownButton(
                  index: index, keyValue: "선순위 상속주택", controller: controller),
            ),
            Tooltip(
              message: "상속 당시 피상속인과 주택을 소유한 상속인과 동일세대원인지 여부",
              child: CustomOXDropdownButton(
                  index: index,
                  keyValue: "상속시 동일세대원 여부",
                  controller: controller),
            ),
            Tooltip(
              message: """"공동으로 상속받은 주택 중 지분이 가장 큰 상속인이 아닌경우 o를 입력하고, 
단독명의나 지분이 가장 큰 상속인 인경우 x를 입력하세요.

지분이 큰 상속인이 2명이상인 경우 다음 순서에 따라 지분이 가장 큰 상속인으로 봅니다
1. 당해 주택에 거주하는 자
2. 최연장자"
""",
              child: CustomOXDropdownButton(
                  index: index, keyValue: "소수지분 상속주택", controller: controller),
            ),
          ], // 21~23 선순위 상속주택

          Tooltip(
              message: "최초 분양가액을 입력해 주세요.",
              child: SaleInLots(index: index)), // 24 분양가액
          RentHouse(index: index), // 25 임대주택
          RuralHouse(index: index), // 26 농어촌주택
          SpecialTaxDropdowns(index: index) // 27 조특법
        ],
      );
    });
  }
}
