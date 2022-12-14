import 'package:taxai/common_widgets/custom_dropdown.dart';
import 'package:taxai/common_widgets/custom_percent.dart';
import 'package:taxai/common_widgets/custom_price.dart';
import 'package:taxai/components/param_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonAdditionalInfo extends StatelessWidget {
  final int index;

  const CommonAdditionalInfo(
      {Key? key,
      required this.index,
      required CapitalGainsParameter controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CapitalGainsParameter>();
    controller.param[index];
    return Column(
      children: [
        // 7 취득후 거주기간
        CustomDropdownButton(
            index: index,
            keyValue: "live_day",
            title: "취득 후 거주기간",
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
            controller: controller),
        // 8 양도가액 CustomPrice
        CustomPrice(
            index: index,
            keyValue: "sell_cost",
            title: "양도가액",
            tooltip: "※ 매도 예정이 없는 주택은 0을 입력해도 됩니다.",
            controller: controller),

        // 9 취득가액 및 필요경비 CustomPrice
        CustomPrice(
            index: index,
            keyValue: "buy_cost",
            title: "취득가액 및 필요경비",
            tooltip:
                "취득가액과 필요경비 합산액을 입력해 주세요\n필요경비 : 설비비, 계량비, 자본적지출액, 양도비(취득세, 법무사 수수료등n상속이나 증여받은 자산인 경우 당시 신고액(평가액)을 입력해 주세n※ 매도 예정이 없는 주택은 0을 입력해도 됩니다.",
            controller: controller),

        // 10 주택 지분
        CustomPercent(
            index: index,
            title: "주택 지분",
            keyValue: "share",
            tooltip: "단독명의인 경우 100%를 입력하고 공동명의인 경우 지분을 입력해 주세요",
            controller: controller),
      ],
    );
  }
}
