import 'package:taxai/components/param_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CapgainResultBody extends StatelessWidget {
  const CapgainResultBody({super.key});
  @override
  Widget build(BuildContext context) {
    return ResultTable();
  }
}

class CapgainResultPage extends StatelessWidget {
  final estateController = Get.put(EstateController());

  CapgainResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ResultTable();
  }
}

class ResultTable extends StatelessWidget {
  final controller = Get.find<EstateController>();

  ResultTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CapitalGainsParameter>();
    // TODO : resultMap과 resultOneyearMap이 필요
    // TODO : 둘은 '동일한 구조'를 가져야 함.

    var resultMap = controller.param[4]["result"];
    print("이게 결과");
    print(resultMap);
    print(resultMap["양도예정일"]!);

    var resultOneyearMap = {
      "주소": "a주소 : 부산시 해운대구 마린시티2로 38 B동 3403호 (우동, 해운대아이파크 아파트)",
      "취득일": "a2016.01.01", // tax
      "취득일공시지가": "a500,000,000원", // tax
      "취득일조정지역여부": "ax", // tax
      "양도예정일": "a2022.11.02", // tax
      "양도예정일공시지가": "a800,000,000원", // tax
      "양도예정일조정지역여부": "ax", // tax
      "보유기간": "a6년 11개월 1일", // tax
      "거주기간": "a6년 이상", // tax
      "양도예정일제목": "a- 양도예정일 : 2022년 11월 02일 기준 (+1년)",
      "과세": "a111,111,111원", // tax
      "비과세": "비과세", // tax
      "장기보유공제유형": "a0~30% 유형", // long_type
      "장기보유특별공제적용률": "a12%", // long_rate
      "세율유형": "a6~45% 유형", //tax_type
      "적용세율": "a12%", // tax_rate
      "비과세요건": "a3주택시 비과세 요건 X", // ox[0]
      "2년보유": "a2년 보유 여부 O", // ox[1]
      "2년거주요건": "a2년 거주 요건 X", // ox[3] 2 아님
      "2년거주": "a2년 거주 여부 O", // ox[2]
      "중과주택": "a중과 주택 여부 X", // ox[4]
      "단기세율": "a단기세율 X", // ox[5]
      "중과배제주택": "a중과 배제 주택 여부 X", // ox[6]
    };

    Color resultTitleBackground = const Color(0xFFFFFBEF);
    Color resultsubTitle = const Color(0xFF203764);
    Color resultCornerHeader = const Color(0xFF9BC2E6);
    Color resultHeader = const Color(0xFFDDEBF7);

    double widgetHeight = MediaQuery.of(context).size.height;
    double widgetWidth = MediaQuery.of(context).size.width *
        (1 - MediaQuery.of(context).size.width / 16000);
    double widthShort = widgetWidth * 0.2;
    double widthMedium = widgetWidth * 0.3;
    double widthLong = widgetWidth * 0.6;

    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(
            horizontal:
                (MediaQuery.of(context).size.width - widgetWidth * 0.9) / 2),
        child: Column(
          children: [
            Container(
              width: widgetWidth,
              height: widgetHeight * 0.06,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 0.5,
                ),
              ),
              child: ColoredBox(
                color: resultTitleBackground,
                child: SizedBox(
                    width: widgetWidth,
                    height: widgetHeight * 0.06,
                    child: const FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        "TAX AI 양도소득세 모의 계산 결과",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )),
              ),
            ),
            SizedBox(
              height: widgetHeight * 0.03,
            ),
            Container(
              alignment: Alignment.centerLeft,
              width: widgetWidth,
              height: widgetHeight * 0.03,
              child: SizedBox(
                  height: widgetHeight * 0.03,
                  child: FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Text(
                      resultMap["주소"]!,
                      style: TextStyle(
                          color: resultsubTitle, fontWeight: FontWeight.bold),
                    ),
                  )),
            ),
            Container(
              width: widgetWidth,
              height: widgetHeight * 0.12,
              child: Column(
                children: [
                  Row(
                    children: [
                      ColoredTextBox(
                        width: widthMedium,
                        height: widgetHeight * 0.03,
                        color: resultCornerHeader,
                        content: "예상양도세액",
                        bold: true,
                      ),
                      ColoredTextBox(
                        width: widthShort,
                        height: widgetHeight * 0.03,
                        color: resultCornerHeader,
                        content: "날짜",
                        bold: true,
                      ),
                      ColoredTextBox(
                        width: widthShort,
                        height: widgetHeight * 0.03,
                        color: resultCornerHeader,
                        content: "주택 공시지가",
                        bold: true,
                      ),
                      ColoredTextBox(
                        width: widthShort,
                        height: widgetHeight * 0.03,
                        color: resultCornerHeader,
                        content: "조정지역 여부",
                        bold: true,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      ColoredTextBox(
                        width: widthMedium,
                        height: widgetHeight * 0.03,
                        color: Colors.white,
                        content: "양도예정일",
                        bold: false,
                      ),
                      ColoredTextBox(
                        width: widthShort,
                        height: widgetHeight * 0.03,
                        color: Colors.white,
                        content: resultMap["양도예정일"]!,
                        bold: false,
                      ),
                      ColoredTextBox(
                        width: widthShort,
                        height: widgetHeight * 0.03,
                        color: Colors.white,
                        content: resultMap["양도예정일공시지가"]!,
                        bold: false,
                      ),
                      ColoredTextBox(
                        width: widthShort,
                        height: widgetHeight * 0.03,
                        color: Colors.white,
                        content: resultMap["양도예정일조정지역여부"]!,
                        bold: false,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      ColoredTextBox(
                        width: widthMedium,
                        height: widgetHeight * 0.03,
                        color: Colors.white,
                        content: "취득일",
                        bold: false,
                      ),
                      ColoredTextBox(
                        width: widthShort,
                        height: widgetHeight * 0.03,
                        color: Colors.white,
                        content: resultMap["취득일"]!,
                        bold: false,
                      ),
                      ColoredTextBox(
                        width: widthShort,
                        height: widgetHeight * 0.03,
                        color: Colors.white,
                        content: resultMap["취득일공시지가"]!,
                        bold: false,
                      ),
                      ColoredTextBox(
                        width: widthShort,
                        height: widgetHeight * 0.03,
                        color: Colors.white,
                        content: resultMap["취득일조정지역여부"]!,
                        bold: false,
                      ),
                    ],
                  ),
                  Row(
                    // 4번째 줄
                    children: [
                      ColoredTextBox(
                        width: widthMedium,
                        height: widgetHeight * 0.03,
                        color: Colors.white,
                        content: "보유기간",
                        bold: false,
                      ),
                      ColoredTextBox(
                        width: widthShort,
                        height: widgetHeight * 0.03,
                        color: Colors.white,
                        content: resultMap["보유기간"]!,
                        bold: false,
                      ),
                      ColoredTextBox(
                        width: widthShort,
                        height: widgetHeight * 0.03,
                        color: Colors.white,
                        content: "거주기간",
                        bold: false,
                      ),
                      ColoredTextBox(
                        width: widthShort,
                        height: widgetHeight * 0.03,
                        color: Colors.white,
                        content: resultMap["거주기간"]!,
                        bold: false,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: widgetHeight * 0.03,
            ),
            Container(
              alignment: Alignment.centerLeft,
              width: widgetWidth,
              height: widgetHeight * 0.03,
              child: SizedBox(
                  height: widgetHeight * 0.03,
                  child: FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Text(
                      resultMap["양도예정일제목"]!,
                      style: TextStyle(
                          color: resultsubTitle, fontWeight: FontWeight.bold),
                    ),
                  )),
            ),
            Container(
              // 양도예정일 계산 표
              width: widgetWidth,
              height: widgetHeight * 0.24,
              child: Column(
                children: [
                  Row(
                    children: [
                      ColoredTextBox(
                        width: widthMedium,
                        height: widgetHeight * 0.03,
                        color: resultCornerHeader,
                        content: "예상양도세액",
                        bold: true,
                      ),
                      ColoredTextBox(
                        width: widthLong,
                        height: widgetHeight * 0.03,
                        color: resultHeader,
                        content: resultMap["과세"]!,
                        bold: true,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      ColoredTextBox(
                        width: widthMedium,
                        height: widgetHeight * 0.09,
                        color: resultHeader,
                        content: "비과세 여부와 조건",
                        bold: false,
                      ),
                      Column(
                        children: [
                          ColoredTextBox(
                            width: widthLong,
                            height: widgetHeight * 0.03,
                            color: Colors.white,
                            content: resultMap["비과세"]!,
                            bold: true,
                          ),
                          Row(
                            children: [
                              ColoredTextBox(
                                width: widthMedium,
                                height: widgetHeight * 0.03,
                                color: Colors.white,
                                content: resultMap["비과세요건"]!,
                                bold: false,
                              ),
                              ColoredTextBox(
                                width: widthMedium,
                                height: widgetHeight * 0.03,
                                color: Colors.white,
                                content: resultMap["2년보유"]!,
                                bold: false,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              ColoredTextBox(
                                width: widthMedium,
                                height: widgetHeight * 0.03,
                                color: Colors.white,
                                content: resultMap["2년거주요건"]!,
                                bold: false,
                              ),
                              ColoredTextBox(
                                width: widthMedium,
                                height: widgetHeight * 0.03,
                                color: Colors.white,
                                content: resultMap["2년거주"]!,
                                bold: false,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      ColoredTextBox(
                        //
                        width: widthMedium,
                        height: widgetHeight * 0.06,
                        color: resultHeader,
                        content: "장기보유공제 유형 및 적용률",
                        bold: false,
                      ),
                      Column(
                        children: [
                          ColoredTextBox(
                            width: widthLong,
                            height: widgetHeight * 0.03,
                            color: Colors.white,
                            content: resultMap["장기보유공제유형"]!,
                            bold: true,
                          ),
                          Row(
                            children: [
                              ColoredTextBox(
                                width: widthMedium,
                                height: widgetHeight * 0.03,
                                color: Colors.white,
                                content: resultMap["장기보유특별공제적용률"]!,
                                bold: false,
                              ),
                              ColoredTextBox(
                                width: widthMedium,
                                height: widgetHeight * 0.03,
                                color: Colors.white,
                                content: resultMap["중과주택"]!,
                                bold: false,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      ColoredTextBox(
                        //
                        width: widthMedium,
                        height: widgetHeight * 0.06,
                        color: resultHeader,
                        content: "세율 유형",
                        bold: false,
                      ),
                      Column(
                        children: [
                          ColoredTextBox(
                            width: widthLong,
                            height: widgetHeight * 0.03,
                            color: Colors.white,
                            content: resultMap["세율유형"]!,
                            bold: true,
                          ),
                          Row(
                            children: [
                              ColoredTextBox(
                                width: widthMedium,
                                height: widgetHeight * 0.03,
                                color: Colors.white,
                                content: resultMap["단기세율"]!,
                                bold: false,
                              ),
                              ColoredTextBox(
                                width: widthMedium,
                                height: widgetHeight * 0.03,
                                color: Colors.white,
                                content: resultMap["중과배제주택"]!,
                                bold: false,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: widgetHeight * 0.03,
            ),
            Container(
              alignment: Alignment.centerLeft,
              width: widgetWidth,
              height: widgetHeight * 0.03,
              child: SizedBox(
                  height: widgetHeight * 0.03,
                  child: FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Text(
                      resultOneyearMap["양도예정일제목"]!,
                      style: TextStyle(
                          color: resultsubTitle, fontWeight: FontWeight.bold),
                    ),
                  )),
            ),
            Container(
              width: widgetWidth,
              height: widgetHeight * 0.24,
              child: Column(
                children: [
                  Row(
                    children: [
                      ColoredTextBox(
                        width: widthMedium,
                        height: widgetHeight * 0.03,
                        color: resultCornerHeader,
                        content: "예상양도세액",
                        bold: true,
                      ),
                      ColoredTextBox(
                        width: widthLong,
                        height: widgetHeight * 0.03,
                        color: resultHeader,
                        content: resultOneyearMap["과세"]!,
                        bold: true,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      ColoredTextBox(
                        //
                        width: widthMedium,
                        height: widgetHeight * 0.09,
                        color: resultHeader,
                        content: "비과세 여부와 조건",
                        bold: false,
                      ),
                      Column(
                        children: [
                          ColoredTextBox(
                            width: widthLong,
                            height: widgetHeight * 0.03,
                            color: Colors.white,
                            content: resultOneyearMap["비과세"]!,
                            bold: true,
                          ),
                          Row(
                            children: [
                              ColoredTextBox(
                                width: widthMedium,
                                height: widgetHeight * 0.03,
                                color: Colors.white,
                                content: resultOneyearMap["비과세요건"]!,
                                bold: false,
                              ),
                              ColoredTextBox(
                                width: widthMedium,
                                height: widgetHeight * 0.03,
                                color: Colors.white,
                                content: resultOneyearMap["2년보유"]!,
                                bold: false,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              ColoredTextBox(
                                width: widthMedium,
                                height: widgetHeight * 0.03,
                                color: Colors.white,
                                content: resultOneyearMap["2년거주요건"]!,
                                bold: false,
                              ),
                              ColoredTextBox(
                                width: widthMedium,
                                height: widgetHeight * 0.03,
                                color: Colors.white,
                                content: resultOneyearMap["2년거주"]!,
                                bold: false,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      ColoredTextBox(
                        //
                        width: widthMedium,
                        height: widgetHeight * 0.06,
                        color: resultHeader,
                        content: "장기보유공제 유형 및 적용률",
                        bold: false,
                      ),
                      Column(
                        children: [
                          ColoredTextBox(
                            width: widthLong,
                            height: widgetHeight * 0.03,
                            color: Colors.white,
                            content: resultOneyearMap["장기보유공제유형"]!,
                            bold: true,
                          ),
                          Row(
                            children: [
                              ColoredTextBox(
                                width: widthMedium,
                                height: widgetHeight * 0.03,
                                color: Colors.white,
                                content: resultOneyearMap["장기보유특별공제적용률"]!,
                                bold: false,
                              ),
                              ColoredTextBox(
                                width: widthMedium,
                                height: widgetHeight * 0.03,
                                color: Colors.white,
                                content: resultOneyearMap["중과주택"]!,
                                bold: false,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      ColoredTextBox(
                        //
                        width: widthMedium,
                        height: widgetHeight * 0.06,
                        color: resultHeader,
                        content: "세율 유형",
                        bold: false,
                      ),
                      Column(
                        children: [
                          ColoredTextBox(
                            width: widthLong,
                            height: widgetHeight * 0.03,
                            color: Colors.white,
                            content: resultOneyearMap["세율유형"]!,
                            bold: true,
                          ),
                          Row(
                            children: [
                              ColoredTextBox(
                                width: widthMedium,
                                height: widgetHeight * 0.03,
                                color: Colors.white,
                                content: resultOneyearMap["단기세율"]!,
                                bold: false,
                              ),
                              ColoredTextBox(
                                width: widthMedium,
                                height: widgetHeight * 0.03,
                                color: Colors.white,
                                content: resultOneyearMap["중과배제주택"]!,
                                bold: false,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: widgetHeight * 0.03,
            ),
            Container(
              width: widgetWidth,
              height: widgetHeight * 0.06,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                ),
              ),
              child: Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                      "위 계산 결과는 TAX AI 알고리즘을 이용한 모의 계산 결과이므로 사실과 다를 수 있습니다.\n이 자료는 참고용 으로만 사용하시고 실제 신고와 의사결정 시 반드시 법 요건을 확인하시길 바랍니다.",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ColoredTextBox extends StatelessWidget {
  const ColoredTextBox({
    Key? key,
    required this.width,
    required this.height,
    required this.color,
    required this.content,
    required this.bold,
  }) : super(key: key);

  final double width;
  final double height;
  final Color color;
  final String content;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.5,
        ),
      ),
      child: ColoredBox(
          color: color,
          child: SizedBox(
            width: width,
            height: height,
            child: Center(
                child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                content,
                style: TextStyle(
                    fontWeight: bold ? FontWeight.bold : FontWeight.normal),
              ),
            )),
          )),
    );
  }
}
