import 'package:capgain/common_widgets/animated_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late ScrollController _scrollController;
  Color _color = Color(0xFF3D889B);
  Color _color2 = Colors.white;
  Color _color3 = Colors.white;

  @override
  Widget build(BuildContext context) {
    double widgetHeight = MediaQuery.of(context).size.height;
    double widgetWidth = MediaQuery.of(context).size.width;

    var homepageWidgets = [
      Container(
        color: _color3,
        child: Container(
                margin: EdgeInsets.symmetric(horizontal: 60.0, vertical: 30.0),
                height: widgetHeight * 0.5,
                child: FittedBox(
                    child: Text('T A X A I',
                        style: TextStyle(
                            fontWeight: FontWeight.w900, color: _color))))
            .animate(delay: 1000.ms)
            .fadeIn(duration: 900.ms, curve: Curves.easeOutQuad)
            .slide(begin: Offset(-0.2, 0), end: Offset.zero),
      ),
      Container(
        color: _color3,
        child: Container(
                margin: EdgeInsets.symmetric(horizontal: 60.0, vertical: 30.0),
                height: widgetHeight * 0.2,
                child: FittedBox(
                    child: Text('AI가 판단하는 세금 계산기',
                        style: TextStyle(
                            fontWeight: FontWeight.w900, color: _color))))
            .animate(delay: 1000.ms)
            .fadeIn(duration: 1200.ms, curve: Curves.easeOutQuad)
            .slide(begin: Offset(-0.2, 0), end: Offset.zero),
      ),
      if (widgetWidth > 600) ...[
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.white,
              Color(0xFFE9F4F6),
            ],
          )),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 60.0, vertical: 30.0),
            child: FittedBox(
                child: Row(
              children: [
                Lottie.asset('assets/computer.json'),
                RichText(
                    text: TextSpan(
                        text: 'TAXAI는 아파트, 주택, 조합원 입주권, 분양권, 오피스텔의\n'
                            '수백 가지 비과세 유형과 중과 주택 수, 감면주택 등의\n'
                            '세법 규정을 ',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            // color: Colors.white,
                            fontSize: 50),
                        children: [
                      TextSpan(
                          text: 'AI가 자동으로 판단해서 계산할 수 있는\n혁신적인 세금계산기',
                          style: TextStyle(color: _color)),
                      TextSpan(text: '입니다.'),
                    ])),
              ],
            )),
          ),
        )
            .animate(delay: 1000.ms)
            .fadeIn(duration: 1200.ms, curve: Curves.easeOutQuad)
            .slide(),
      ] else ...[
        Container(
          color: _color,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 60.0, vertical: 30.0),
            child: Column(
              children: [
                Lottie.asset("assets/computer.json"),
                RichText(
                    text: TextSpan(
                        text: 'TAXAI는 아파트, 주택, 조합원 입주권, 분양권, 오피스텔의\n'
                            '수백 가지 비과세 유형과 중과 주택 수, 감면주택 등의\n'
                            '세법 규정을 ',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            // color: Colors.white,
                            fontSize: 50),
                        children: [
                      TextSpan(
                          text: 'AI가 자동으로 판단해서 계산할 수 있는\n혁신적인 세금계산기',
                          style: TextStyle(color: _color)),
                      TextSpan(text: '입니다.'),
                    ])),
              ],
            ),
          ),
        )
            .animate(delay: 1000.ms)
            .fadeIn(duration: 1200.ms, curve: Curves.easeOutQuad)
            .slide(begin: Offset(0, 0.2), end: Offset.zero),
      ],
      if (widgetWidth > 600) ...[
        Container(
          color: _color3,
          margin: EdgeInsets.symmetric(horizontal: 60.0, vertical: 30.0),
          child: FittedBox(
              child: Row(
            children: [
              RichText(
                  text: TextSpan(
                      text:
                          'TAXAI는 15년 간 재산 관련 세금 컨설팅을 전문적으로 해 온\n현직 세무사가 직접 설계한 프로그램으로서\n',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 50),
                      children: [
                    TextSpan(
                        text:
                            '최신 법령과 예규, 판례 등을 주기적으로 업데이트하여\n케이스 별로 적용 가능한 수많은 절세 규정을 미리 검토',
                        style: TextStyle(color: _color)),
                    TextSpan(
                        text:
                            '할 수 있으며\n조정대상지역 및 공동주택 가격 등을 자동 조회하는 기능을 갖추고 있어\n'),
                    TextSpan(
                        text: '세금신고 관련 오류를 획기적으로 줄여줄 수 있습니다.',
                        style: TextStyle(color: _color)),
                  ])),
              Lottie.asset("assets/money.json"),
            ],
          )),
        )
            .animate(delay: 1000.ms)
            .fadeIn(duration: 1200.ms, curve: Curves.easeOutQuad)
            .slide(begin: Offset(0, 0.2), end: Offset.zero),
      ] else ...[
        Container(
          color: _color3,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 60.0, vertical: 30.0),
            child: Column(
              children: [
                Text(
                    'TAXAI는 15년 간 재산 관련 세금 컨설팅을 전문적으로 해 온\n현직 세무사가 직접 설계한 프로그램으로서\n최신 법령과 예규, 판례 등을 주기적으로 업데이트하여\n케이스 별로 적용 가능한 수많은 절세 규정을 미리 검토할 수 있으며\n조정대상지역 및 공동주택 가격 등을 자동 조회하는 기능을 갖추고 있어\n세금신고 관련 오류를 획기적으로 줄여줄 수 있습니다.',
                    style: TextStyle(
                        fontWeight: FontWeight.w700, color: Colors.black)),
                Lottie.asset("assets/money.json"),
              ],
            ),
          )
              .animate(delay: 1000.ms)
              .fadeIn(duration: 1200.ms, curve: Curves.easeOutQuad)
              .slide(begin: Offset(0, 0.2), end: Offset.zero),
        ),
      ],
      Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.white,
            Color(0xFFE9F4F6),
          ],
        )),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 60.0, vertical: 30.0),
          child: FittedBox(
              child: Column(
            children: [
              Text("AI 세금 계산",
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 50, color: _color)),
              SizedBox(height: 30),
              FittedBox(
                child: Row(children: [
                  SizedBox(width: 30),
                  AnimatedButton(
                    color: _color2,
                    textString: '양도세\nAI 판단 계산기',
                    icon: Image.asset("assets/animated_money.gif", height: 30),
                    routes: "/capgain",
                  ),
                  SizedBox(width: 15),
                  AnimatedButton(
                    color: _color2,
                    textString: "보유세\nAI 판단 계산기",
                    icon:
                        Image.asset("assets/animated_document.gif", height: 30),
                    routes: "/holding",
                  ),
                  SizedBox(width: 15),
                  AnimatedButton(
                    color: _color2,
                    textString: "상속세\nAI 판단 계산기",
                    icon:
                        Image.asset("assets/animated_inherit.gif", height: 30),
                    routes: "/estate",
                  ),
                  SizedBox(width: 30),
                ]),
              ),
            ],
          )),
        ),
      )
          .animate(delay: 1000.ms)
          .fadeIn(duration: 1200.ms, curve: Curves.easeOutQuad)
          .slide(begin: Offset(0, 0.2), end: Offset.zero),
      Container(
        color: _color3,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 60.0, vertical: 30.0),
          child: FittedBox(
            child: Column(
              children: [
                Text("TAXAI 세금 컨설팅",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 50, color: _color)),
                SizedBox(height: 30),
                FittedBox(
                  child: Row(children: [
                    SizedBox(width: 30),
                    AnimatedButton(
                        color: _color2,
                        textString: "양도소득세\nAI 컨설팅",
                        icon: Image.asset("assets/animtaed_consult.gif",
                            height: 30)),
                    SizedBox(width: 15),
                    AnimatedButton(
                        color: _color2,
                        textString: "매도 관련\nAI 컨설팅",
                        icon: Image.asset("assets/animtaed_consult.gif",
                            height: 30)),
                    SizedBox(width: 15),
                    AnimatedButton(
                        color: _color2,
                        textString: "기타 \nAI 컨설팅",
                        icon: Image.asset("assets/animtaed_consult.gif",
                            height: 30)),
                    SizedBox(width: 30),
                  ]),
                ),
              ],
            ),
          ),
        ),
      )
          .animate(delay: 1000.ms)
          .fadeIn(duration: 1200.ms, curve: Curves.easeOutQuad)
          .slide(begin: Offset(0, 0.2), end: Offset.zero),
      Container(
        color: _color3,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 30.0),
          child: FittedBox(
            child: Row(
              children: [
                kIsWeb
                    ? SvgPicture.asset("assets/icons/logo_color_row.svg",
                        color: _color,
                        semanticsLabel: '하단로고',
                        fit: BoxFit.contain)
                    : SvgPicture.asset("assets/icons/logo_color_row.svg",
                        color: _color,
                        semanticsLabel: '하단로고',
                        height: 30,
                        fit: BoxFit.contain),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    FittedBox(
                      child: Text(
                          '(주) NEW EYE CORPORATION | 주소 : 부산광역시 남구 수영로 295, 911호(대연동, 세웅빌딩)'),
                    ),
                    FittedBox(
                        child: Text(
                            '대표자 김난이 | 사업자 등록번호: 457-86-02417 | 이메일 admin@taxai.co.kr'))
                  ],
                ),
              ],
            ),
          ),
        ),
      )
    ];

    if (MediaQuery.of(context).size.width > 600) {
      return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(MediaQuery.of(context).size.width, 80),
            child: getAppBar(
                color2: _color2,
                color: _color,
                width: MediaQuery.of(context).size.width)),
        body: SafeArea(
          child: GetSmoothScroll(
              scrollController: _scrollController,
              homepageWidgets: homepageWidgets),
        ),
      );
    }

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 80),
          child: getAppBar(
              color2: _color2,
              color: _color,
              width: MediaQuery.of(context).size.width)),
      // AppBar(
      //   foregroundColor: Colors.black,
      //   backgroundColor: _color2,
      //   leading: SvgPicture.asset("assets/icons/logo_color.svg",
      //       semanticsLabel: '로고', fit: BoxFit.contain),
      //   elevation: 0,

      //   title: Row(
      //     children: [
      //       Text(
      //         "TAXAI",
      //         style: TextStyle(
      //             fontSize: 32, color: _color, fontWeight: FontWeight.bold),
      //       ),
      //       Spacer(),
      //       ResponsiveVisibility(
      //           visible: false,
      //           visibleWhen: const [Condition.largerThan(name: TABLET)],
      //           child: TextButton(
      //               onPressed: () {}, child: Text("TAXAI 소개    "))),
      //       ResponsiveVisibility(
      //           visible: false,
      //           visibleWhen: const [Condition.largerThan(name: TABLET)],
      //           child: TextButton(child: Text("공지사항    "), onPressed: () {})),
      //       ResponsiveVisibility(
      //           visible: false,
      //           visibleWhen: const [Condition.largerThan(name: TABLET)],
      //           child:
      //               TextButton(onPressed: () {}, child: Text("기술 문의    "))),
      //       ResponsiveVisibility(
      //           visible: false,
      //           visibleWhen: const [Condition.largerThan(name: TABLET)],
      //           child:
      //               TextButton(onPressed: () {}, child: Text("제휴 문의    "))),
      //       ResponsiveVisibility(
      //           visible: false,
      //           visibleWhen: const [Condition.largerThan(name: TABLET)],
      //           child:
      //               TextButton(onPressed: () {}, child: Text("특허 정보    "))),
      //       ResponsiveVisibility(
      //           visible: false,
      //           visibleWhen: const [Condition.largerThan(name: TABLET)],
      //           child: TextButton(onPressed: () {}, child: Text("로그인    "))),
      //     ],
      //   ),
      //   // actions: action_contents,
      // ),
      // ),

      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                decoration: BoxDecoration(
                  color: _color2,
                ),
                child: kIsWeb
                    ? SvgPicture.asset("assets/icons/logo_color.svg",
                        color: _color,
                        semanticsLabel: '로고',
                        fit: BoxFit.contain)
                    : SvgPicture.asset("assets/icons/logo_color.svg",
                        color: _color,
                        semanticsLabel: '로고',
                        fit: BoxFit.contain)),
            ListTile(title: const Text('TAXAI 소개'), onTap: () {}),
            ListTile(title: const Text('공지사항'), onTap: () {}),
            ListTile(title: const Text('기술 문의'), onTap: () {}),
            ListTile(title: const Text('제휴 문의'), onTap: () {}),
            ListTile(title: const Text('특허 정보'), onTap: () {}),
            ListTile(title: const Text('로그인'), onTap: () {}),
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

class getAppBar extends StatelessWidget {
  const getAppBar({
    Key? key,
    required Color color2,
    required Color color,
    required double width,
  })  : _color2 = color2,
        _color = color,
        _width = width,
        super(key: key);

  final Color _color2;
  final Color _color;
  final double _width;

  @override
  Widget build(BuildContext context) {
    bool isDesktop = (_width > 600);

    if (isDesktop) {
      return AppBar(
        backgroundColor: _color2,
        leading: SvgPicture.asset("assets/icons/logo_color.svg",
            color: _color, semanticsLabel: '로고', fit: BoxFit.contain),
        elevation: 0,
        title: Text(
          "TAXAI",
          style: TextStyle(
              fontSize: 32, color: _color, fontWeight: FontWeight.bold),
        ),
        actions: [
          ResponsiveVisibility(
              visible: false,
              visibleWhen: const [Condition.largerThan(name: TABLET)],
              child: TextButton(child: Text("TAXAI 소개    "), onPressed: () {})),
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
              child: TextButton(child: Text("로그인    "), onPressed: () {}))
        ],
      );
    }

    return AppBar(
      backgroundColor: _color2,
      leading: SvgPicture.asset("assets/icons/logo_color.svg",
          color: _color, semanticsLabel: '로고', fit: BoxFit.contain),
      elevation: 0,
      title: Text("TAXAI",
          style: TextStyle(
              fontSize: 32, color: _color, fontWeight: FontWeight.bold)),
      iconTheme: IconThemeData(color: _color),
    );
  }
}

class GetSmoothScroll extends StatelessWidget {
  const GetSmoothScroll({
    Key? key,
    required ScrollController scrollController,
    required this.homepageWidgets,
  })  : _scrollController = scrollController,
        super(key: key);

  final ScrollController _scrollController;
  final List<Widget> homepageWidgets;

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) {
      return ListView.builder(
          itemCount: homepageWidgets.length,
          itemBuilder: ((context, index) {
            return homepageWidgets[index];
          }));
    }
    return WebSmoothScroll(
      controller: _scrollController,
      scrollOffset: 100,
      animationDuration: 100,
      curve: Curves.decelerate,
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          controller: _scrollController,
          itemCount: homepageWidgets.length,
          itemBuilder: ((context, index) {
            return homepageWidgets[index];
          })),
    );
  }
}
