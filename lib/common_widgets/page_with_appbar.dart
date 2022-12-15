import 'package:taxai/components/colorbase.dart';
import 'package:flutter/material.dart';
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

class PageWithAppbar extends StatefulWidget {
  final Widget body;

  const PageWithAppbar({
    Key? key,
    required this.body,
  }) : super(key: key);
  @override
  State<PageWithAppbar> createState() => _PageWithAppbarState();
}

class _PageWithAppbarState extends State<PageWithAppbar> {
  late ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width > 600) {
      return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(MediaQuery.of(context).size.width, 80),
            child: GetAppBar(width: MediaQuery.of(context).size.width)),
        body: SafeArea(
            child: WebSmoothScroll(
                controller: _scrollController,
                scrollOffset: 100,
                animationDuration: 100,
                curve: Curves.decelerate,
                child: widget.body)),
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
                child: SvgPicture.asset("assets/icons/logo_color.svg",
                    color: color, semanticsLabel: '로고', fit: BoxFit.contain)),
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
      body: SafeArea(child: widget.body),
    );
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }
}
