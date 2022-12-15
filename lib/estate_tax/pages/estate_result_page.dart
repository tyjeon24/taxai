import 'package:taxai/common_widgets/page_with_appbar.dart';
import 'package:taxai/components/colorbase.dart';
import 'package:taxai/components/param_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EstateResultBody extends StatelessWidget {
  const EstateResultBody({super.key});
  @override
  Widget build(BuildContext context) {
    return ResultTable();
  }
}

class EstateResultPage extends StatelessWidget {
  final estateController = Get.put(EstateController());

  EstateResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ResultTable();
  }
}

class ResultTable extends StatelessWidget {
  final controller = Get.find<EstateController>();

  ResultTable({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var dynamicRemarks = {};

    Widget dataTable_1;
    Widget dataTable_2;

    dynamicRemarks["일괄공제"] = "일괄공제 (인적공제 금액이 클시에는 추가 공제가능)";

    if (controller.param[0]["배우자 여부"] == false) {
      dynamicRemarks["배우자 여부"] = "배우자가 없을시에는 적용되지 않음";
    }
    if (controller.param[0]["배우자 여부"] == true) {
      if (controller.param[0]["상속인중 직계비속 "] == "0") {
        // 배우자 단독상속
        dynamicRemarks["일괄공제"] = "배우자 단독상속의 경우 기초공제(2억원) 공제 가능";
        dynamicRemarks["배우자 여부"] = "배우자 단독상속의 경우 30억 한도내에서 공제 가능";
      } else {
        dynamicRemarks["배우자 여부"] =
            "배우자 공제 최대 가능금액 - 단, 배우자가 법정지분이상 실제로 상속해야만 가능";
        dynamicRemarks["배우자 여부MIN"] = "배우자가 공제 최소금액 - 재상속시 배우자 상속세 절세가능";
      }
    }

    dataTable_1 = Container(
      padding: EdgeInsets.all(30.0),
      child: FittedBox(
        child: DataTable(
          headingRowColor:
              MaterialStateProperty.all<Color>(resultTableHeaderColor),
          border: TableBorder.all(width: 1, color: Colors.black),
          columns: [
            DataColumn(
              label: SizedBox(
                  width: 0.05 * width * 0.8,
                  child: Center(
                      child: FittedBox(
                          fit: BoxFit.fill,
                          child: Text('순서',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black))))),
            ),
            DataColumn(
              label: SizedBox(
                  width: 0.23 * width * 0.8,
                  child: Center(
                      child: FittedBox(
                          fit: BoxFit.fill,
                          child: Text('항목',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black))))),
            ),
            DataColumn(
              label: SizedBox(
                  width: 0.2 * width * 0.8,
                  child: Center(
                      child: Text('금액',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black)))),
            ),
            DataColumn(
                label: SizedBox(
                    width: 0.52 * width * 0.8,
                    child: Center(
                        child: Text('비고',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black))))),
          ],
          rows: <DataRow>[
            DataRow(
              cells: [
                DataCell(Center(child: Text('1'))),
                DataCell(Center(child: Text('총 상속재산가액'))),
                DataCell(Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                        controller.param[0]["result"]["result"][0]["BA"]
                                ["value"]
                            .toString()))),
                DataCell(Text('총 상속자산 - 총 상속부채'))
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Center(child: Text('2'))),
                DataCell(Center(child: Text('가산하는 증여재산'))),
                DataCell(Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                        controller.param[0]["result"]["result"][0]["BB"]
                                ["value"]
                            .toString()))),
                DataCell(Text('가산하는 사전증여재산'))
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Center(child: Text('3'))),
                DataCell(Center(child: Text('공과금 및 장례비용 등'))),
                DataCell(Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                        controller.param[0]["result"]["result"][0]["BC"]
                                ["value"]
                            .toString()))),
                DataCell(Text('공과금 및 장례비용 등의 합계액'))
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Center(child: Text('4'))),
                DataCell(Center(child: Text('상속세 과세가액'))),
                DataCell(Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                        controller.param[0]["result"]["result"][0]["BD"]
                                ["value"]
                            .toString()))),
                DataCell(Text('총 상속재산가액 + 가산하는 증여재산 - 공과금 및 장례비용 등'))
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Center(child: Text('5'))),
                DataCell(Center(child: Text('일괄공제'))),
                DataCell(Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                        controller.param[0]["result"]["result"][0]["BE"]
                                ["value"]
                            .toString()))),
                DataCell(Text(dynamicRemarks["일괄공제"]))
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Center(child: Text('6'))),
                DataCell(Center(child: Text('금융재산 상속공제'))),
                DataCell(Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                        controller.param[0]["result"]["result"][0]["BF"]
                                ["value"]
                            .toString()))),
                DataCell(Text('순금융재산의 가액의 20%(단, 2천만원≤금융재산상속공제≤2억원)'))
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Center(child: Text('7'))),
                DataCell(Center(child: Text('배우자 공제'))),
                DataCell(Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                        controller.param[0]["result"]["result"][0]["BG"]
                                ["value"]
                            .toString()))),
                DataCell(Text(dynamicRemarks["배우자 여부"]))
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Center(child: Text('8'))),
                DataCell(Center(child: Text('기타 공제'))),
                DataCell(Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                        controller.param[0]["result"]["result"][0]["BH"]
                                ["value"]
                            .toString()))),
                DataCell(Text('가업상속공제, 동거주택 상속공제 등'))
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Center(child: Text('9'))),
                DataCell(Center(child: Text('상속세 과세표준'))),
                DataCell(Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                        controller.param[0]["result"]["result"][0]["BI"]
                                ["value"]
                            .toString()))),
                DataCell(Text('상속세 과세가액 - 공제금액'))
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Center(child: Text('10'))),
                DataCell(Center(child: Text('최고세율'))),
                DataCell(Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                        controller.param[0]["result"]["result"][0]["BJ"]
                                ["value"]
                            .toString()))),
                DataCell(Text(''))
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Center(child: Text('11'))),
                DataCell(Center(child: Text('상속세 산출세액'))),
                DataCell(Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                        controller.param[0]["result"]["result"][0]["BK"]
                                ["value"]
                            .toString()))),
                DataCell(Text(''))
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Center(child: Text('12'))),
                DataCell(Center(child: Text('증여세액공제'))),
                DataCell(Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                        controller.param[0]["result"]["result"][0]["BL"]
                                ["value"]
                            .toString()))),
                DataCell(Text('기 증여세액'))
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Center(child: Text('13'))),
                DataCell(Center(child: Text('신고세액공제'))),
                DataCell(Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                        controller.param[0]["result"]["result"][0]["BM"]
                                ["value"]
                            .toString()))),
                DataCell(Text('상속세 과세표준의 3%'))
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Center(child: Text('14'))),
                DataCell(Center(child: Text('납부할 세액'))),
                DataCell(Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                        controller.param[0]["result"]["result"][0]["BN"]
                                ["value"]
                            .toString()))),
                DataCell(Text('최종 납부할 세액'))
              ],
            ),
          ],
        ),
      ),
    );

    if (controller.param[0]["result"]["result"]!.length == 2) {
      dataTable_2 = Container(
        padding: EdgeInsets.all(30.0),
        child: DataTable(
          headingRowColor: MaterialStateProperty.all<Color>(color),
          columns: [
            DataColumn(
              label: SizedBox(
                  width: 0.25 * width * 0.8,
                  child: Center(
                      child: Text('항목',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white)))),
            ),
            DataColumn(
              label: SizedBox(
                  width: 0.25 * width * 0.8,
                  child: Center(
                      child: Text('금액',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white)))),
            ),
            DataColumn(
                label: SizedBox(
                    width: 0.5 * width * 0.8,
                    child: Center(
                        child: Text('비고',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white))))),
          ],
          rows: <DataRow>[
            DataRow(
              cells: <DataCell>[
                DataCell(Center(child: Text('총 상속재산가액'))),
                DataCell(Align(
                  alignment: Alignment.centerRight,
                  child: Text(controller.param[0]["result"]["result"][1]["BA"]
                          ["value"]
                      .toString()),
                )),
                DataCell(Text('총 상속자산 - 총 상속부채'))
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Center(child: Text('가산하는 증여재산'))),
                DataCell(Align(
                  alignment: Alignment.centerRight,
                  child: Text(controller.param[0]["result"]["result"][1]["BB"]
                          ["value"]
                      .toString()),
                )),
                DataCell(Text('가산하는 사전증여재산'))
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Center(child: Text('공과금 및 장례비용 등'))),
                DataCell(Align(
                  alignment: Alignment.centerRight,
                  child: Text(controller.param[0]["result"]["result"][1]["BC"]
                          ["value"]
                      .toString()),
                )),
                DataCell(Text('공과금 및 장례비용 등의 합계액'))
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Center(child: Text('상속세 과세가액'))),
                DataCell(Align(
                  alignment: Alignment.centerRight,
                  child: Text(controller.param[0]["result"]["result"][1]["BD"]
                          ["value"]
                      .toString()),
                )),
                DataCell(Text('총 상속재산가액 + 가산하는 증여재산 - 공과금 및 장례비용 등'))
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Center(child: Text('일괄공제'))),
                DataCell(Align(
                  alignment: Alignment.centerRight,
                  child: Text(controller.param[0]["result"]["result"][1]["BE"]
                          ["value"]
                      .toString()),
                )),
                DataCell(Text(dynamicRemarks["일괄공제"]))
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Center(child: Text('금융재산 상속공제'))),
                DataCell(Align(
                  alignment: Alignment.centerRight,
                  child: Text(controller.param[0]["result"]["result"][1]["BF"]
                          ["value"]
                      .toString()),
                )),
                DataCell(Text('순금융재산의 가액의 20%(단, 2천만원≤금융재산상속공제≤2억원)'))
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Center(child: Text('배우자 공제'))),
                DataCell(Align(
                  alignment: Alignment.centerRight,
                  child: Text(controller.param[0]["result"]["result"][1]["BG"]
                          ["value"]
                      .toString()),
                )),
                DataCell(Text(dynamicRemarks["배우자 여부MIN"]))
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Center(child: Text('기타 공제'))),
                DataCell(Align(
                  alignment: Alignment.centerRight,
                  child: Text(controller.param[0]["result"]["result"][1]["BH"]
                          ["value"]
                      .toString()),
                )),
                DataCell(Text('가업상속공제, 동거주택 상속공제 등'))
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Center(child: Text('상속세 과세표준'))),
                DataCell(Align(
                  alignment: Alignment.centerRight,
                  child: Text(controller.param[0]["result"]["result"][1]["BI"]
                          ["value"]
                      .toString()),
                )),
                DataCell(Text('상속세 과세가액 - 공제금액'))
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Center(child: Text('최고세율'))),
                DataCell(Align(
                  alignment: Alignment.centerRight,
                  child: Text(controller.param[0]["result"]["result"][1]["BJ"]
                          ["value"]
                      .toString()),
                )),
                DataCell(Text(''))
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Center(child: Text('상속세 산출세액'))),
                DataCell(Align(
                  alignment: Alignment.centerRight,
                  child: Text(controller.param[0]["result"]["result"][1]["BK"]
                          ["value"]
                      .toString()),
                )),
                DataCell(Text(''))
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Center(child: Text('증여세액공제'))),
                DataCell(Align(
                  alignment: Alignment.centerRight,
                  child: Text(controller.param[0]["result"]["result"][1]["BL"]
                          ["value"]
                      .toString()),
                )),
                DataCell(Text('기 증여세액'))
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Center(child: Text('신고세액공제'))),
                DataCell(Align(
                  alignment: Alignment.centerRight,
                  child: Text(controller.param[0]["result"]["result"][1]["BM"]
                          ["value"]
                      .toString()),
                )),
                DataCell(Text('상속세 과세표준의 3%'))
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Center(child: Text('납부할 세액'))),
                DataCell(Align(
                  alignment: Alignment.centerRight,
                  child: Text(controller.param[0]["result"]["result"][1]["BN"]
                          ["value"]
                      .toString()),
                )),
                DataCell(Text('최종 납부할 세액'))
              ],
            ),
          ],
        ),
      );
    } else {
      dataTable_2 = SizedBox();
    }

    return ListView(
        shrinkWrap: true,
        children: [dataTable_1, SizedBox(height: 30), dataTable_2]);
  }
}
