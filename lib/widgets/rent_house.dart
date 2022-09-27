import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../param_controller.dart';
import 'custom_datepicker.dart';
import 'custom_dropdown.dart';
import 'custom_oxdropdown.dart';
import 'package:intl/intl.dart';

class RentHouse extends StatelessWidget {
  const RentHouse({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final CapitalGainsParameter controller;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyCustomParameter>(builder: (_) {
      // 임대주택
      if (controller.param.value["양도시 종류"] != "주택(주거용 오피스텔 포함)") {
        return Container();
      }

      // referenceDate : 18.9.14 일 이후 계약, 취득일이 있으며 & 계약, 취득일 당시 조정지역인 주택 계산용
      List<Widget> widgets = [];
      widgets.add(Divider());
      widgets.add(Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Text("임대주택",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4),
      ));

      DateTime referenceDate = DateTime(2018, 9, 14);
      if (Get.find<MyCustomParameter>().param.value["계약일"] != null &&
          Get.find<MyCustomParameter>().param.value["취득일"] != null) {
        if (Get.find<MyCustomParameter>()
                    .param
                    .value["계약일"]
                    .difference(referenceDate)
                    .inDays >=
                0 &&
            Get.find<MyCustomParameter>()
                    .param
                    .value["취득일"]
                    .difference(referenceDate)
                    .inDays >=
                0) {
          // 계약, 취득일 당시 조정지역
          if (Get.find<MyCustomParameter>().param.value[
                  "${controller.param.value['pnu']}-${DateFormat('yyyyMMdd').format(Get.find<MyCustomParameter>().param.value['계약일']).toString()}"] &&
              Get.find<MyCustomParameter>().param.value[
                  "${controller.param.value['pnu']}-${DateFormat('yyyyMMdd').format(Get.find<MyCustomParameter>().param.value['취득일']).toString()}"]) {
            widgets.add(CustomOXDropdownButton("계약&취득 당시 무주택 여부"));
          }
        }
      }

      widgets.add(CustomDatePicker("임대주택 등록일"));
      widgets.add(CustomDropdownButton("임대주택 유형", ["단기", "장기일반"]));
      widgets.add(CustomDropdownButton("전용면적", ["85㎡이하", "85㎡초과"]));

      return Column(children: widgets);
    });
  }
}
