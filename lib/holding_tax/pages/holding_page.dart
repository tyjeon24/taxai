import 'dart:convert';

import 'package:taxai/common_widgets/custom_address.dart';
import 'package:taxai/common_widgets/custom_dropdown.dart';
import 'package:taxai/common_widgets/custom_oxdropdown.dart';
import 'package:taxai/common_widgets/custom_percent.dart';
import 'package:taxai/common_widgets/custom_price.dart';
import 'package:taxai/components/api_endpoints.dart';
import 'package:taxai/components/colorbase.dart';
import 'package:taxai/components/param_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

Future calculateHolding() async {
  var dio = Dio();

  final controller = Get.find<HoldingController>();

  final response = await dio.request(
    "$holdingEndpoint",
    options: Options(method: 'GET'),
    queryParameters: {
      "input": json.encode([
        json.encode(controller.param[0]),
        json.encode(controller.param[1]),
        json.encode(controller.param[2]),
        json.encode(controller.param[3]),
        json.encode(controller.param[4]),
      ]),
    },
  );

  if (response.statusCode == 200) {
    final result = json.decode(response.data); // json으로 변경

    return result;
  } else {
    throw Exception("요청 중 오류가 발생했습니다.");
  }
}

class Contents extends StatelessWidget {
  final controller = Get.find<HoldingController>();
  Contents({super.key});
  @override
  Widget build(BuildContext context) {
    List<String> owners = const [
      "본인",
      "가족 구성원 A",
      "가족 구성원 B",
      "가족 구성원 C",
      "가족 구성원 D"
    ];
    return Obx(() {
      print(controller.param);
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomDropdownButton(
              index: 0,
              keyValue: "num_house",
              title: "주택수 선택",
              contents: const [
                "1세대 1주택",
                "1세대 2주택",
                "1세대 3주택",
                "1세대 4주택",
                "1세대 5주택"
              ],
              controller: controller),
          Obx(() {
            controller.param;
            if (controller.param[0]["num_house"] != null &&
                controller.param[0]["num_house"] == "1세대 1주택") {
              return Column(children: [
                CustomAddress(index: 0, controller: controller),
                CustomDropdownButton(
                    index: 0,
                    keyValue: "own_name1",
                    title: "소유주",
                    contents: owners,
                    controller: controller)
              ]);
            }
            return Container();
          }),
          Obx(() {
            controller.param;
            if (controller.param[0]["num_house"] != null &&
                controller.param[0]["num_house"] == "1세대 2주택") {
              return Column(children: [
                CustomAddress(index: 0, controller: controller),
                CustomDropdownButton(
                    index: 0,
                    keyValue: "own_name",
                    title: "소유주",
                    contents: owners,
                    controller: controller),
                CustomAddress(index: 1, controller: controller),
                CustomDropdownButton(
                    index: 1,
                    keyValue: "own_name",
                    title: "소유주",
                    contents: owners,
                    controller: controller),
              ]);
            }
            return Container();
          }),
          Obx(() {
            controller.param;
            if (controller.param[0]["num_house"] != null &&
                controller.param[0]["num_house"] == "1세대 3주택") {
              return Column(children: [
                CustomAddress(index: 0, controller: controller),
                CustomDropdownButton(
                    index: 0,
                    keyValue: "own_name",
                    title: "소유주",
                    contents: owners,
                    controller: controller),
                CustomAddress(index: 1, controller: controller),
                CustomDropdownButton(
                    index: 1,
                    keyValue: "own_name",
                    title: "소유주",
                    contents: owners,
                    controller: controller),
                CustomAddress(index: 2, controller: controller),
                CustomDropdownButton(
                    index: 2,
                    keyValue: "own_name",
                    title: "소유주",
                    contents: owners,
                    controller: controller),
              ]);
            }
            return Container();
          }),
          Obx(() {
            controller.param;
            if (controller.param[0]["num_house"] != null &&
                controller.param[0]["num_house"] == "1세대 4주택") {
              return Column(children: [
                CustomAddress(index: 0, controller: controller),
                CustomDropdownButton(
                    index: 0,
                    keyValue: "own_name",
                    title: "소유주",
                    contents: owners,
                    controller: controller),
                CustomAddress(index: 1, controller: controller),
                CustomDropdownButton(
                    index: 1,
                    keyValue: "own_name",
                    title: "소유주",
                    contents: owners,
                    controller: controller),
                CustomAddress(index: 2, controller: controller),
                CustomDropdownButton(
                    index: 2,
                    keyValue: "own_name",
                    title: "소유주",
                    contents: owners,
                    controller: controller),
                CustomAddress(index: 3, controller: controller),
                CustomDropdownButton(
                    index: 3,
                    keyValue: "own_name",
                    title: "소유주",
                    contents: owners,
                    controller: controller),
              ]);
            }
            return Container();
          }),
          Obx(() {
            controller.param;
            if (controller.param[0]["num_house"] != null &&
                controller.param[0]["num_house"] == "1세대 5주택") {
              return Column(children: [
                CustomAddress(index: 0, controller: controller),
                CustomDropdownButton(
                    index: 0,
                    keyValue: "own_name",
                    title: "소유주",
                    contents: owners,
                    controller: controller),
                CustomAddress(index: 1, controller: controller),
                CustomDropdownButton(
                    index: 1,
                    keyValue: "own_name",
                    title: "소유주",
                    contents: owners,
                    controller: controller),
                CustomAddress(index: 2, controller: controller),
                CustomDropdownButton(
                    index: 2,
                    keyValue: "own_name",
                    title: "소유주",
                    contents: owners,
                    controller: controller),
                CustomAddress(index: 3, controller: controller),
                CustomDropdownButton(
                    index: 3,
                    keyValue: "own_name",
                    title: "소유주",
                    contents: owners,
                    controller: controller),
                CustomAddress(index: 4, controller: controller),
                CustomDropdownButton(
                    index: 4,
                    keyValue: "own_name",
                    title: "소유주",
                    contents: owners,
                    controller: controller),
              ]);
            }
            return Container();
          }),
          CustomPercent(
              index: 0,
              title: "주택지분",
              keyValue: "share",
              controller: controller),
          if (controller.param[0]["num_house"] != null &&
              controller.param[0]["num_house"] != "1세대 1주택") ...[
            CustomOXDropdownButton(
                index: 0,
                title: "1세대 1주택으로 보는경우",
                keyValue: "one_house",
                controller: controller)
          ],
          if (controller.param[0]["num_house"] != null &&
              controller.param[0]["num_house"] == "1세대 1주택") ...[
            CustomDropdownButton(
                index: 0,
                keyValue: "own_date",
                title: "보유기간",
                contents: const ["5년미만", "5년이상", "10년이상", "15년이상"],
                controller: controller),
            CustomDropdownButton(
                index: 0,
                keyValue: "age",
                title: "연령입력",
                contents: const ["60세미만", "60세이상", "65세이상", "70세이상"],
                controller: controller)
          ],
          CustomPrice(
              index: 0,
              keyValue: "prop_tax",
              title: "직전년도 재산세액",
              controller: controller),
          CustomPrice(
              index: 0,
              keyValue: "comp_tax",
              title: "직전년도 종합부동산세액",
              controller: controller),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: calculateBacgroundColor),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                          title: Text("계산중..."),
                          content: SizedBox(
                            width: double.maxFinite,
                            child: FutureBuilder(
                                future: calculateHolding(),
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
                                                5, "result", snapshot.data));

                                    return TextButton(
                                        child: Text('${snapshot.data}'),
                                        onPressed: () => SchedulerBinding
                                            .instance
                                            .addPostFrameCallback(
                                                (_) => Get.toNamed("/")));
                                  }
                                  return Container();
                                }),
                          ));
                    });
              },
              child: Text("보유세 계산결과 확인"))
        ],
      );
    });
  }
}

class HoldingTaxPage extends StatelessWidget {
  final holdingController = Get.put(HoldingController());

  HoldingTaxPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HoldingController>();
    holdingController.setParam(0, "", "");
    holdingController.setParam(1, "", "");
    holdingController.setParam(2, "", "");
    holdingController.setParam(3, "", "");
    holdingController.setParam(4, "", "");
    holdingController.setParam(5, "result", "");
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () {
            print(controller.param);
            return Container(
              color: Color(0xFFF6F6F8),
              margin: EdgeInsets.all(30.0),
              child: ListView(
                children: [
                  Column(children: [Contents()])
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
