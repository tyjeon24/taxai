import 'package:taxai/common_widgets/animated_button.dart';
import 'package:taxai/components/colorbase.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart' hide Condition;
import 'package:responsive_framework/responsive_framework.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';

class GetAppBar extends StatelessWidget {
  final double _width;

  const GetAppBar({
    Key? key,
    required double width,
  })  : _width = width,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDesktop = (_width > 600);

    if (isDesktop) {
      return AppBar(
        backgroundColor: color2,
        leading: SvgPicture.asset("assets/icons/logo_color.svg",
            color: color, semanticsLabel: '로고', fit: BoxFit.contain),
        elevation: 0,
        title: Text(
          "TAXAI",
          style: TextStyle(
              fontSize: 32, color: color, fontWeight: FontWeight.bold),
        ),
        actions: [
          ResponsiveVisibility(
              visible: false,
              visibleWhen: const [Condition.largerThan(name: TABLET)],
              child: TextButton(
                  child: Text("TAXAI 소개    "),
                  onPressed: () => Get.toNamed("/intro"))),
          ResponsiveVisibility(
              visible: false,
              visibleWhen: const [Condition.largerThan(name: TABLET)],
              child: TextButton(child: Text("공지사항    "), onPressed: () {})),
          ResponsiveVisibility(
              visible: false,
              visibleWhen: const [Condition.largerThan(name: TABLET)],
              child: TextButton(child: Text("기술 문의    "), onPressed: () {})),
          ResponsiveVisibility(
              visible: false,
              visibleWhen: const [Condition.largerThan(name: TABLET)],
              child: TextButton(child: Text("제휴 문의    "), onPressed: () {})),
          ResponsiveVisibility(
              visible: false,
              visibleWhen: const [Condition.largerThan(name: TABLET)],
              child: TextButton(child: Text("특허 정보    "), onPressed: () {})),
          ResponsiveVisibility(
              visible: false,
              visibleWhen: const [Condition.largerThan(name: TABLET)],
              child: TextButton(
                  child: Text("로그인    "),
                  onPressed: () => Get.toNamed("/login")))
        ],
      );
    }

    return AppBar(
      backgroundColor: color2,
      leading: SvgPicture.asset("assets/icons/logo_color.svg",
          color: color, semanticsLabel: '로고', fit: BoxFit.contain),
      elevation: 0,
      title: Text("TAXAI",
          style: TextStyle(
              fontSize: 32, color: color, fontWeight: FontWeight.bold)),
      iconTheme: IconThemeData(color: color),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    double widgetHeight = MediaQuery.of(context).size.height;
    double widgetWidth = MediaQuery.of(context).size.width;

    var mobileWidgets = [
      SizedBox(width: widgetWidth, height: widgetHeight * 0.05),
      SizedBox(
        width: widgetWidth,
        height: widgetHeight,
        child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Image.asset('assets/homepage/mobile1.png')),
      ),
      SizedBox(
        width: widgetWidth,
        height: widgetHeight,
        child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Image.asset('assets/homepage/mobile2.png')),
      ),
      SizedBox(
        width: widgetWidth,
        height: widgetHeight,
        child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Image.asset('assets/homepage/mobile3.png')),
      ),
      SizedBox(
        width: widgetWidth,
        height: widgetHeight,
        child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Image.asset('assets/homepage/mobile4.png')),
      ),
      SizedBox(
        width: widgetWidth,
        height: widgetHeight,
        child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Image.asset('assets/homepage/mobile5.png')),
      ),
      SizedBox(
        width: widgetWidth,
        height: widgetHeight * 0.9,
        child: Column(
          children: [
            Flexible(flex: 3, fit: FlexFit.tight, child: SizedBox()),
            SizedBox(
              height: widgetHeight * 0.1,
              child: FittedBox(
                child: Text("AI 세금 계산기",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 10, color: color)),
              ),
            ),
            Flexible(flex: 1, fit: FlexFit.tight, child: SizedBox()),
            Flexible(
              flex: 3,
              fit: FlexFit.tight,
              child: SizedBox(
                width: widgetWidth * 0.7,
                child: AnimatedButton(
                  color: color2,
                  textString: '양도세\nAI 판단 계산기',
                  icon: Image.asset("assets/animated_money.gif",
                      height: widgetHeight * 0.1),
                  routes: "/capgain",
                ),
              ),
            ),
            Flexible(flex: 1, fit: FlexFit.tight, child: SizedBox()),
            Flexible(
              flex: 3,
              fit: FlexFit.tight,
              child: SizedBox(
                width: widgetWidth * 0.7,
                child: AnimatedButton(
                  color: color2,
                  textString: "보유세\nAI 판단 계산기",
                  icon: Image.asset("assets/animated_document.gif",
                      height: widgetHeight * 0.1),
                  routes: "/holding",
                ),
              ),
            ),
            Flexible(flex: 1, fit: FlexFit.tight, child: SizedBox()),
            Flexible(
              flex: 3,
              fit: FlexFit.tight,
              child: SizedBox(
                width: widgetWidth * 0.7,
                child: AnimatedButton(
                  color: color2,
                  textString: "상속세\nAI 판단 계산기",
                  icon: Image.asset("assets/animated_inherit.gif",
                      height: widgetHeight * 0.1),
                  routes: "/estate",
                ),
              ),
            ),
            Flexible(flex: 3, fit: FlexFit.tight, child: SizedBox()),
          ],
        ),
      ),
      SizedBox(
        width: widgetWidth,
        height: widgetHeight * 0.9,
        child: Column(
          children: [
            Flexible(flex: 3, fit: FlexFit.tight, child: SizedBox()),
            SizedBox(
              height: widgetHeight * 0.1,
              child: FittedBox(
                child: Text("TAXAI 세금 컨설팅",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 10, color: color)),
              ),
            ),
            Flexible(flex: 1, fit: FlexFit.tight, child: SizedBox()),
            Flexible(
              flex: 3,
              fit: FlexFit.tight,
              child: SizedBox(
                width: widgetWidth * 0.7,
                child: AnimatedButton(
                    color: color2,
                    textString: '양도소득세\nAI 컨설팅',
                    icon: Image.asset("assets/animtaed_consult.gif",
                        height: widgetHeight * 0.1)),
              ),
            ),
            Flexible(flex: 1, fit: FlexFit.tight, child: SizedBox()),
            Flexible(
              flex: 3,
              fit: FlexFit.tight,
              child: SizedBox(
                width: widgetWidth * 0.7,
                child: AnimatedButton(
                    color: color2,
                    textString: "매도 관련\nAI 컨설팅",
                    icon: Image.asset("assets/animtaed_consult.gif",
                        height: widgetHeight * 0.1)),
              ),
            ),
            Flexible(flex: 1, fit: FlexFit.tight, child: SizedBox()),
            Flexible(
              flex: 3,
              fit: FlexFit.tight,
              child: SizedBox(
                width: widgetWidth * 0.7,
                child: AnimatedButton(
                    color: color2,
                    textString: "기타 \nAI 컨설팅",
                    icon: Image.asset("assets/animtaed_consult.gif",
                        height: widgetHeight * 0.1)),
              ),
            ),
            Flexible(flex: 3, fit: FlexFit.tight, child: SizedBox()),
          ],
        ),
      ),
      SizedBox(
        width: widgetWidth,
        height: widgetHeight,
        child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Image.asset('assets/homepage/mobile6.png')),
      ),
      SizedBox(
        width: widgetWidth,
        height: widgetHeight * 0.6,
        child: SizedBox(),
      ),
      SizedBox(
        width: widgetWidth,
        height: widgetHeight * 0.4,
        child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Image.asset('assets/homepage/mobile7.png')),
      ),
    ];

    var desktopWidgets = [
      Container(
        width: widgetWidth,
        height: widgetHeight,
        child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Stack(alignment: Alignment.centerLeft, children: [
              Image.asset('assets/homepage/desktop1.png',
                  height: widgetHeight * 0.8),
              Image.asset('assets/homepage/desktop1_text.png',
                  height: widgetHeight * 0.4),
            ])),
      ),
      Container(
        width: widgetWidth,
        height: widgetHeight,
        margin: EdgeInsets.only(top: widgetHeight * 0.3),
        child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Stack(alignment: Alignment.centerLeft, children: [
              Image.asset('assets/homepage/desktop2.png',
                  height: widgetHeight * 0.8),
              Container(
                      padding: EdgeInsets.only(left: 30),
                      child: Image.asset('assets/homepage/desktop2_text.png',
                          height: widgetHeight * 0.4))
                  .animate(delay: 1000.ms)
                  .fadeIn(duration: 1000.ms, curve: Curves.easeOutQuad)
                  .slide(begin: Offset(-1, 0), end: Offset.zero),
            ])),
      ),
      Container(
          padding: EdgeInsets.all(30),
          width: widgetWidth * 0.7,
          height: widgetHeight * 0.8,
          child: Stack(alignment: Alignment.center, children: [
            Image.asset('assets/homepage/desktop3_1.png',
                height: widgetHeight * 0.8),
            Image.asset('assets/homepage/desktop3_2.png',
                    width: widgetWidth * 0.5, height: widgetHeight * 0.4)
                .animate(delay: 1000.ms)
                .fadeIn(duration: 1000.ms, curve: Curves.easeOutQuad)
                .slide(begin: Offset(0, -1), end: Offset.zero),
          ])),
      Container(
              width: widgetWidth * 0.5,
              height: widgetHeight * 0.5,
              padding: EdgeInsets.all(30),
              child: Image.asset('assets/homepage/desktop4.png',
                  width: widgetWidth * 0.5, height: widgetHeight * 0.5))
          .animate(delay: 1000.ms)
          .fadeIn(duration: 1000.ms, curve: Curves.easeOutQuad)
          .slide(begin: Offset(0, -1), end: Offset.zero),
      Container(
          width: widgetWidth,
          height: widgetHeight,
          padding: EdgeInsets.all(30),
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Stack(alignment: Alignment.centerLeft, children: [
              Image.asset('assets/homepage/desktop5_1.png',
                  height: widgetHeight * 0.8),
              Image.asset('assets/homepage/desktop5_2.png',
                      width: widgetWidth * 0.5, height: widgetHeight * 0.4)
                  .animate(delay: 1000.ms)
                  .fadeIn(duration: 1000.ms, curve: Curves.easeOutQuad)
                  .slide(begin: Offset(0, 1), end: Offset.zero),
            ]),
          )),
      Container(
        width: widgetWidth * 0.7,
        height: widgetHeight * 0.6,
        margin: EdgeInsets.all(30),
        child: ListView(
          shrinkWrap: true,
          children: [
            SizedBox(
              height: widgetHeight * 0.1,
              child: FittedBox(
                child: Text("AI 세금 계산기",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 10, color: color)),
              ),
            ),
            SizedBox(height: widgetHeight * 0.05),
            SizedBox(
              height: widgetHeight * 0.2,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Flexible(
                    flex: 5,
                    fit: FlexFit.tight,
                    child: SizedBox(height: widgetHeight * 0.2)),
                Flexible(
                  flex: 5,
                  fit: FlexFit.tight,
                  child: SizedBox(
                    height: widgetHeight * 0.15,
                    child: AnimatedButton(
                      color: color2,
                      textString: '양도세\nAI 판단 계산기',
                      icon: Image.asset("assets/animated_money.gif",
                          height: widgetHeight * 0.1),
                      routes: "/capgain",
                    ),
                  ),
                ),
                Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: SizedBox(height: widgetHeight * 0.2)),
                Flexible(
                  flex: 5,
                  fit: FlexFit.tight,
                  child: SizedBox(
                    height: widgetHeight * 0.15,
                    child: AnimatedButton(
                      color: color2,
                      textString: "보유세\nAI 판단 계산기",
                      icon: Image.asset("assets/animated_document.gif",
                          height: widgetHeight * 0.1),
                      routes: "/holding",
                    ),
                  ),
                ),
                Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: SizedBox(height: widgetHeight * 0.2)),
                Flexible(
                  flex: 5,
                  fit: FlexFit.tight,
                  child: SizedBox(
                    height: widgetHeight * 0.15,
                    child: AnimatedButton(
                      color: color2,
                      textString: "상속세\nAI 판단 계산기",
                      icon: Image.asset("assets/animated_inherit.gif",
                          height: widgetHeight * 0.1),
                      routes: "/estate",
                    ),
                  ),
                ),
                Flexible(flex: 5, fit: FlexFit.tight, child: SizedBox()),
              ]),
            ),
          ],
        ),
      )
          .animate(delay: 1000.ms)
          .fadeIn(duration: 1200.ms, curve: Curves.easeOutQuad)
          .slide(begin: Offset(0, 0.2), end: Offset.zero),
      Container(
        width: widgetWidth * 0.7,
        height: widgetHeight * 0.6,
        margin: EdgeInsets.all(30),
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: SizedBox(
                  height: widgetHeight * 0.1,
                  child: FittedBox(
                    child: Text("TAXAI 세금 컨설팅",
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 10, color: color)),
                  )),
            ),
            Flexible(flex: 1, child: SizedBox(height: widgetHeight * 0.05)),
            Flexible(
                flex: 1,
                child: SizedBox(
                  height: widgetHeight * 0.2,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                            flex: 5,
                            fit: FlexFit.tight,
                            child: SizedBox(height: widgetHeight * 0.2)),
                        Flexible(
                          flex: 5,
                          fit: FlexFit.tight,
                          child: SizedBox(
                            height: widgetHeight * 0.15,
                            child: AnimatedButton(
                                color: color2,
                                textString: "양도소득세\nAI 컨설팅",
                                icon: Image.asset("assets/animtaed_consult.gif",
                                    height: widgetHeight * 0.1)),
                          ),
                        ),
                        Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: SizedBox(height: widgetHeight * 0.2)),
                        Flexible(
                          flex: 5,
                          fit: FlexFit.tight,
                          child: SizedBox(
                            height: widgetHeight * 0.15,
                            child: AnimatedButton(
                                color: color2,
                                textString: "매도 관련\nAI 컨설팅",
                                icon: Image.asset("assets/animtaed_consult.gif",
                                    height: widgetHeight * 0.1)),
                          ),
                        ),
                        Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: SizedBox(height: widgetHeight * 0.2)),
                        Flexible(
                          flex: 5,
                          fit: FlexFit.tight,
                          child: SizedBox(
                            height: widgetHeight * 0.15,
                            child: AnimatedButton(
                                color: color2,
                                textString: "기타 \nAI 컨설팅",
                                icon: Image.asset("assets/animtaed_consult.gif",
                                    height: widgetHeight * 0.1)),
                          ),
                        ),
                        Flexible(
                            flex: 5,
                            fit: FlexFit.tight,
                            child: SizedBox(height: widgetHeight * 0.2)),
                      ]),
                )),
          ],
        ),
      )
          .animate(delay: 1000.ms)
          .fadeIn(duration: 1200.ms, curve: Curves.easeOutQuad)
          .slide(begin: Offset(0, 0.2), end: Offset.zero),
      Container(
          width: widgetWidth,
          height: widgetHeight,
          padding: EdgeInsets.all(30),
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Stack(alignment: Alignment.centerLeft, children: [
              Image.asset('assets/homepage/desktop6.png',
                  height: widgetHeight * 0.8),
              Image.asset('assets/homepage/desktop6_1.png',
                      width: widgetWidth, height: widgetHeight)
                  .animate(delay: 1000.ms)
                  .fadeIn(duration: 1000.ms, curve: Curves.easeOutQuad)
                  .slide(begin: Offset(0, 1), end: Offset.zero),
              Image.asset('assets/homepage/desktop6_2.png',
                      width: widgetWidth, height: widgetHeight)
                  .animate(delay: 1500.ms)
                  .fadeIn(duration: 1000.ms, curve: Curves.easeOutQuad)
                  .slide(begin: Offset(0, 1), end: Offset.zero),
              Image.asset('assets/homepage/desktop6_3.png',
                      width: widgetWidth, height: widgetHeight)
                  .animate(delay: 2000.ms)
                  .fadeIn(duration: 1000.ms, curve: Curves.easeOutQuad)
                  .slide(begin: Offset(0, 1), end: Offset.zero),
            ]),
          )),
      SizedBox(
        width: widgetWidth,
        height: widgetHeight * 1.1,
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Image.asset('assets/homepage/desktop7.png'),
        ),
      ),
    ];

    if (MediaQuery.of(context).size.width > 600) {
      return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height * 0.1),
            child: GetAppBar(width: MediaQuery.of(context).size.width)),
        body: SafeArea(
            child: WebSmoothScroll(
          controller: _scrollController,
          scrollOffset: 100,
          animationDuration: 100,
          curve: Curves.decelerate,
          child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              controller: _scrollController,
              itemCount: desktopWidgets.length,
              itemBuilder: ((context, index) {
                return desktopWidgets[index];
              })),
        )),
      );
    }

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height * 0.05),
          child: GetAppBar(width: MediaQuery.of(context).size.width)),
      endDrawer: Drawer(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                decoration: BoxDecoration(
                  color: color2,
                ),
                child: kIsWeb
                    ? SvgPicture.asset("assets/icons/logo_color.svg",
                        color: color, semanticsLabel: '로고', fit: BoxFit.contain)
                    : SvgPicture.asset("assets/icons/logo_color.svg",
                        color: color,
                        semanticsLabel: '로고',
                        fit: BoxFit.contain)),
            ListTile(
                title: const Text('TAXAI 소개'),
                onTap: () => Get.toNamed("/intro")),
            ListTile(title: const Text('공지사항'), onTap: () {}),
            ListTile(title: const Text('기술 문의'), onTap: () {}),
            ListTile(title: const Text('제휴 문의'), onTap: () {}),
            ListTile(title: const Text('특허 정보'), onTap: () {}),
            ListTile(
                title: const Text('로그인'), onTap: () => Get.toNamed("/login"))
          ],
        ),
      ),
      body: SafeArea(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: mobileWidgets.length,
            itemBuilder: ((context, index) {
              return mobileWidgets[index];
            })),
      ),
    );
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }
}
