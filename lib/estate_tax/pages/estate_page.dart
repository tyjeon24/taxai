import 'dart:convert';

import 'package:taxai/common_widgets/custom_dropdown.dart';
import 'package:taxai/common_widgets/custom_oxdropdown.dart';
import 'package:taxai/common_widgets/custom_price.dart';
import 'package:taxai/components/api_endpoints.dart';
import 'package:taxai/components/param_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

Future calculateEstate() async {
  var dio = Dio();

  final controller = Get.find<EstateController>();

  final response = await dio.request(
    estateEndpoint,
    options: Options(method: 'GET'),
    queryParameters: {"0": json.encode(controller.param[0])},
  );

  if (response.statusCode == 200) {
    final result = response.data; // json으로 변경

    return result;
  } else {
    throw Exception("요청 중 오류가 발생했습니다.");
  }
}

class Contents extends StatelessWidget {
  final controller = Get.find<EstateController>();

  Contents({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      print(controller.param);
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomPrice(
              index: 0,
              keyValue: "상속시 금융자산",
              title: "상속시 금융자산",
              tooltip:
                  "상속일 당시 금융자산의 합계액\n- 금융회사등이 취급하는 예금ㆍ적금ㆍ보험금ㆍ공제금ㆍ주식ㆍ채권ㆍ수익증권ㆍ출자지분ㆍ어음 등의 금전 및 유가증권",
              controller: controller),
          CustomPrice(
              index: 0,
              keyValue: "상속시 부동산자산",
              title: "상속시 부동산자산",
              tooltip:
                  "상속일 당시 부동산자산의 합계액\n- 상속일 현재 시가의 합계액. 다만, 시가를 산정하기 어려운경우 개별공시지가, 공동주택가격등의 기준시가의 합계액",
              controller: controller),
          CustomPrice(
              index: 0,
              keyValue: "상속시 기타 자산",
              title: "상속시 기타 자산",
              tooltip:
                  "상속일 당시 금융자산과 부동산 자산을 제외한 자산의 합계액\n- 상속일 현재 시가의 합계액. 다만 시가를 산정하기 어려운경우 보충적 평가방법의 합계액",
              controller: controller),
          CustomPrice(
              index: 0,
              keyValue: "상속시 금융부채",
              title: "상속시 금융부채",
              tooltip: "상속일 당시 금융부채의 합계로서 상속인이 실제로 부담하는 사실이 증명된 금융회사등의 채무의 합계액",
              controller: controller),
          CustomPrice(
              index: 0,
              keyValue: "상속시 기타부채",
              title: "상속시 기타부채",
              tooltip: "상속일 당시 금융부채를 제외한 기타 부채의 합계액",
              controller: controller),
          CustomPrice(
              index: 0,
              keyValue: "사전증여재산",
              title: "사전증여재산",
              tooltip:
                  "상속개시일 전 10년 이내에 피상속인이 상속인에게 증여한 재산가액과 5년 이내에 피상속인이 상속인이 아닌 자에게 증여한 재산가액의 합계액",
              controller: controller),
          Obx(() {
            controller.param;
            if (controller.param[0]["사전증여재산"] != null) {
              return Column(children: [
                CustomPrice(
                    index: 0,
                    keyValue: "기 증여세액",
                    title: "기 증여세액",
                    tooltip:
                        "상속재산에 가산한 증여재산에 대한 증여세액\n- 증여 당시의 그 증여재산에 대한 증여세산출세액을 말한다",
                    controller: controller),
                CustomPrice(
                    index: 0,
                    keyValue: "배우자 사전증여 과세표준",
                    title: "배우자 사전증여 과세표준",
                    tooltip: "상속재산에 가산한 증여재산 중 배우자가 사전증여받은 재산에 대한 증여세 과세표준",
                    controller: controller)
              ]);
            }
            return Container();
          }),
          CustomOXDropdownButton(
              index: 0,
              title: "배우자 여부",
              keyValue: "배우자 여부",
              tooltip: "상속 당시 배우자 존재 여부",
              controller: controller),
          CustomDropdownButton(
              index: 0,
              keyValue: "상속인중 직계비속",
              title: "상속인중 직계비속",
              tooltip: "상속 당시 상속인 직계비속의 인원",
              contents: const [
                "0",
                "1",
                "2",
                "3",
                "4",
                "5",
                "6",
                "7",
                "8",
                "9"
              ],
              controller: controller),
          CustomPrice(
              index: 0,
              keyValue: "기타 공제",
              title: "기타 공제",
              tooltip:
                  "기타 상속공제 금액의 합계액\n1) 가업상속공제 \n- 피상속인이 10년 이상 20년 미만 계속하여 경영한 경우: 200억원 한도\n- 피상속인이 20년 이상 30년 미만 계속하여 경영한 경우: 300억원 한도\n- 피상속인이 30년 이상 계속하여 경영한 경우: 500억원 한도\n2) 동거주택 상속공제 (한도 6억원)\n-  피상속인과 상속인이 10년 이상 계속하여 하나의 주택에서 동거한 1세대 1주택자의 주택가격\n3) 감정평가 수수료 공제 등",
              controller: controller),
          CustomPrice(
              index: 0,
              keyValue: "공과금 및 장례비용 등",
              title: "공과금 및 장례비용 등",
              tooltip:
                  "공과금 및 장례비용 등의 합계액\n- 공과금 : 상속개시일 현재 피상속인이 납부할 의무가 있는 공과금으로 상속인에게 승계된것\n- 장례비용 : 장례에 직접 소요된금액 (500만원 미만시 500만원, 1천만원 초과시 1천만원)\n- 봉안시설 또는 자연장지 : 직접 소요된 금액 (500만원 초과시 500만원)",
              controller: controller),
          ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                          title: Text("계산중..."),
                          content: SizedBox(
                            width: double.maxFinite,
                            child: FutureBuilder(
                                future: calculateEstate(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  }
                                  if (snapshot.hasData) {
                                    SchedulerBinding.instance
                                        .addPostFrameCallback((_) =>
                                            controller.setParam(
                                                0, "result", snapshot.data));

                                    return TextButton(
                                        child: Text('${snapshot.data}'),
                                        onPressed: () => SchedulerBinding
                                            .instance
                                            .addPostFrameCallback((_) =>
                                                Get.toNamed("/estateresult")));
                                  }
                                  return Container();
                                }),
                          ));
                    });
              },
              child: Text("계산"))
        ],
      );
    });
  }
}

class EstatePage extends StatelessWidget {
  final estateController = Get.put(EstateController());

  EstatePage({super.key});

  @override
  Widget build(BuildContext context) {
    estateController.setParam(0, "init", "init");
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Color(0xFFF6F6F8),
          margin: EdgeInsets.all(30.0),
          child: ListView(
            children: [
              Column(children: [Contents()])
            ],
          ),
        ),
      ),
    );
  }
}
