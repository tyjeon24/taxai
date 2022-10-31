import 'dart:convert';

import 'package:capgain/common_widgets/custom_dropdown.dart';
import 'package:capgain/common_widgets/custom_oxdropdown.dart';
import 'package:capgain/common_widgets/custom_price.dart';
import 'package:capgain/param_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class HoldingTaxPage extends StatelessWidget {
  final Uri loginUrl = Uri.parse(
      "https://taxai.auth.ap-northeast-2.amazoncognito.com/login?client_id=165n75nfnnvlphe5vlom6lsu9q&response_type=token&scope=aws.cognito.signin.user.admin&redirect_uri=https://tyjeon24.github.io/rktmen/callback");

  HoldingTaxPage({super.key});
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(onPressed: () => {}, child: Text('로그인'));
  }
}
