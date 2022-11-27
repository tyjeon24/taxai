import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:capgain/typography.dart';
import 'custom_sidetitle.dart';

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

Future fetchKakaoAddress(String keyword) async {
  String urlBase = 'https://dapi.kakao.com/v2/local/search/keyword.json?query=';

  Map<String, String> headers = {
    "Authorization": "KakaoAK 2f0db465d128bff49a344f7a89366da8"
  };

  final response =
      await http.get(Uri.parse(urlBase + keyword), headers: headers);

  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(utf8.decode(
        response.bodyBytes)); //한글 깨짐 방지를 위해 json.decode(response.body) 대신

    final List addressList = jsonResponse["documents"];

    return addressList;
  } else {
    throw Exception("Fail to fetch address data");
  }
}

Future fetchDetailedAddress(String pnu, [String? dong]) async {
  String urlBase =
      'https://z0hq847m05.execute-api.ap-northeast-2.amazonaws.com/default/detailedAddress?';
  String urlWithParams = "${urlBase}pnu=$pnu";
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

class CustomAddressWithSidetitle extends StatelessWidget {
  const CustomAddressWithSidetitle(
      {Key? key, required this.index, required this.controller})
      : super(key: key);

  final int index;
  // ignore: prefer_typing_uninitialized_variables
  final controller;

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

class AddressDialog extends StatelessWidget {
  const AddressDialog({Key? key, required this.index, required this.controller})
      : super(key: key);

  final int index;
  // ignore: prefer_typing_uninitialized_variables
  final controller;

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
                                        subtitle:
                                            Text(addressList[idx]["oldAddr"]),
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
                                  Navigator.pop(context); // TODO 나중에 뭐 할지 정하기.
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
                                        title: Text(
                                            addressList[idx]["address_name"]),
                                        subtitle: Text(
                                            addressList[idx]["place_name"]),
                                        onTap: () {
                                          Navigator.pop(context);
                                          SchedulerBinding.instance
                                              .addPostFrameCallback((_) {
                                            controller.setParam(
                                                index,
                                                "fullAddress",
                                                "${addressList[idx]["address_name"]} ${addressList[idx]["place_name"]}");
                                            controller.setParam(
                                                index,
                                                "roadAddr",
                                                addressList[idx]
                                                    ["address_name"]);
                                            controller.setParam(index,
                                                "addressDialogStage", null);
                                            controller.setParam(
                                                index, "pnu", "");
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
