import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; // 달력 한글 출력용
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:taxai/capital_gain/pages/capgain_page.dart';
import 'package:taxai/capital_gain/pages/capgain_result_page.dart';
import 'package:taxai/estate_tax/pages/estate_page.dart';
import 'package:taxai/estate_tax/pages/estate_result_page.dart';
import 'package:taxai/holding_tax/pages/holding_page.dart';
import 'package:taxai/homepage/pages/home_page.dart';
import 'package:taxai/homepage/pages/intro_page.dart';

import 'amplifyconfiguration.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _configureAmplify();
  runApp(MyApp());
}

Future<void> _configureAmplify() async {
  try {
    await Amplify.addPlugin(AmplifyAuthCognito());

    await Amplify.configure(amplifyconfig);
  } catch (e) {
    print('An error occurred while configuring Amplify: $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
          '/capgainresult': (BuildContext context) {
            return AuthenticatedView(child: CapgainResultPage());
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
            defaultScale: true,
            minWidth: 480,
            defaultName: MOBILE,
            breakpoints: [
              const ResponsiveBreakpoint.autoScale(480, name: MOBILE),
              const ResponsiveBreakpoint.resize(600, name: MOBILE),
              const ResponsiveBreakpoint.resize(850, name: TABLET),
              const ResponsiveBreakpoint.resize(1080, name: DESKTOP),
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
