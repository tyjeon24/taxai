import 'package:get/get.dart';

class CapitalGainsParameter extends GetxController {
  var param = {}.obs;
  var firstFilteredList = [];

  void setParam(int index, var key, var value) {
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

  void setParam(int index, key, value) {
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
