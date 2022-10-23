import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:capgain/param_controller.dart';

import 'dart:convert';

import 'package:dio/dio.dart';

class EstateResultPage extends StatelessWidget {
  final estateController = Get.put(EstateController());

  EstateResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Color(0xFFF6F6F8),
          margin: EdgeInsets.all(30.0),
          child: ListView(
            children: [
              Column(children: [Contents()])
            ],
          ),
        ),
      ),
    );
  }
}

class Contents extends StatelessWidget {
  final controller = Get.find<EstateController>();

  Contents({super.key});
  @override
  Widget build(BuildContext context) {
    print(controller.param);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(""),
        Text(controller.param[0]["result"]["result"][0]["BA"]["value"]
            .toString()),
        Text(controller.param[0]["result"]["result"][0]["BB"]["value"]
            .toString()),
        Text(controller.param[0]["result"]["result"][0]["BC"]["value"]
            .toString()),
        Text(controller.param[0]["result"]["result"][0]["BD"]["value"]
            .toString()),
        Text(controller.param[0]["result"]["result"][0]["BE"]["value"]
            .toString()),
        Text(controller.param[0]["result"]["result"][0]["BF"]["value"]
            .toString()),
        Text(controller.param[0]["result"]["result"][0]["BG"]["value"]
            .toString()),
        Text(controller.param[0]["result"]["result"][0]["BH"]["value"]
            .toString()),
        Text(controller.param[0]["result"]["result"][0]["BI"]["value"]
            .toString()),
        Text(controller.param[0]["result"]["result"][0]["BJ"]["value"]
            .toString()),
        Text(controller.param[0]["result"]["result"][0]["BK"]["value"]
            .toString()),
        Text(controller.param[0]["result"]["result"][0]["BL"]["value"]
            .toString()),
        Text(controller.param[0]["result"]["result"][0]["BM"]["value"]
            .toString()),
      ],
    );
  }
}
