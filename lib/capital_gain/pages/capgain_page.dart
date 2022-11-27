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
import 'package:capgain/widgetsize.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:capgain/colorbase.dart';
import 'package:capgain/typography.dart';
import 'package:capgain/spacing.dart';

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
          padding: EdgeInsets.all(30.0),
          child: ListView(
            children: [
              ResponsiveRowColumn(
                rowCrossAxisAlignment: CrossAxisAlignment.start,
                layout: ResponsiveRowColumnType.COLUMN,
                children: [
                  ResponsiveRowColumnItem(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30.0, bottom: 30.0),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: borderColor)),
                        child: Text(
                          "1. 기초정보",
                          textAlign: TextAlign.left,
                          style: headlineTextStyle,
                        ),
                      ),
                    ),
                  ), // 제목
                  ResponsiveRowColumnItem(
                    child: Container(
                      height: baseHeight,
                      margin: marginBottom24,
                      child: Row(
                        children: [
                          Flexible(
                            flex: 9,
                            child: CustomDropdownButton(
                                index: 0,
                                keyValue: "현재 보유주택 수",
                                title: "현재 보유주택 수",
                                contents: const ["1", "2", "3"],
                                tooltip: "세대원의 총 보유주택 수 입력",
                                controller: controller),
                          ),
                          Flexible(flex: 1, child: Container()),
                          Flexible(
                            // 양도예정일
                            flex: 9,
                            child: CustomDatePicker(
                                index: 0,
                                keyValue: "sell_date",
                                title: "양도 예정일",
                                controller: controller),
                          )
                        ],
                      ),
                    ),
                  ),
                  ResponsiveRowColumnItem(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30.0, bottom: 30.0),
                      child: Divider(),
                    ),
                  ), // 제목
                  ResponsiveRowColumnItem(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30.0, bottom: 30.0),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: borderColor)),
                        child: Text(
                          "2. 보유주택별 기본정보",
                          textAlign: TextAlign.left,
                          style: headlineTextStyle,
                        ),
                      ),
                    ),
                  ), // 제목
                  ResponsiveRowColumnItem(
                    child: Obx(() {
                      print(controller.param);
                      if (controller.param[0]["현재 보유주택 수"] != null) {
                        if (controller.param[0]["현재 보유주택 수"] == "1") {
                          contents = [
                            Container(
                              alignment: Alignment.centerRight,
                              child: Text("* 첫번째 입력한 주택의 정보가 양도세 계산의 대상입니다.",
                                  style: TextStyle(color: Colors.red)),
                            ),
                            Contents(index: 1)
                          ];
                        }
                        if (controller.param[0]["현재 보유주택 수"] == "2") {
                          contents = [
                            Container(
                              alignment: Alignment.centerRight,
                              child: Text("* 첫번째 입력한 주택의 정보가 양도세 계산의 대상입니다.",
                                  style: TextStyle(color: Colors.red)),
                            ),
                            Contents(index: 1),
                            Contents(index: 2)
                          ];
                        }
                        if (controller.param[0]["현재 보유주택 수"] == "3") {
                          contents = [
                            Container(
                              alignment: Alignment.centerRight,
                              child: Text("* 첫번째 입력한 주택의 정보가 양도세 계산의 대상입니다.",
                                  style: TextStyle(color: Colors.red)),
                            ),
                            Contents(index: 1),
                            Contents(index: 2),
                            Contents(index: 3)
                          ];
                        }
                      }
                      return Column(children: contents);
                    }),
                  )
                ],
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: calculateBacgroundColor),
                  onPressed: () {},
                  child: Text("양도소득세 계산결과 확인"))
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
      controller.param;
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
              margin: EdgeInsets.only(top: 30),
              child: Text("[$index]번째 주택 정보",
                  style: TextStyle(color: Colors.black))),
          BaseInfo(index: index), // 1~5 기본 정보
          ConditionalDate(index: index, controller: controller), // 6 취득일 등
          CommonAdditionalInfo(
              index: index, controller: controller), // 7~10 공통 추가정보
          // 11~14 자동파악(생략)
          BeforeReconstruction(index: index), // 15~20 취득시 종류가 재건축전 주택일 때만

          if (controller.param[index]["buy_cause"] != null &&
              controller.param[index]["buy_cause"] == "상속") ...[
            CustomOXDropdownButton(
                index: index, keyValue: "선순위 상속주택", controller: controller),
            CustomOXDropdownButton(
                index: index, keyValue: "상속시 동일세대원 여부", controller: controller),
            CustomOXDropdownButton(
                index: index, keyValue: "소수지분 상속주택", controller: controller),
          ], // 21~23 선순위 상속주택

          Tooltip(
              message: "최초 분양가액을 입력해 주세요.",
              child: SaleInLots(index: index)), // 24 분양가액
          CustomOXDropdownButton(
              index: index, keyValue: "임대주택 여부", controller: controller),
          Container(
              margin: marginBottom24,
              child: RentHouse(index: index)), // 25 임대주택
          Container(
              margin: marginBottom24,
              child: RuralHouse(index: index)), // 26 농어촌주택
          Container(
              margin: marginBottom24,
              child: SpecialTaxDropdowns(index: index)), // 27 조특법
          Container(
              margin: EdgeInsets.symmetric(vertical: 30.0), child: Divider()),
        ],
      );
    });
  }
}
