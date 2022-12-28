import 'package:taxai/common_widgets/custom_datepicker.dart';
import 'package:taxai/common_widgets/custom_dropdown.dart';
import 'package:taxai/common_widgets/custom_price.dart';
import 'package:taxai/components/param_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BeforeReconstruction extends StatelessWidget {
  const BeforeReconstruction({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CapitalGainsParameter>();
    return Obx(() {
      if (controller.param[index]["buy_type"] != "재건축전 주택") {
        controller.param[index].removeWhere((key, value) => key == "disp_date");
        controller.param[index].removeWhere((key, value) => key == "busi_date");
        controller.param[index]
            .removeWhere((key, value) => key == "occupy_cost");
        controller.param[index]
            .removeWhere((key, value) => key == "contri_cost");
        controller.param[index]
            .removeWhere((key, value) => key == "new_live_day");

        return Container();
      }

      return Column(
        children: [
          CustomDatePicker(
              index: index,
              keyValue: "disp_date",
              title: "관리처분계획인가일",
              controller: controller),
          CustomDatePicker(
              index: index,
              keyValue: "busi_date",
              title: "사업시행인가일",
              controller: controller),
          CustomPrice(
              index: index,
              keyValue: "occupy_cost",
              title: "종전 주택의 평가액",
              controller: controller),
          CustomPrice(
              index: index,
              keyValue: "contri_cost",
              title: "납부한 분담금",
              tooltip:
                  "납부한 분담금과 지급받은 청산금 중 하나만 입력해 주세요.\n두 값을 모두 입력 시 나중에 입력한 금액만 적용됩니다.",
              controller: controller),
          CustomPrice(
              index: index,
              keyValue: "liquid_cost",
              title: "지급받은 청산금",
              tooltip:
                  "납부한 분담금과 지급받은 청산금 중 하나만 입력해 주세요.\n두 값을 모두 입력 시 나중에 입력한 금액만 적용됩니다.",
              controller: controller),
          CustomDropdownButton(
              index: index,
              keyValue: "new_live_day",
              title: "신주택 거주기간",
              contents: const [
                "1년미만",
                "2년미만",
                "3년이상",
                "4년이상",
                "5년이상",
                "6년이상",
                "7년이상",
                "8년이상",
                "9년이상",
                "10년이상"
              ],
              tooltip: "신주택에서 거주한 기간만 입력하세요 (입주권은 1년미만 선택)",
              controller: controller)
        ],
      );
    });
  }
}
