import 'dart:convert';

import 'package:taxai/common_widgets/custom_oxdropdown.dart';
import 'package:taxai/common_widgets/custom_sidetitle.dart';
import 'package:taxai/components/api_endpoints.dart';
import 'package:taxai/components/param_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

Future checkRuralCondition(int index) async {
  final controller = Get.find<CapitalGainsParameter>();
  final customController = Get.find<MyCustomParameter>();

  String url =
      '$ruralEndpoint?pnu=${controller.param[index]["pnu"]}&address=${controller.param[index]["fullAddress"]}&acquisition_date=${controller.param[index]["취득일"].replaceAll("-", "")}';

  if (controller.param[index]["hosu"] != null) {
    url =
        '$url&dong=${controller.param[index]["dong"]}&hosu=${controller.param[index]["hosu"]}';
  }

  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(utf8.decode(
        response.bodyBytes)); //한글 깨짐 방지를 위해 json.decode(response.body) 대신
    final List addressList = jsonResponse;

    return addressList;
  } else {
    throw Exception("Fail to fetch address data");
  }
}

class RuralHouse extends StatelessWidget {
  final int index;

  const RuralHouse({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CapitalGainsParameter>();
    return GetBuilder<MyCustomParameter>(builder: (_) {
      return Row(
        children: [
          Expanded(flex: 7, child: CustomSideTitle("농어촌주택 여부")),
          Flexible(flex: 1, child: Container()),
          Expanded(
            flex: 20,
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        controller.param[index]["ruralDialogStage"] == 2
                            ? MaterialStateProperty.all<Color>(Colors.blue)
                            : MaterialStateProperty.all<Color>(Colors.grey)),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("농어촌 주택"),
                          content: RuralHouseChildern(index: index),
                        );
                      });
                },
                child: controller.param[index]["ruralDialogStage"] == 2
                    ? Text("검사 완료")
                    : Text("검사 실시")),
          ),
        ],
      );
    });
  }
}

class RuralHouseChildern extends StatelessWidget {
  final int index;

  const RuralHouseChildern({
    Key? key,
    required this.index,
  }) : super(key: key);
  @override
  Widget build(context) {
    List addressList = [];
    final controller = Get.find<CapitalGainsParameter>();
    final customController = Get.find<MyCustomParameter>();
    if (controller.param[index]["pnu"] == null ||
        controller.param[index]["fullAddress"] == null ||
        customController.param[index]['취득일'] == null) {
      return Container();
    }

    return Obx(() {
      if (controller.param[index]["ruralDialogStage"] == null ||
          controller.param[index]["ruralDialogStage"] == 2) {
        return SizedBox(
          width: double.maxFinite,
          child: FutureBuilder(
              future: checkRuralCondition(index),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  addressList = snapshot.data as List;
                  print(addressList);
                  SchedulerBinding.instance.addPostFrameCallback(
                      (_) => controller.setParam(index, "ruralDialogStage", 1));
                }

                return Container();
              }),
        );
      } else if (controller.param[index]["ruralDialogStage"] == 1) {
        List<Widget> widgets = [];
        widgets.add(Text("""
A. 조세특례제한법 농어촌주택

 1. 취득일 기준 : 2003.8.1.~ 2022.12.31.에 취득

 2. 지역 기준 (취득일 당시)
   (1) 수도권지역이 아닐 것 (경기도 연천군, 인천 옹진군 제외)
   (2) “국토의 계획 및 이용에 관한 법률”에 따른 도시지역이 아닐 것
   (3) 조정지역이 아닐 것
   (4) “부동산 거래신고 등에 관한 법률” 10조에 따른 허가구역이 아닐 것
   (5) “관광진흥법” 제2조에 따른 관광단지가 아닐 것

 3. 가액기준
   (1) 2009.1.1.~2022.12.31 취득 시 취득당시 기준시가 2억원 이하
   (2) 2008년 취득 시 취득당시 기준시가 1.5억원 이하
   (3) 2003.8.1.~2007.12.31. 취득 시 기준시가 7천만원 이하

 4. 타지역 기준 
   - 일반주택이 소재한 읍·면 지역이 아닌 곳에서 농어촌 주택을 취득할 것
"""));
        if (addressList[0] == true) {
          widgets.add(SizedBox(
            width: 300,
            height: 100,
            child: CustomOXDropdownButton(
                index: index,
                title: "",
                needTitle: false,
                keyValue: "restri_raw",
                controller: controller),
          ));
        } else {
          widgets.add(Text("해당사항이 없습니다"));
        }
        widgets.add(Text("""
B. 조세특례제한법 고향주택

 1. 취득일 기준 : 2009.1.1.~ 2022.12.31에 취득

 2. 지역기준
   (1) 고향에 소재
      - 가족관계등록부에 10년이상 등재된 등록기준지나 10년이상 거주한 사실이 있는 지역
   (2) 지역기준
      1) 해당지역에 소재하여야 한다.         
      2) 취득시 조정대상지역이 아니여야 한다.

 3. 가액기준
   - 취득당시 기준시가 2억원 이하
"""));
        if (addressList[1] == true) {
          widgets.add(SizedBox(
            width: 300,
            height: 100,
            child: CustomOXDropdownButton(
                index: index,
                title: "",
                needTitle: false,
                keyValue: "restri_raw_home",
                controller: controller),
          ));
        } else {
          widgets.add(Text("해당사항이 없습니다"));
        }
        widgets.add(Text("""
C. 소득세법 농어촌주택

 1. 지역기준
   (1) 수도권지역이 아닐 것
   (2) 읍지역(도시지역을 제외한다) or 면지역에 소재할 것
 
 2. 요건기준 (하나라도 해당되면 가능)
   (1) 상속받은 주택 (피상속인이 취득후 5년이상 거주한 주택)  
   (2) 이농인(어업인 포함)이 취득후 5년 이상 거주한 이농주택
   (3) 영농 또는 영어의 목적으로 취득한 귀농주택
"""));
        if (addressList[2] == true) {
          widgets.add(SizedBox(
            width: 300,
            height: 100,
            child: CustomOXDropdownButton(
                index: index,
                title: "",
                needTitle: false,
                keyValue: "income_raw",
                controller: controller),
          ));
        } else {
          widgets.add(Text("해당사항이 없습니다"));
        }

        widgets.add(ElevatedButton(
            onPressed: () {
              SchedulerBinding.instance.addPostFrameCallback(
                  (_) => controller.setParam(index, "ruralDialogStage", 2));
              Navigator.pop(context);
            },
            child: Text("닫기")));

        return SizedBox(
            width: double.maxFinite,
            child: ListView(shrinkWrap: true, children: widgets));
      }

      return Container();
    });
  }
}
