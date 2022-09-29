import 'package:flutter/material.dart';
import 'custom_dropdown.dart';
import 'custom_price.dart';

class CommonAdditionalInfo extends StatelessWidget {
  CommonAdditionalInfo({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 7 취득후 거주기간
        CustomDropdownButton(
          index: index,
          keyValue: "취득후 거주기간",
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
        ),
        // 8 양도가액 CustomPrice
        CustomPrice(index: index, keyValue: "양도가액"),

        // 9 취득가액 및 필요경비 CustomPrice
        CustomPrice(index: index, keyValue: "취득가액 및 필요경비"),

        // 10 주택 지분
        CustomDropdownButton(
          index: index,
          keyValue: "주택 지분",
          contents: const ["단독명의", "공동명의"],
        ),
      ],
    );
  }
}
