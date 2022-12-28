import 'package:taxai/common_widgets/custom_datepicker.dart';
import 'package:taxai/common_widgets/custom_dropdown.dart';
import 'package:taxai/common_widgets/custom_oxdropdown.dart';
import 'package:taxai/components/param_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:taxai/components/typography.dart';
import 'package:taxai/components/colorbase.dart';

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

      if (controller.param[index]["임대주택 여부"] == null ||
          controller.param[index]["임대주택 여부"] == false) {
        controller.param[index]
            .removeWhere((key, value) => key == "계약&취득 당시 무주택 여부");
        controller.param[index].removeWhere((key, value) => key == "auto_end");
        controller.param[index].removeWhere((key, value) => key == "self_end");
        controller.param[index].removeWhere((key, value) => key == "resi_date");
        controller.param[index].removeWhere((key, value) => key == "rent_type");
        controller.param[index].removeWhere((key, value) => key == "rent_area");
        return Container();
      }

      // referenceDate : 18.9.14 일 이후 계약, 취득일이 있으며 & 계약, 취득일 당시 조정지역인 주택 계산용
      List<Widget> widgets = [];
      widgets.add(Divider());
      widgets.add(Padding(
        padding: const EdgeInsets.only(top: 30.0, bottom: 30.0),
        child: Container(
          alignment: Alignment.center,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: borderColor)),
          child: Text(
            "임대주택",
            textAlign: TextAlign.left,
            style: headlineTextStyle,
          ),
        ),
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
                  title: "계약&취득 당시 무주택 여부",
                  keyValue: "rent_no_house",
                  tooltip:
                      "이 주택은 계약일과 취득일에 무주택여부에 따라서 과세유형이 달라집니다. 무주택 여부를 체크해주세요.",
                  controller: controller));
            }
          }
        }
      } catch (e) {
        // ignore: avoid_print
        print(e);
      }

      if (customController.param[index]["rent_no_house"] != null &&
          customController.param[index]["rent_no_house"] == true) {
        widgets.add(CustomDatePicker(
            index: index,
            keyValue: "auto_end",
            title: "자동말소일",
            tooltip: "임대의무기간 종료로 자동말소 된 주택",
            controller: controller));
        widgets.add(CustomDatePicker(
            index: index,
            keyValue: "self_end",
            title: "자진말소일",
            tooltip: "임대의무기간의 1/2일 이상을 임대하고 자진말소 한 주택",
            controller: controller));
      }

      widgets.add(CustomDatePicker(
          index: index,
          keyValue: "resi_date",
          title: "임대주택 등록일",
          controller: controller));
      widgets.add(CustomDropdownButton(
          index: index,
          keyValue: "rent_type",
          title: "임대주택 유형",
          contents: const ["단기", "장기일반"],
          controller: controller));
      widgets.add(CustomDropdownButton(
          index: index,
          keyValue: "rent_area",
          title: "전용면적",
          contents: const ["85m이하", "85m초과"],
          controller: controller));

      return Column(children: widgets);
    });
  }
}
