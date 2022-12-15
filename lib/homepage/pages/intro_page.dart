import 'package:taxai/common_widgets/page_with_appbar.dart';
import 'package:flutter/material.dart';

class IntroBody extends StatelessWidget {
  const IntroBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFF6F6F8),
      margin: EdgeInsets.all(30.0),
      child: ListView(
        children: [
          Column(children: [
            const SizedBox(
              height: 20,
            ),
            Image.asset(
              'assets/homepage_image.png',
              height: 400,
              width: 500,
              fit: BoxFit.contain,
            ),
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: '세금 계산 시 고려사항은 왜 이렇게 복잡하고 어려울까?\n\n'
                        '전문가도 수많은 법령이나 예규 판례를 이해는 할 수 있지만\n'
                        '모두 기억하고 있을 순 없는데 프로그램은 기억하지 않을까?\n\n',
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.blueAccent,
                        fontSize: 24),
                    children: const [
                      TextSpan(
                          text: '라는 질문으로 이 프로그램을 기획하게 되었습니다.',
                          style: TextStyle(color: Colors.black)),
                    ])),
            const SizedBox(
              height: 30,
            ),
            Image.asset(
              'assets/homepage_image2.png',
              height: 400,
              width: 500,
              fit: BoxFit.contain,
            ),
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: '수많은 세금관련 규정을 정리하고 도식화 하고 프로그래밍화\n'
                      '하는 과정을 거쳐 프로그램을 완성하게 되었습니다.\n\n'
                      '앞으로도 개정되는 법령과 예규, 판례를 주기적으로 업데이트하여\n'
                      '세금 관련 판단을 하는데 도움이 되도록 하겠습니다.',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 24),
                )),
            const SizedBox(
              height: 15,
            ),
            Center(
              child: Text(
                'TAXAI 는 미래 세금을 컨설팅을 지원하는 기능도 추가할 예정입니다.',
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            // Center(
            //   child: Text('김동현 세무사 (기술고문)',
            //       textAlign: TextAlign.center,
            //       style: TextStyle(
            //         fontSize: 32,
            //         fontWeight: FontWeight.bold,
            //       )),
            // ),
            // const SizedBox(
            //   height: 15,
            // ),
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: const [
            //     SizedBox(
            //       height: 10,
            //     ),
            //     Text(
            //         '- 세무사, USA EA\n'
            //         '- (前) LH 토지보상(평택 고덕단지, 부산 명지 등) 세무 자문\n'
            //         '- (前) 부산 수영세무서 국세 심사위원\n'
            //         '- (前) 우리은행 TAX컨설팅팀 (상속, 증여, 양도 컨설팅 전문)\n'
            //         '- (現) AI TAX CONSULTING 대표 세무사',
            //         style: TextStyle(
            //           fontSize: 20,
            //           fontWeight: FontWeight.bold,
            //         )),
            //     Text('- 컨설팅 문의 : TECH@TAXAI.CO.KR',
            //         style: TextStyle(
            //           fontSize: 20,
            //           fontWeight: FontWeight.bold,
            //         ))
            //   ],
            // ),
          ])
        ],
      ),
    );
  }
}

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageWithAppbar(body: IntroBody());
  }
}
