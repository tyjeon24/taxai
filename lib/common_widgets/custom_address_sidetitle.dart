import 'dart:convert';

import 'package:taxai/components/api_endpoints.dart';
import 'package:taxai/components/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'custom_sidetitle.dart';

Future fetchAddress(String keyword) async {
  final response =
      await http.get(Uri.parse("$addressEndpoint?keyword=$keyword"));

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
  String urlWithParams = "$detailedAddressEndpoint?pnu=$pnu";
  if (dong != null) {
    urlWithParams = "$urlWithParams&dong=$dong";
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

Future fetchKakaoAddress(String keyword) async {
  Map<String, String> headers = {
    "Authorization": "KakaoAK 2f0db465d128bff49a344f7a89366da8"
  };

  final response = await http
      .get(Uri.parse("$kakaoAddressEndpoint?query=$keyword"), headers: headers);

  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(utf8.decode(
        response.bodyBytes)); //한글 깨짐 방지를 위해 json.decode(response.body) 대신

    final List addressList = jsonResponse["documents"];

    return addressList;
  } else {
    throw Exception("Fail to fetch address data");
  }
}

class AddressDialog extends StatelessWidget {
  final int index;

  // ignore: prefer_typing_uninitialized_variables
  final controller;
  const AddressDialog({Key? key, required this.index, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              Text(
                  "\n찾으시려는 도로명 주소 또는 지번 주소를 입력해주세요\n예) 불정로 6 / 정자동 178\n* 단 도로명 또는 동(읍/면/리)만 검색하시는 경우 정확한 검색 결과가 나오지 않을 수 있습니다.")
            ] else if (controller.param[index]["addressDialogStage"] == 1) ...[
              FutureBuilder(
                  future: fetchAddress(
                      controller.param[index]["addressSearchKeyword"]),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container();
                    }

                    List addressList = snapshot.data as List;
                    return Column(
                      children: [
                        SizedBox(
                            width: double.maxFinite,
                            child: TextButton(
                                child: Text("찾으시는 주소가 없으신가요?"),
                                onPressed: () {
                                  controller.setParam(
                                      index, "addressDialogStage", 4);
                                })),
                        SizedBox(
                            width: double.maxFinite,
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: const ScrollPhysics(),
                                itemCount: addressList.length,
                                itemBuilder: (BuildContext context, int idx) {
                                  return Card(
                                    child: ListTile(
                                        title:
                                            Text(addressList[idx]["roadAddr"]),
                                        subtitle: Text(addressList[idx]["pnu"]),
                                        onTap: () {
                                          controller.setParam(
                                              index, "addressDialogStage", 2);
                                          controller.setParam(index, "roadAddr",
                                              addressList[idx]["roadAddr"]);
                                          controller.setParam(index, "pnu",
                                              addressList[idx]["pnu"]);
                                        }),
                                  );
                                })),
                      ],
                    );
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
                      SchedulerBinding.instance.addPostFrameCallback((_) {
                        controller.setParam(index, "fullAddress",
                            "${controller.param[index]["roadAddr"]} ");

                        controller.setParam(index, "addressDialogStage", null);
                      });
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

                                      controller.setParam(
                                          index, "addressDialogStage", null);
                                      Navigator.pop(context);
                                    }),
                              );
                            }));
                  }),
            ] else if (controller.param[index]["addressDialogStage"] == 4) ...[
              FutureBuilder(
                  future: fetchKakaoAddress(
                      controller.param[index]["addressSearchKeyword"]),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container();
                    }

                    List addressList = snapshot.data as List;
                    return Column(
                      children: [
                        SizedBox(
                            width: double.maxFinite,
                            child: TextButton(
                                child: Text("여전히 찾으시는 주소가 없으신가요?"),
                                onPressed: () {
                                  controller.setParam(
                                      index, "addressDialogStage", null);
                                  Navigator.pop(context);
                                })),
                        SizedBox(
                            width: double.maxFinite,
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: const ScrollPhysics(),
                                itemCount: addressList.length,
                                itemBuilder: (BuildContext context, int idx) {
                                  return Card(
                                    child: ListTile(
                                        title: Text(addressList[idx]["address"]
                                            ["address_name"]),
                                        subtitle: Text(
                                            "${addressList[idx]["address"]["b_code"]}1${addressList[idx]["address"]["main_address_no"].padLeft(4, '0')}${addressList[idx]["address"]["sub_address_no"].padLeft(4, '0')}"),
                                        onTap: () {
                                          Navigator.pop(context);
                                          SchedulerBinding.instance
                                              .addPostFrameCallback((_) {
                                            controller.setParam(
                                                index,
                                                "fullAddress",
                                                addressList[idx]["address"]
                                                    ["address_name"]);
                                            controller.setParam(
                                                index,
                                                "roadAddr",
                                                addressList[idx]["address"]
                                                    ["address_name"]);
                                            controller.setParam(index,
                                                "addressDialogStage", null);
                                            controller.setParam(index, "pnu",
                                                "${addressList[idx]["address"]["b_code"]}1${addressList[idx]["address"]["main_address_no"].padLeft(4, '0')}${addressList[idx]["address"]["sub_address_no"].padLeft(4, '0')}");
                                          });
                                        }),
                                  );
                                })),
                      ],
                    );
                  }),
            ]
          ],
        ),
      ),
    );
  }
}

class CustomAddressWithSidetitle extends StatelessWidget {
  final int index;

  // ignore: prefer_typing_uninitialized_variables
  final controller;
  const CustomAddressWithSidetitle(
      {Key? key, required this.index, required this.controller})
      : super(key: key);

  @override
  Widget build(context) {
    return Row(
      children: [
        Expanded(flex: 7, child: CustomSideTitle("주소")),
        Flexible(flex: 1, child: Container()),
        Expanded(
          flex: 20,
          child: TextField(
            maxLines: null,
            decoration: InputDecoration(
              hintText: "주소를 입력해주세요.",
              hintStyle: bodyTextStyle,
              prefixIcon: Icon(
                Icons.place,
              ),
            ),
            controller: TextEditingController(
                text: controller.param[index]["fullAddress"] ?? ""),
            readOnly: true,
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("주소 검색"),
                      content:
                          AddressDialog(index: index, controller: controller),
                    );
                  });
            },
          ),
        ),
      ],
    );
  }
}
