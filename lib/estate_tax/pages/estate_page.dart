import 'dart:convert';

import 'package:capgain/common_widgets/custom_dropdown.dart';
import 'package:capgain/common_widgets/custom_oxdropdown.dart';
import 'package:capgain/common_widgets/custom_price.dart';
import 'package:capgain/components/api_endpoints.dart';
import 'package:capgain/components/param_controller.dart';
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
              controller: controller),
          CustomPrice(
              index: 0,
              keyValue: "상속시 부동산자산",
              title: "상속시 부동산자산",
              controller: controller),
          CustomPrice(
              index: 0,
              keyValue: "상속시 기타 자산",
              title: "상속시 기타 자산",
              controller: controller),
          CustomPrice(
              index: 0,
              keyValue: "상속시 금융부채",
              title: "상속시 금융부채",
              controller: controller),
          CustomPrice(
              index: 0,
              keyValue: "상속시 기타부채",
              title: "상속시 기타부채",
              controller: controller),
          CustomPrice(
              index: 0,
              keyValue: "사전증여재산",
              title: "사전증여재산",
              controller: controller),
          Obx(() {
            controller.param;
            if (controller.param[0]["사전증여재산"] != null) {
              return Column(children: [
                CustomPrice(
                    index: 0,
                    keyValue: "기 증여세액",
                    title: "기 증여세액",
                    controller: controller),
                CustomPrice(
                    index: 0,
                    keyValue: "배우자 사전증여 과세표준",
                    title: "배우자 사전증여 과세표준",
                    controller: controller)
              ]);
            }
            return Container();
          }),
          CustomOXDropdownButton(
              index: 0, keyValue: "배우자 여부", controller: controller),
          CustomDropdownButton(
              index: 0,
              keyValue: "상속인중 직계비속", // TODO 나중에 keyValue 변경
              title: "상속인중 직계비속",
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
              controller: controller),
          CustomPrice(
              index: 0,
              keyValue: "공과금 및 장례비용 등",
              title: "공과금 및 장례비용 등",
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
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return CircularProgressIndicator();
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
