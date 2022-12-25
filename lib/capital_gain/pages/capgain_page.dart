import 'dart:convert';

import 'package:taxai/capital_gain/pages/components/base_info.dart';
import 'package:taxai/capital_gain/pages/components/before_reconstruction.dart';
import 'package:taxai/capital_gain/pages/components/common_additional_info.dart';
import 'package:taxai/capital_gain/pages/components/conditional_date.dart';
import 'package:taxai/capital_gain/pages/components/rent_house.dart';
import 'package:taxai/capital_gain/pages/components/rural_house.dart';
import 'package:taxai/capital_gain/pages/components/sale_in_lots.dart';
import 'package:taxai/capital_gain/pages/components/special_tax_dropdowns.dart';
import 'package:taxai/common_widgets/custom_datepicker.dart';
import 'package:taxai/common_widgets/custom_dropdown.dart';
import 'package:taxai/common_widgets/custom_oxdropdown.dart';
import 'package:taxai/components/api_endpoints.dart';
import 'package:taxai/components/colorbase.dart';
import 'package:taxai/components/param_controller.dart';
import 'package:taxai/components/spacing.dart';
import 'package:taxai/components/typography.dart';
import 'package:taxai/components/widgetsize.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

Future calculateCapgain() async {
  var dio = Dio();

  final controller = Get.find<CapitalGainsParameter>();

  final response = await dio.request(
    capgainEndpoint,
    options: Options(method: 'GET'),
    queryParameters: {
      "input": json.encode([
        json.encode(controller.param[1]),
        json.encode(controller.param[2]),
        json.encode(controller.param[3])
      ]),
    },
  );

  if (response.statusCode == 200) {
    final result = response.data; // json으로 변경

    return result;
  } else {
    throw Exception("요청 중 오류가 발생했습니다.");
  }
}

class CapitalGainsTaxPage extends StatelessWidget {
  final mainController = Get.put(CapitalGainsParameter());
  final customController = Get.put(MyCustomParameter());

  CapitalGainsTaxPage({super.key});

  @override
  Widget build(BuildContext context) {
    mainController.setParam(0, "", "");
    mainController.setParam(1, "", DateTime.now().toString());
    mainController.setParam(2, "", "");
    mainController.setParam(3, "", "");
    mainController.setParam(4, "result", "");
    customController.setParam(1, "", "");
    customController.setParam(2, "", "");
    customController.setParam(3, "", "");
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
                                index: 1,
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
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                              title: Text("계산중..."),
                              content: SizedBox(
                                width: double.maxFinite,
                                child: FutureBuilder(
                                    future: calculateCapgain(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        SchedulerBinding.instance
                                            .addPostFrameCallback((_) =>
                                                controller.setParam(4, "result",
                                                    snapshot.data));

                                        return TextButton(
                                            child: Text('${snapshot.data}'),
                                            onPressed: () => SchedulerBinding
                                                .instance
                                                .addPostFrameCallback((_) =>
                                                    Get.toNamed(
                                                        "/capgainresult")));
                                      }
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return CircularProgressIndicator();
                                      }
                                      return Container();
                                    }),
                              ));
                        });
                  },
                  child: Text("양도소득세 계산결과 확인"))
            ],
          ),
        ),
      ),
    );
  }
}

class Contents extends StatelessWidget {
  final int index;

  final controller = Get.find<CapitalGainsParameter>();
  final customController = Get.find<MyCustomParameter>();

  Contents({
    Key? key,
    required this.index,
  }) : super(key: key);
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
                index: index,
                title: "선순위 상속주택",
                keyValue: "priority",
                controller: controller),
            CustomOXDropdownButton(
                index: index,
                title: "상속시 동일세대원 여부",
                keyValue: "same_member",
                controller: controller),
            CustomOXDropdownButton(
                index: index,
                title: "소수지분 상속주택",
                keyValue: "minority",
                controller: controller),
          ], // 21~23 선순위 상속주택

          Tooltip(
              message: "최초 분양가액을 입력해 주세요.",
              child: SaleInLots(index: index)), // 24 분양가액
          CustomOXDropdownButton(
              index: index,
              title: "임대주택 여부",
              keyValue: "임대주택 여부",
              controller: controller),
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
