import 'package:capgain/components/colorbase.dart';
import 'package:flutter/material.dart';

class CustomSideTitle extends StatelessWidget {
  String keyValue = "";
  CustomSideTitle(this.keyValue, {super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(5.0),
        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
            color: customTitleBackground,
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: FittedBox(child: Text(keyValue)));
  }
}
