import 'package:capgain/common_widgets/custom_oxdropdown.dart';
import 'package:capgain/common_widgets/custom_title.dart';
import 'package:capgain/param_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpecialTaxChildern extends StatelessWidget {
  const SpecialTaxChildern({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;
  @override
  Widget build(context) {
    final controller = Get.find<CapitalGainsParameter>();
    // 조특법 감면주택
    if (controller.param[index]["양도시 종류"] != "주택(주거용 오피스텔 포함)" ||
        Get.find<MyCustomParameter>().param[index]['계약일'] == null) {
      return Container();
    }

    if (Get.find<MyCustomParameter>().param[index]['계약일'].runtimeType !=
            DateTime ||
        Get.find<MyCustomParameter>().param[index]['취득일'].runtimeType !=
            DateTime) {
      return Container();
    }

    List<Widget> widgets = [];

    if (Get.find<MyCustomParameter>()
            .param[index]["취득일"]
            .difference(DateTime(2000, 12, 31))
            .inDays <=
        0) {
      widgets.add(CustomOXDropdownButton(
          index: index,
          keyValue:
              "1986.1.1~2000.12.31 신축된 5호 이상의 주택을 5년이상 임대한 국민주택 또는 세액감면대상 주택, 86년이전 신축 공동주택(입주사실 없는) 조세특례제한법 제97조 링크 : https://www.law.go.kr/법령/조세특례제한법",
          controller: controller));
    }

    if (Get.find<MyCustomParameter>()
            .param[index]["취득일"]
            .difference(DateTime(1999, 1, 1))
            .inDays >=
        0) {
      widgets.add(CustomOXDropdownButton(
          index: index,
          keyValue:
              "1999.8.20~2001.12.31 신축된 1호이상의 주택을 포함한 2호이상의 주택을 5년이상 임대한 신축임대주택, 세액감면대상 주택 조세특례제한법 제97조의2 링크 : https://www.law.go.kr/법령/조세특례제한법",
          controller: controller));
    }

    if (Get.find<MyCustomParameter>()
                .param[index]["계약일"]
                .difference(DateTime(1995, 11, 1))
                .inDays >=
            0 &&
        Get.find<MyCustomParameter>()
                .param[index]["계약일"]
                .difference(DateTime(1998, 12, 31))
                .inDays <=
            0) {
      widgets.add(CustomOXDropdownButton(
          index: index,
          keyValue:
              "1995.11.1~1997.12.31 1998.3.1~1998.12.31 서울외 지방의 미분양 국민주택 취득후 5년이상 임대한후에 양도 조세특례제한법 제98조 링크 : https://www.law.go.kr/법령/조세특례제한법",
          controller: controller));
    }

    if (Get.find<MyCustomParameter>()
                .param[index]["계약일"]
                .difference(DateTime(2008, 11, 3))
                .inDays >=
            0 &&
        Get.find<MyCustomParameter>()
                .param[index]["계약일"]
                .difference(DateTime(2010, 12, 31))
                .inDays <=
            0) {
      widgets.add(CustomOXDropdownButton(
          index: index,
          keyValue:
              "2008.11.3~2010.12.31 수도권 미분양주택 취득분 조세특례제한법 제98조2 링크 : https://www.law.go.kr/법령/조세특례제한법",
          controller: controller));
    }

    if (Get.find<MyCustomParameter>()
                .param[index]["계약일"]
                .difference(DateTime(2009, 2, 12))
                .inDays >=
            0 &&
        Get.find<MyCustomParameter>()
                .param[index]["계약일"]
                .difference(DateTime(2010, 2, 11))
                .inDays <=
            0) {
      widgets.add(CustomOXDropdownButton(
          index: index,
          keyValue:
              "2009.2.12(비거주자 3.16)~2010.2.11 취득 서울시 밖에 미분양주택, 자기건설신축주택 조세특례제한법 제98조의3 링크 : https://www.law.go.kr/법령/조세특례제한법",
          controller: controller));
    }

    if (Get.find<MyCustomParameter>()
                .param[index]["계약일"]
                .difference(DateTime(2010, 2, 11))
                .inDays >=
            0 &&
        Get.find<MyCustomParameter>()
                .param[index]["계약일"]
                .difference(DateTime(2011, 4, 30))
                .inDays <=
            0) {
      widgets.add(CustomOXDropdownButton(
          index: index,
          keyValue:
              "2010.2.11~2011.4.30 취득분 수도권밖 미분양주택 조세특례제한법 제98조5 링크 : https://www.law.go.kr/법령/조세특례제한법",
          controller: controller));
    }

    if (Get.find<MyCustomParameter>()
                .param[index]["계약일"]
                .difference(DateTime(2011, 3, 29))
                .inDays >=
            0 &&
        Get.find<MyCustomParameter>()
                .param[index]["계약일"]
                .difference(DateTime(2011, 12, 31))
                .inDays <=
            0) {
      widgets.add(CustomOXDropdownButton(
          index: index,
          keyValue:
              "2011.3.29 현재 준공후 미분양주택을 2011년까지 취득하고 5년이상 임대하고 양도 조세특례제한법 제98조6 링크 : https://www.law.go.kr/법령/조세특례제한법",
          controller: controller));
    }

    if (Get.find<MyCustomParameter>()
                .param[index]["계약일"]
                .difference(DateTime(2012, 9, 24))
                .inDays >=
            0 &&
        Get.find<MyCustomParameter>()
                .param[index]["계약일"]
                .difference(DateTime(2012, 12, 31))
                .inDays <=
            0) {
      widgets.add(CustomOXDropdownButton(
          index: index,
          keyValue:
              "2012.9.24 현재 미분양주택을 2012년안에 취득한 9억원 이하의 주택 조세특례제한법 제98조7 링크 : https://www.law.go.kr/법령/조세특례제한법",
          controller: controller));
    }

    if (Get.find<MyCustomParameter>()
                .param[index]["계약일"]
                .difference(DateTime(2015, 1, 1))
                .inDays >=
            0 &&
        Get.find<MyCustomParameter>()
                .param[index]["계약일"]
                .difference(DateTime(2015, 12, 31))
                .inDays <=
            0) {
      widgets.add(CustomOXDropdownButton(
          index: index,
          keyValue:
              "2015.1.1~12.31 까지 취득(취득가액 6억원 이하, 연면적 135m이하)하여 5년이상 임대한 주택 조세특례제한법 제98조8 링크 : https://www.law.go.kr/법령/조세특례제한법",
          controller: controller));
    }

    if (Get.find<MyCustomParameter>()
                .param[index]["계약일"]
                .difference(DateTime(2013, 4, 1))
                .inDays >=
            0 &&
        Get.find<MyCustomParameter>()
                .param[index]["계약일"]
                .difference(DateTime(2013, 12, 31))
                .inDays <=
            0) {
      widgets.add(CustomOXDropdownButton(
          index: index,
          keyValue:
              "2013.4.1~2013.12.31 신축주택(취득가 6억원 이하 or 85m이하) 미분양주택 조세특례제한법 제99조2 링크 : https://www.law.go.kr/법령/조세특례제한법",
          controller: controller));
    }

    return Column(children: widgets);
  }
}

class SpecialTaxDropdowns extends StatelessWidget {
  const SpecialTaxDropdowns({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyCustomParameter>(builder: (_) {
      return FractionallySizedBox(
        widthFactor: 0.7,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTitle("조특법 감면주택"),
            ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("조특법 감면주택 체크리스트"),
                          content: SpecialTaxChildern(index: index),
                        );
                      });
                },
                child: Text("검사")),
          ],
        ),
      );
    });
  }
}
