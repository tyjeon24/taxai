import 'package:capgain/common_widgets/animated_button.dart';
import 'package:capgain/components/colorbase.dart';
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

    var homepageWidgets = [
      Container(
        padding: EdgeInsets.all(30.0),
        child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Stack(alignment: Alignment.centerLeft, children: [
              Image.asset('assets/homepage/background.png',
                  height: widgetHeight * 0.8),
              Image.asset('assets/homepage/backgroundtext.png',
                  height: widgetHeight * 0.4),
            ])),
      ),
      Container(
        padding: EdgeInsets.all(30.0),
        child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Stack(alignment: Alignment.centerLeft, children: [
              Image.asset('assets/homepage/background2.png',
                  height: widgetHeight * 0.8),
              Container(
                      padding: EdgeInsets.only(left: 30),
                      child: Image.asset('assets/homepage/background2text.png',
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
            Image.asset('assets/homepage/background3_1.png',
                height: widgetHeight * 0.8),
            Image.asset('assets/homepage/background3_2.png',
                    width: widgetWidth * 0.5, height: widgetHeight * 0.4)
                .animate(delay: 1000.ms)
                .fadeIn(duration: 1000.ms, curve: Curves.easeOutQuad)
                .slide(begin: Offset(0, -1), end: Offset.zero),
          ])),
      Container(
              padding: EdgeInsets.all(30),
              child: Image.asset('assets/homepage/compare.png',
                  width: widgetWidth * 0.5, height: widgetHeight * 0.5))
          .animate(delay: 1000.ms)
          .fadeIn(duration: 1000.ms, curve: Curves.easeOutQuad)
          .slide(begin: Offset(0, -1), end: Offset.zero),
      Container(
          padding: EdgeInsets.all(30),
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Stack(alignment: Alignment.centerLeft, children: [
              Image.asset('assets/homepage/background4_1.png',
                  height: widgetHeight * 0.8),
              Image.asset('assets/homepage/background4_2.png',
                      width: widgetWidth * 0.5, height: widgetHeight * 0.4)
                  .animate(delay: 1000.ms)
                  .fadeIn(duration: 1000.ms, curve: Curves.easeOutQuad)
                  .slide(begin: Offset(0, 1), end: Offset.zero),
            ]),
          )),

      Container(
        width: widgetWidth * 0.7,
        margin: EdgeInsets.all(30),
        child: Column(
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
        margin: EdgeInsets.all(30),
        child: Column(
          children: [
            SizedBox(
              height: widgetHeight * 0.1,
              child: FittedBox(
                child: Text("TAXAI 세금 컨설팅",
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
            ),
          ],
        ),
      )
          .animate(delay: 1000.ms)
          .fadeIn(duration: 1200.ms, curve: Curves.easeOutQuad)
          .slide(begin: Offset(0, 0.2), end: Offset.zero),
      // Container(
      //   color: color3,
      //   child: Container(
      //     margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 30.0),
      //     child: FittedBox(
      //       child: Row(
      //         children: [
      //           kIsWeb
      //               ? SvgPicture.asset("assets/icons/logo_color_row.svg",
      //                   color: color,
      //                   semanticsLabel: '하단로고',
      //                   fit: BoxFit.contain)
      //               : SvgPicture.asset("assets/icons/logo_color_row.svg",
      //                   color: color,
      //                   semanticsLabel: '하단로고',
      //                   height: 30,
      //                   fit: BoxFit.contain),
      //           Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: const [
      //               FittedBox(
      //                 child: Text(
      //                     '(주) NEW EYE CORPORATION | 주소 : 부산광역시 남구 수영로 295, 911호(대연동, 세웅빌딩)'),
      //               ),
      //               FittedBox(
      //                   child: Text(
      //                       '대표자 김난이 | 사업자 등록번호: 457-86-02417 | 이메일 admin@taxai.co.kr'))
      //             ],
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // )
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
              itemCount: homepageWidgets.length,
              itemBuilder: ((context, index) {
                return homepageWidgets[index];
              })),
        )),
      );
    }

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 80),
          child: GetAppBar(width: MediaQuery.of(context).size.width)),
      endDrawer: Drawer(
        child: ListView(
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
            itemCount: homepageWidgets.length,
            itemBuilder: ((context, index) {
              return homepageWidgets[index];
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
