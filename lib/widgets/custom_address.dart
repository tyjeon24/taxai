import 'package:flutter/material.dart';
import '../param_controller.dart';
import 'package:get/get.dart';
import 'custom_title.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future fetchAddress(String keyword) async {
  String urlBase =
      'https://96qqvevx72.execute-api.ap-northeast-2.amazonaws.com/default/searchAddress?keyword=';

  final response = await http.get(Uri.parse(urlBase + keyword));

  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(utf8.decode(
        response.bodyBytes)); //한글 깨짐 방지를 위해 json.decode(response.body) 대신
    final List addressList = jsonResponse['results']['field'];

    return addressList;
  } else {
    throw Exception("Fail to fetch address data");
  }
}

Future fetchDetailedAddress(String pnu, [String? dong]) async {
  String urlBase =
      'https://z0hq847m05.execute-api.ap-northeast-2.amazonaws.com/default/detailedAddress?';
  String urlWithParams = "${urlBase}pnu=${pnu}";
  if (dong != null) {
    urlWithParams = "${urlWithParams}&dong=${dong}";
  }
  final response = await http.get(Uri.parse(urlWithParams));

  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));

    if (jsonResponse['results']['metadata']['errorCode'] == "0") {
      List dongList = jsonResponse['results']['field'] as List;

      return dongList;
    } else {
      return [];
    }
  } else {
    throw Exception("Failed to fetch address data");
  }
}

class CustomAddress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String keyword = "";
    final controller = Get.find<CapitalGainsParameter>();

    return Obx(
      () => SizedBox(
        width: double.maxFinite,
        child: ListView(
          children: [
            TextField(
              onSubmitted: (value) {
                controller.setParam("addressSearchKeyword", value);
                controller.setParam("addressDialogStage", 1);
              },
            ),
            if (controller.param.value["addressDialogStage"] == null) ...[
              Text("검색")
            ] else if (controller.param.value["addressDialogStage"] == 1) ...[
              FutureBuilder(
                  future: fetchAddress(
                      controller.param.value["addressSearchKeyword"]),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container();
                    }

                    List addressList = snapshot.data as List;
                    return SizedBox(
                        width: double.maxFinite,
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemCount: addressList.length,
                            itemBuilder: (BuildContext context, int idx) {
                              return Card(
                                child: ListTile(
                                    title: Text(addressList[idx]["roadAddr"]),
                                    subtitle: Text(addressList[idx]["oldAddr"]),
                                    onTap: () {
                                      controller.setParam(
                                          "addressDialogStage", 2);
                                      controller.setParam("roadAddr",
                                          addressList[idx]["roadAddr"]);
                                      controller.setParam(
                                          "pnu", addressList[idx]["pnu"]);
                                    }),
                              );
                            }));
                  }),
            ] else if (controller.param.value["addressDialogStage"] == 2) ...[
              FutureBuilder(
                  future: fetchDetailedAddress(controller.param.value["pnu"]),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container();
                    }
                    List dongList = snapshot.data as List;

                    if (dongList.length == 0) {
                      // 개인주택이거나 동이 없는 경우 종료
                      Navigator.pop(context);
                    }
                    return SizedBox(
                        width: double.maxFinite,
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemCount: dongList.length,
                            itemBuilder: (BuildContext context, int idx) {
                              return Card(
                                child: ListTile(
                                    title: Text(dongList[idx]),
                                    onTap: () {
                                      controller.setParam(
                                          "addressDialogStage", 3);
                                      controller.setParam(
                                          "dong", dongList[idx]);
                                    }),
                              );
                            }));
                  }),
            ] else if (controller.param.value["addressDialogStage"] == 3) ...[
              FutureBuilder(
                  future: fetchDetailedAddress(controller.param.value["pnu"],
                      controller.param.value["dong"]),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container();
                    }
                    List hosuList = snapshot.data as List;

                    if (hosuList.length == 0) {
                      // 개인주택이거나 동이 없는 경우 종료
                      Navigator.pop(context);
                    }
                    return SizedBox(
                        width: double.maxFinite,
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemCount: hosuList.length,
                            itemBuilder: (BuildContext context, int idx) {
                              return Card(
                                child: ListTile(
                                    title: Text(hosuList[idx]),
                                    onTap: () {
                                      controller.param.value.removeWhere(
                                          (key, value) =>
                                              key == "addressDialogStage");
                                      if (controller.param.value["dong"] ==
                                          "동 없음") {
                                        controller.setParam("fullAddress",
                                            "${controller.param.value["roadAddr"]} ${hosuList[idx]}");
                                      } else {
                                        controller.setParam("fullAddress",
                                            "${controller.param.value["roadAddr"]} ${controller.param.value["dong"]} ${hosuList[idx]}");
                                      }
                                      controller.setParam(
                                          "hosu", hosuList[idx]);
                                      Navigator.pop(context);
                                    }),
                              );
                            }));
                  }),
            ]
          ],
        ),
      ),
    );
  }
}
