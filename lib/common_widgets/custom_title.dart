import 'package:flutter/material.dart';

class CustomTitle extends StatelessWidget {
  String keyValue = "";
  CustomTitle(this.keyValue, {super.key});
  @override
  Widget build(BuildContext context) {
    return Text(keyValue, style: Theme.of(context).textTheme.headline6);
  }
}