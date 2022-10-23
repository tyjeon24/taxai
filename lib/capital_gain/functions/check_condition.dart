import 'dart:convert';
import 'package:capgain/capital_gain/constants/first_filter.dart';
import 'package:capgain/param_controller.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

void isRegulated(int index, String pnu, String date) {
  final customController = Get.find<MyCustomParameter>();

  if (customController.param[index]["$pnu-$date"] == null) {
    customController.setParam(index, "$pnu-$date", "");

    var apiFuture = Future.wait([
      http.get(Uri.parse(
        'https://26mlmqw646.execute-api.ap-northeast-2.amazonaws.com/default/check_reg?pnu=$pnu&date=$date',
      ))
    ]);

    apiFuture.then((response) {
      customController.setParam(
          index,
          "$pnu-$date",
          jsonDecode(utf8.decode(response[0].bodyBytes))["results"]["field"]
              ["isRegulated"]);
      customController.update();
    });
  }
}

bool checkCondition(int index, int conditionNumber) {
  final controller = Get.find<CapitalGainsParameter>();
  final customController = Get.find<MyCustomParameter>();

  var additionalData;
  if (controller.param[index]["분양권"] == null) {
    additionalData = filterMap[controller.param[index]["양도시 종류"]]
        [controller.param[index]["취득 원인"]][controller.param[index]["취득시 종류"]];
  } else {
    additionalData = filterMap[controller.param[index]["양도시 종류"]]
            [controller.param[index]["취득 원인"]]
        [controller.param[index]["취득시 종류"]][controller.param[index]["분양권"]];
  }

  if (additionalData["metadata"].containsKey("취득일계약일계산")) {
    if (customController.param[index]["param1"] == null &&
        controller.param[index]
                [additionalData["metadata"]["취득일계약일계산"]["param1"]] !=
            null &&
        controller.param[index]
                [additionalData["metadata"]["취득일계약일계산"]["param2"]] !=
            null) {
      SchedulerBinding.instance
          .addPostFrameCallback((_) => calculateDate(index, additionalData));
    } else if (controller.param[index]
                [additionalData["metadata"]["취득일계약일계산"]["param1"]] !=
            customController.param[index]["param1"] &&
        controller.param[index]
                [additionalData["metadata"]["취득일계약일계산"]["param2"]] !=
            customController.param[index]["param2"]) {
      SchedulerBinding.instance
          .addPostFrameCallback((_) => calculateDate(index, additionalData));
    }
  }

  if (conditionNumber == 0) {
    return true; // 0은 항상 출력

  } else if (conditionNumber == 1) {
    // "- 상속개시일 ~ 양도예정일 기간이 2년 미만일 때만"

    if (controller.param[index]["상속개시일"] == null ||
        controller.param[0]["양도예정일"] == null) {
      return false;
    } else {
      return controller.param[index]["상속개시일"]
              .difference(controller.param[0]["양도예정일"])
              .inDays
              .abs() <=
          731;
    }
  } else if (conditionNumber == 2) {
    // 재건축전 주택 상속개시일 ~ 양도예정일 기간이 2년미만일때만
    if (controller.param[index]["재건축전 주택 상속개시일"] == null ||
        controller.param[0]["양도예정일"] == null) {
      return false;
    } else {
      return controller.param[index]["재건축전 주택 상속개시일"]
              .difference(controller.param[0]["양도예정일"])
              .inDays
              .abs() <=
          731;
    }
  } else if (conditionNumber == 3) {
    // 동일세대원 상속시 (체크ㅇ시만)
    return controller.param[index]["상속시 동일세대원 여부"] ?? false;
  } else if (conditionNumber == 4) {
    // 취득일은 조정지역ㅇ, 계약일은 조정지역x 시

    if (customController.param[index]["취득일"] == null ||
        customController.param[index]["계약일"] == null ||
        customController.param[index]["취득일"] == "" ||
        customController.param[index]["계약일"] == "") {
      // 날짜가 준비되어 있지 않다면 계산하지 않음
      return false;
    }

    String pnu = controller.param[index]["pnu"];
    String date1 = DateFormat('yyyyMMdd')
        .format(customController.param[index]["취득일"])
        .toString();
    String date2 = DateFormat('yyyyMMdd')
        .format(customController.param[index]["계약일"])
        .toString();
    if (customController.param[index]["$pnu-$date1"] != null &&
        customController.param[index]["$pnu-$date2"] != null &&
        customController.param[index]["$pnu-$date1"] != "" &&
        customController.param[index]["$pnu-$date2"] != "") {
      // 두 값이 모두 있고 값이 변경되지 않은 경우 API 요청 없이 기존 값 그대로 사용

      return (customController.param[index]["$pnu-$date1"] &&
              !customController.param[index]["$pnu-$date2"] ??
          false);
    }

    SchedulerBinding.instance
        .addPostFrameCallback((_) => isRegulated(index, pnu, date1));
    SchedulerBinding.instance
        .addPostFrameCallback((_) => isRegulated(index, pnu, date2));

    // isRegulated(index, pnu, date1);
    // isRegulated(index, pnu, date2);
  }

  return false;
}

void calculateDate(int index, var additionalData) {
  final customController = Get.find<MyCustomParameter>();
  // 1. 취득일, 계약일 계산
  final controller = Get.find<CapitalGainsParameter>();
  var day1 =
      controller.param[index][additionalData["metadata"]["취득일계약일계산"]["param1"]];
  var day2 =
      controller.param[index][additionalData["metadata"]["취득일계약일계산"]["param2"]];

  if (day1 != null && day2 != null && day1 != "" && day2 != "") {
    print(customController.param[index]);
    customController.setParam(index, "param1", day1);
    customController.setParam(index, "param2", day2);
    if (additionalData["metadata"]["취득일계약일계산"]["method"] == "normal") {
      customController.setParam(index, "취득일", day1);
      customController.setParam(index, "계약일", day2);
    } else {
      // 1,2중 늦은날이 취득일&계약일
      // param1, 2중 늦은 날이 '취득일이자 계약일'이 된다.
      customController.setParam(index, "param1", day1);
      customController.setParam(index, "param2", day2);

      if (day1.difference(day2).inDays >= 0) {
        // day1이 더 '늦은' 경우
        customController.setParam(index, "취득일", day1);
        customController.setParam(index, "계약일", day1);
      } else {
        // day2가 더 '늦은' 경우
        customController.setParam(index, "취득일", day2);
        customController.setParam(index, "계약일", day2);
      }
    }
  }
}
