import 'package:capgain/widgets/custom_dropdown.dart';
import 'package:capgain/widgets/custom_oxdropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'param_controller.dart';
import 'widgets/custom_datepicker.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; // 달력 한글 출력용

import 'package:responsive_framework/responsive_framework.dart';

import 'widgets/special_tax_dropdowns.dart';
import 'widgets/rent_house.dart';
import 'widgets/before_reconstruction.dart';
import 'widgets/common_additional_info.dart';
import 'widgets/conditional_date.dart';
import 'widgets/sale_in_lots.dart';
import 'widgets/base_info.dart';
import 'widgets/rural_house.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final mainController = Get.put(CapitalGainsParameter());
  final customController = Get.put(MyCustomParameter());

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    mainController.setParam(0, "init", DateTime.now());
    mainController.setParam(1, "init", DateTime.now());
    mainController.setParam(2, "init", DateTime.now());
    mainController.setParam(3, "init", DateTime.now());
    customController.setParam(1, "init", DateTime.now());
    customController.setParam(2, "init", DateTime.now());
    customController.setParam(3, "init", DateTime.now());
    return GetMaterialApp(
      theme: ThemeData(textTheme: GoogleFonts.notoSansTextTheme()),
      builder: (context, child) => ResponsiveWrapper.builder(child,
          maxWidth: 1200,
          minWidth: 480,
          defaultScale: true,
          breakpoints: [
            ResponsiveBreakpoint.resize(480, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: TABLET),
            ResponsiveBreakpoint.resize(1000, name: DESKTOP),
          ],
          background: Container(color: Color(0x9B2A9974))),
      // ignore: prefer_const_literals_to_create_immutables
      localizationsDelegates: [
        // 달력 한글 출력용
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      // ignore: prefer_const_literals_to_create_immutables
      supportedLocales: [
        // 달력 한글 출력용
        const Locale('ko', 'KR'),
        // include country code too
      ],
      home: CapitalGainsTaxPage(),
    );
  }
}

class CapitalGainsTaxPage extends StatelessWidget {
  const CapitalGainsTaxPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                  index: 0, keyValue: "주택 수", contents: ["1", "2", "3"]),
              // 양도예정일
              CustomDatePicker(index: 0, keyValue: "양도예정일"),
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
          ConditionalDate(index: index), // 6 취득일 등
          CommonAdditionalInfo(index: index), // 7~10 공통 추가정보
          // 11~13 자동파악(생략)
          BeforeReconstruction(index: index), // 14~18 취득시 종류가 재건축전 주택일 때만

          if (controller.param[index]["취득 원인"] != null &&
              controller.param[index]["취득 원인"] == "상속") ...[
            CustomOXDropdownButton(index: index, keyValue: "선순위 상속주택")
          ], // 19 선순위 상속주택

          SaleInLots(index: index), // 20 분양가액
          RentHouse(index: index), // 21 임대주택
          RuralHouse(index: index), // 22 농어촌주택
          SpecialTaxDropdowns(index: index) // 23 조특법
        ],
      );
    });
  }
}
