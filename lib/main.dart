import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:capgain/capital_gain/pages/capgain_page.dart';
import 'package:capgain/estate_tax/pages/estate_page.dart';
import 'package:capgain/estate_tax/pages/estate_result_page.dart';
import 'package:capgain/holding_tax/pages/holding_page.dart';
import 'package:capgain/homepage/pages/home_page.dart';
import 'package:capgain/homepage/pages/intro_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; // 달력 한글 출력용
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'amplifyconfiguration.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  void _configureAmplify() async {
    try {
      await Amplify.addPlugin(AmplifyAuthCognito());
      await Amplify.configure(amplifyconfig);
      // ignore: avoid_print
      print('Successfully configured');
    } on Exception catch (e) {
      // ignore: avoid_print
      print('Error configuring Amplify: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Authenticator(
      child: GetMaterialApp(
        initialRoute: '/',
        routes: {
          '/': (BuildContext context) => Homepage(),
          '/intro': (BuildContext context) => IntroPage(),
          '/login': (BuildContext context) {
            return AuthenticatedView(child: Homepage());
          },
          '/capgain': (BuildContext context) {
            return AuthenticatedView(child: CapitalGainsTaxPage());
          },
          '/holding': (BuildContext context) {
            return AuthenticatedView(child: HoldingTaxPage());
          },
          '/estate': (BuildContext context) {
            return AuthenticatedView(child: EstatePage());
          },
          '/estateresult': (BuildContext context) {
            return AuthenticatedView(child: EstateResultPage());
          },
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Base'),
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
        // 달력 한글 출력용 부분 시작
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        // ignore: prefer_const_literals_to_create_immutables
        supportedLocales: [
          const Locale('ko', 'KR'),
        ],
        // 달력 한글 출력용 부분 끝
      ),
    );
  }
}
