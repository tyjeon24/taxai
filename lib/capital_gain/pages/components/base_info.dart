import 'package:taxai/capital_gain/constants/first_filter.dart';
import 'package:taxai/common_widgets/custom_address_sidetitle.dart';
import 'package:taxai/common_widgets/custom_dropdown.dart';
import 'package:taxai/common_widgets/custom_oxdropdown.dart';
import 'package:taxai/components/param_controller.dart';
import 'package:taxai/components/spacing.dart';
import 'package:taxai/components/widgetsize.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseInfo extends StatelessWidget {
  final int index;

  const BaseInfo({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CapitalGainsParameter>();
    return Obx(() {
      List<Widget> widgets = [];

      widgets.add(Container(
          height: baseHeight,
          margin: marginBottom24,
          child: CustomAddressWithSidetitle(
              index: index, controller: controller))); // 1. 주소

      widgets.add(CustomDropdownButton(
          index: index,
          keyValue: "sell_type",
          title: "양도(매도) 시 종류",
          contents: baseInfo[2]["contents"],
          tooltip: "양도 예정물건의 종류 입력",
          controller: controller)); // 2. 양도시 종류

      if (controller.param[index]["sell_type"] != null) {
        widgets.add(CustomDropdownButton(
            index: index,
            keyValue: "buy_cause",
            title: "취득 원인 (매수 종류)",
            contents: filtermap1[controller.param[index]["sell_type"]],
            controller: controller)); // 3. 취득 원인
      } else {
        controller.param[index].removeWhere((key, value) => key == "buy_cause");
      }

      if (controller.param[index]["buy_cause"] != null) {
        // 취득시 종류
        widgets.add(CustomDropdownButton(
            index: index,
            keyValue: "buy_type",
            title: "취득 시 종류",
            contents: filtermap2[controller.param[index]["sell_type"]]
                [controller.param[index]["buy_cause"]],
            controller: controller)); // // 4. 취득시 종류
      } else {
        controller.param[index].removeWhere((key, value) => key == "buy_type");
      }
      if (controller.param[index]["buy_type"] != null &&
          filterMap[controller.param[index]["sell_type"]]
                      [controller.param[index]["buy_cause"]]
                  [controller.param[index]["buy_type"]] !=
              null &&
          !filterMap[controller.param[index]["sell_type"]]
                      [controller.param[index]["buy_cause"]]
                  [controller.param[index]["buy_type"]]
              .keys
              .toList()
              .contains("data")) {
        widgets.add(CustomDropdownButton(
            index: index,
            keyValue: "분양권",
            title: "분양권",
            contents: filterMap[controller.param[index]["sell_type"]]
                        [controller.param[index]["buy_cause"]]
                    [controller.param[index]["buy_type"]]
                .keys
                .toList(),
            controller: controller));
      } else {
        controller.param[index].removeWhere((key, value) => key == "분양권");
      }

      return Column(
        children: widgets,
      );
    });
  }
}
