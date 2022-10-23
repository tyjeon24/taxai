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
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CapitalGainsParameter>();
    final customController = Get.find<MyCustomParameter>();
    return GetBuilder<MyCustomParameter>(builder: (_) {
      // 임대주택
      if (controller.param[index]["양도시 종류"] != "주택(주거용 오피스텔 포함)") {
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
      try {
        if (customController.param[index]["계약일"].runtimeType == DateTime &&
            customController.param[index]["취득일"].runtimeType == DateTime) {
          if (customController.param[index]["계약일"]
                      .difference(referenceDate)
                      .inDays >=
                  0 &&
              customController.param[index]["취득일"]
                      .difference(referenceDate)
                      .inDays >=
                  0) {
            // 계약, 취득일 당시 조정지역
            if (customController.param[index][
                    "${controller.param[index]['pnu']}-${DateFormat('yyyyMMdd').format(customController.param[index]['계약일']).toString()}"] &&
                customController.param[index][
                    "${controller.param[index]['pnu']}-${DateFormat('yyyyMMdd').format(customController.param[index]['취득일']).toString()}"]) {
              widgets.add(CustomOXDropdownButton(
                  index: index,
                  keyValue: "계약&취득 당시 무주택 여부",
                  controller: controller));
            }
          }
        }
      } catch (e) {
        print(e);
      }

      widgets.add(CustomDatePicker(
          index: index, keyValue: "임대주택 등록일", controller: controller));
      widgets.add(CustomDropdownButton(
          index: index,
          keyValue: "임대주택 유형",
          contents: const ["단기", "장기일반"],
          controller: controller));
      widgets.add(CustomDropdownButton(
          index: index,
          keyValue: "전용면적",
          contents: const ["85㎡이하", "85㎡초과"],
          controller: controller));

      return Column(children: widgets);
    });
  }
}
