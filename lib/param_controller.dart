import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'first_filter.dart';

class CapitalGainsParameter extends GetxController {
  var param = {}.obs;
  var firstFilteredList = [];

  void setParam(key, value) {
    param[key] = value;
  }

  void initParam(List<String> remainingFilter) {
    param.removeWhere((var key, var value) => !remainingFilter.contains(key));
  }

  @override
  void onInit() {
    ever(
      param,
      (_) {
        print('$_');
      },
    );
  }
}

class MyCustomParameter extends GetxController {
  var param = {}.obs;

  void setParam(key, value) {
    param[key] = value;
  }

  @override
  void onInit() {
    ever(
      param,
      (_) {
        print('$_');
      },
    );
  }
}
