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

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final mainController = Get.put(CapitalGainsParameter());
  final customController = Get.put(MyCustomParameter());

  @override
  Widget build(BuildContext context) {
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
      localizationsDelegates: [
        // 달력 한글 출력용
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(30.0),
          child: ListView(
            children: const [Contents()],
          ),
        ),
      ),
    );
  }
}

class Contents extends StatelessWidget {
  const Contents({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CapitalGainsParameter>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // 양도예정일
        CustomDatePicker("양도예정일"),

        BaseInfo(controller: controller), // 1~5 기본 정보
        ConditionalDate(controller: controller), // 6 취득일 등
        CommonAdditionalInfo(), // 7~10 공통 추가정보
        // 11~13 자동파악(생략)
        BeforeReconstruction(
            controller: controller), // 14~18 취득시 종류가 재건축전 주택일 때만
        // 19 선순위 상속주택 TODO
        SaleInLots(controller: controller), // 20 분양가액
        RentHouse(controller: controller), // 21 임대주택
        // 22 농어촌주택 TODO
        SpecialTaxDropdowns(controller: controller) // 23 조특법
      ],
    );
  }
}
