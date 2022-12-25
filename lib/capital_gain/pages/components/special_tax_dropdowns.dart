import 'package:taxai/common_widgets/custom_dropdown.dart';
import 'package:taxai/common_widgets/custom_oxdropdown.dart';
import 'package:taxai/common_widgets/custom_sidetitle.dart';
import 'package:taxai/components/param_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/scheduler.dart';

class SpecialTaxChildern extends StatelessWidget {
  final int index;
  final size;

  const SpecialTaxChildern({
    Key? key,
    required this.index,
    required this.size,
  }) : super(key: key);
  @override
  Widget build(context) {
    final Color titleColor = Color(0xFF2F5597);
    final Color enabledColor = Color(0xFF8FAADC);
    final Color disabledColor = Color(0xFFD0CECE);
    final controller = Get.find<CapitalGainsParameter>();
    // 조특법 감면주택
    if (controller.param[index]["sell_type"] != "주택(주거용 오피스텔 포함)" ||
        Get.find<MyCustomParameter>().param[index]['계약일'] == null) {
      return Container();
    }

    List<Widget> widgets = [];
    DateTime acquisitionDate =
        DateTime.parse(Get.find<MyCustomParameter>().param[index]["취득일"]);
    DateTime commitmentDate =
        DateTime.parse(Get.find<MyCustomParameter>().param[index]["계약일"]);

    widgets.add(Container(
      margin: EdgeInsets.only(left: size.width * 0.08),
      width: size.width,
      height: size.width * 0.2 / 6,
      child: Row(
        children: [
          SizedBox(
              width: size.width * 0.2,
              height: size.width * 0.2 / 6,
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(titleColor)),
                  onPressed: () {},
                  child: Text("취득일 기준"))),
          SizedBox(
            width: size.width * 0.2 / 6,
          ),
          SizedBox(
              width: size.width * 0.2,
              height: size.width * 0.2 / 6,
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(titleColor)),
                  onPressed: () {},
                  child: Text("확인필요 법령조문"))),
          SizedBox(
            width: size.width * 0.2,
          ),
          SizedBox(
              width: size.width * 0.2 / 2,
              height: size.width * 0.2 / 6,
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(titleColor)),
                  onPressed: () {},
                  child: Text("선택"))),
        ],
      ),
    ));

    if (acquisitionDate.difference(DateTime(2000, 12, 31)).inDays <= 0) {
      widgets.add(reducRow(
          size: size,
          buttonColor: enabledColor,
          conditionContent: "2000년도 이전 취득",
          rawContent: "조세특례제한법 제97조",
          index: index,
          keyValue: "reduc_type1",
          controller: controller));
    } else {
      widgets.add(reducRow(
          size: size,
          buttonColor: disabledColor,
          conditionContent: "",
          rawContent: "조세특례제한법 제97조",
          index: index,
          keyValue: "",
          controller: controller));
    }

    if (acquisitionDate.difference(DateTime(1999, 1, 1)).inDays >= 0) {
      widgets.add(reducRow(
          size: size,
          buttonColor: enabledColor,
          conditionContent: "1999년 이후 취득",
          rawContent: "조세특례제한법 제97조의2",
          index: index,
          keyValue: "reduc_type2",
          controller: controller));
    } else {
      widgets.add(reducRow(
          size: size,
          buttonColor: disabledColor,
          conditionContent: "",
          rawContent: "조세특례제한법 제97조의2",
          index: index,
          keyValue: "",
          controller: controller));
    }

    if (commitmentDate.difference(DateTime(1995, 11, 1)).inDays >= 0 &&
        commitmentDate.difference(DateTime(1998, 12, 31)).inDays <= 0) {
      widgets.add(reducRow(
          size: size,
          buttonColor: enabledColor,
          conditionContent: "1995.11.1~1998.12.31 계약",
          rawContent: "조세특례제한법 제98조",
          index: index,
          keyValue: "reduc_type3",
          controller: controller));
    } else {
      widgets.add(reducRow(
          size: size,
          buttonColor: disabledColor,
          conditionContent: "",
          rawContent: "조세특례제한법 제98조",
          index: index,
          keyValue: "",
          controller: controller));
    }

    if (commitmentDate.difference(DateTime(2008, 11, 3)).inDays >= 0 &&
        commitmentDate.difference(DateTime(2010, 12, 31)).inDays <= 0) {
      widgets.add(reducRow(
          size: size,
          buttonColor: enabledColor,
          conditionContent: "2008.11.3~2010.12.31 계약",
          rawContent: "조세특례제한법 제98조2",
          index: index,
          keyValue: "reduc_type4",
          controller: controller));
    } else {
      widgets.add(reducRow(
          size: size,
          buttonColor: disabledColor,
          conditionContent: "",
          rawContent: "조세특례제한법 제98조2",
          index: index,
          keyValue: "",
          controller: controller));
    }

    if (commitmentDate.difference(DateTime(2009, 2, 12)).inDays >= 0 &&
        commitmentDate.difference(DateTime(2010, 2, 11)).inDays <= 0) {
      widgets.add(reducRow(
          size: size,
          buttonColor: enabledColor,
          conditionContent: "2009.2.12~20010.2.11 계약",
          rawContent: "조세특례제한법 제98조의3",
          index: index,
          keyValue: "reduc_type5",
          controller: controller));
    } else {
      widgets.add(reducRow(
          size: size,
          buttonColor: disabledColor,
          conditionContent: "",
          rawContent: "조세특례제한법 제98조의3",
          index: index,
          keyValue: "",
          controller: controller));
    }

    if (commitmentDate.difference(DateTime(2010, 2, 11)).inDays >= 0 &&
        commitmentDate.difference(DateTime(2011, 4, 30)).inDays <= 0) {
      widgets.add(reducRow(
          size: size,
          buttonColor: enabledColor,
          conditionContent: "2010.2.11~2011.4.30 계약",
          rawContent: "조세특례제한법 제98조5",
          index: index,
          keyValue: "reduc_type6",
          controller: controller));
    } else {
      widgets.add(reducRow(
          size: size,
          buttonColor: disabledColor,
          conditionContent: "",
          rawContent: "조세특례제한법 제98조5",
          index: index,
          keyValue: "",
          controller: controller));
    }

    if (commitmentDate.difference(DateTime(2011, 3, 29)).inDays >= 0 &&
        commitmentDate.difference(DateTime(2011, 12, 31)).inDays <= 0) {
      widgets.add(reducRow(
          size: size,
          buttonColor: enabledColor,
          conditionContent: "2011.3.29~2011 계약",
          rawContent: "조세특례제한법 제98조6",
          index: index,
          keyValue: "reduc_type7",
          controller: controller));
    } else {
      widgets.add(reducRow(
          size: size,
          buttonColor: disabledColor,
          conditionContent: "",
          rawContent: "조세특례제한법 제98조6",
          index: index,
          keyValue: "",
          controller: controller));
    }

    if (commitmentDate.difference(DateTime(2012, 9, 24)).inDays >= 0 &&
        commitmentDate.difference(DateTime(2012, 12, 31)).inDays <= 0) {
      widgets.add(reducRow(
          size: size,
          buttonColor: enabledColor,
          conditionContent: "2012.9.24~2012 계약",
          rawContent: "조세특례제한법 제98조7",
          index: index,
          keyValue: "reduc_type8",
          controller: controller));
    } else {
      widgets.add(reducRow(
          size: size,
          buttonColor: disabledColor,
          conditionContent: "",
          rawContent: "조세특례제한법 제98조7",
          index: index,
          keyValue: "",
          controller: controller));
    }

    if (commitmentDate.difference(DateTime(2015, 1, 1)).inDays >= 0 &&
        commitmentDate.difference(DateTime(2015, 12, 31)).inDays <= 0) {
      widgets.add(reducRow(
          size: size,
          buttonColor: enabledColor,
          conditionContent: "2015년 계약",
          rawContent: "조세특례제한법 제98조8",
          index: index,
          keyValue: "reduc_type9",
          controller: controller));
    } else {
      widgets.add(reducRow(
          size: size,
          buttonColor: disabledColor,
          conditionContent: "",
          rawContent: "조세특례제한법 제98조8",
          index: index,
          keyValue: "",
          controller: controller));
    }

    if (commitmentDate.difference(DateTime(2013, 4, 1)).inDays >= 0 &&
        commitmentDate.difference(DateTime(2013, 12, 31)).inDays <= 0) {
      widgets.add(reducRow(
          size: size,
          buttonColor: enabledColor,
          conditionContent: "2013.4.1~2013 계약",
          rawContent: "조세특례제한법 제99조2",
          index: index,
          keyValue: "reduc_type10",
          controller: controller));
    } else {
      widgets.add(reducRow(
          size: size,
          buttonColor: disabledColor,
          conditionContent: "",
          rawContent: "조세특례제한법 제99조2",
          index: index,
          keyValue: "",
          controller: controller));
    }

    return SizedBox(
        width: double.maxFinite,
        child: ListView(shrinkWrap: true, children: widgets));
  }
}

class reducRow extends StatelessWidget {
  const reducRow({
    Key? key,
    required this.size,
    required this.buttonColor,
    required this.conditionContent,
    required this.rawContent,
    required this.index,
    required this.keyValue,
    required this.controller,
  }) : super(key: key);

  final size;
  final Color buttonColor;
  final String conditionContent;
  final String rawContent;
  final int index;
  final String keyValue;
  final CapitalGainsParameter controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0, left: size.width * 0.08),
      width: size.width,
      height: size.width * 0.2 / 6,
      child: Row(
        children: [
          SizedBox(
              width: size.width * 0.2,
              height: size.width * 0.2 / 6,
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(buttonColor)),
                  onPressed: () {},
                  child: Text(conditionContent))),
          SizedBox(
            width: size.width * 0.2 / 6,
          ),
          SizedBox(
              width: size.width * 0.2,
              height: size.width * 0.2 / 6,
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(buttonColor)),
                  onPressed: () {},
                  child: Text(rawContent))),
          SizedBox(
            width: size.width * 0.2,
          ),
          SizedBox(
              width: size.width * 0.2 / 2,
              height: size.width * 0.2 / 6,
              child: CustomDropdownButton(
                  index: index,
                  keyValue: keyValue,
                  title: "",
                  needTitle: false,
                  contents: ["O", "X"],
                  controller: controller)),
        ],
      ),
    );
  }
}

class SpecialTaxDropdowns extends StatelessWidget {
  final int index;

  const SpecialTaxDropdowns({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CapitalGainsParameter>();

    return GetBuilder<MyCustomParameter>(builder: (_) {
      return Row(
        children: [
          Expanded(flex: 7, child: CustomSideTitle("감면주택 여부")),
          Flexible(flex: 1, child: Container()),
          Expanded(
            flex: 20,
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        controller.param[index]["specialTaxDialogStage"] == 2
                            ? MaterialStateProperty.all<Color>(Colors.blue)
                            : MaterialStateProperty.all<Color>(Colors.grey)),
                onPressed: () {
                  SchedulerBinding.instance.addPostFrameCallback((_) =>
                      controller.setParam(index, "specialTaxDialogStage", 2));
                  showDialog(
                      context: context,
                      builder: (context) {
                        var size = MediaQuery.of(context).size;
                        return AlertDialog(
                          title: Text("조특법 감면주택 체크리스트"),
                          content: SpecialTaxChildern(index: index, size: size),
                        );
                      });
                },
                child: controller.param[index]["specialTaxDialogStage"] == 2
                    ? Text("검사 완료")
                    : Text("검사 실시")),
          ),
        ],
      );
    });
  }
}
