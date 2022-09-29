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
  CustomAddress({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

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
                controller.setParam(index, "addressSearchKeyword", value);
                controller.setParam(index, "addressDialogStage", 1);
              },
            ),
            if (controller.param[index]["addressDialogStage"] == null) ...[
              Text("검색")
            ] else if (controller.param[index]["addressDialogStage"] == 1) ...[
              FutureBuilder(
                  future: fetchAddress(
                      controller.param[index]["addressSearchKeyword"]),
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
                                          index, "addressDialogStage", 2);
                                      controller.setParam(index, "roadAddr",
                                          addressList[idx]["roadAddr"]);
                                      controller.setParam(index, "pnu",
                                          addressList[idx]["pnu"]);
                                    }),
                              );
                            }));
                  }),
            ] else if (controller.param[index]["addressDialogStage"] == 2) ...[
              FutureBuilder(
                  future: fetchDetailedAddress(controller.param[index]["pnu"]),
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
                                          index, "addressDialogStage", 3);
                                      controller.setParam(
                                          index, "dong", dongList[idx]);
                                    }),
                              );
                            }));
                  }),
            ] else if (controller.param[index]["addressDialogStage"] == 3) ...[
              FutureBuilder(
                  future: fetchDetailedAddress(controller.param[index]["pnu"],
                      controller.param[index]["dong"]),
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
                                      controller.param[index].removeWhere(
                                          (key, value) =>
                                              key == "addressDialogStage");
                                      if (controller.param[index]["dong"] ==
                                          "동 없음") {
                                        controller.setParam(
                                            index,
                                            "fullAddress",
                                            "${controller.param[index]["roadAddr"]} ${hosuList[idx]}");
                                      } else {
                                        controller.setParam(
                                            index,
                                            "fullAddress",
                                            "${controller.param[index]["roadAddr"]} ${controller.param[index]["dong"]} ${hosuList[idx]}");
                                      }
                                      controller.setParam(
                                          index, "hosu", hosuList[idx]);
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
