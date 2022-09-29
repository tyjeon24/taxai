import 'package:get/get.dart';

class CapitalGainsParameter extends GetxController {
  var param = {}.obs;

  void setParam(index, key, value) {
    if (param[index] == null) {
      param[index] = {}.obs;
    }
    param[index][key] = value;
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

  void setParam(index, key, value) {
    if (param[index] == null) {
      param[index] = {}.obs;
    }
    param[index][key] = value;
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
