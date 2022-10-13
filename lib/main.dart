import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; // 달력 한글 출력용

import 'package:responsive_framework/responsive_framework.dart';
import 'capgain_page.dart';
import 'home_page.dart';
import 'package:url_strategy/url_strategy.dart';
import 'capgain_page.dart';
import 'holding_page.dart';
import 'callback_page.dart';

void main() {
  setPathUrlStrategy();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Base'),
      getPages: [
        GetPage(name: '/capgain', page: () => CapitalGainsTaxPage()),
        GetPage(name: '/holding', page: () => HoldingTaxPage()),
        GetPage(name: '/callback', page: () => CallbackPage())
      ],
      builder: (context, child) => ResponsiveWrapper.builder(child,
          maxWidth: 1920,
          minWidth: 400,
          defaultScale: true,
          breakpoints: const [
            ResponsiveBreakpoint.resize(400, name: MOBILE),
            ResponsiveBreakpoint.autoScale(600, name: TABLET),
            ResponsiveBreakpoint.resize(800, name: DESKTOP),
          ],
          background: Container(
              color: Color.fromARGB(255, 255, 255, 255))), // 0x9B2A9974
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
      ],
      home: Homepage(),
    );
  }
}
