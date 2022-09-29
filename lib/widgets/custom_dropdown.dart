import 'package:flutter/material.dart';
import '../param_controller.dart';
import 'package:get/get.dart';
import 'custom_title.dart';

class CustomDropdownButton extends StatelessWidget {
  CustomDropdownButton({
    Key? key,
    required this.index,
    required this.keyValue,
    required this.contents,
  }) : super(key: key);

  final int index;
  final String keyValue;
  final List? contents;
  final controller = Get.find<CapitalGainsParameter>();
  @override
  Widget build(BuildContext context) {
    if (contents == null) {
      return Container();
    }

    return Obx(() {
      // 외부의 Obx와 별개로 내부에서 Obx를 한번 더 호출하는 이유는 드랍다운 값 선택 시 해당 값이 드롭다운에 표기되도록 렌더링하기 위함입니다(setState() 역할)
      return FractionallySizedBox(
        widthFactor: 0.7,
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTitle(keyValue),
              DropdownButton(
                isExpanded: true,
                value: contents!.contains(controller.param[index][keyValue])
                    ? controller.param[index][keyValue]
                    : null,
                items: contents?.map((item) {
                  return DropdownMenuItem<String>(
                      child: FittedBox(child: new Text(item)), value: item);
                }).toList(),
                onChanged: (selectedValue) {
                  controller.setParam(index, keyValue, selectedValue);
                  if (keyValue == "양도시 종류") {
                    controller.param[index]
                        .removeWhere((key, value) => key == "분양권");
                    controller.param[index]
                        .removeWhere((key, value) => key == "취득시 종류");
                    controller.param[index]
                        .removeWhere((key, value) => key == "취득 원인");
                  } else if (keyValue == "취득 원인") {
                    controller.param[index]
                        .removeWhere((key, value) => key == "분양권");
                    controller.param[index]
                        .removeWhere((key, value) => key == "취득시 종류");
                  } else if (keyValue == "취득시 종류") {
                    controller.param[index]
                        .removeWhere((key, value) => key == "분양권");
                  }
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
