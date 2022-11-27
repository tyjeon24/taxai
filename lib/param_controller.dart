import 'package:get/get.dart';

class HoldingController extends GetxController {
  var param = {}.obs;

  void setParam(int index, var key, var value) {
    if (param[index] == null) {
      param[index] = {}.obs;
    }
    param[index][key] = value;
  }
}

class EstateController extends GetxController {
  var param = {}.obs;

  void setParam(int index, var key, var value) {
    if (param[index] == null) {
      param[index] = {}.obs;
    }
    param[index][key] = value;
  }
}

class CapitalGainsParameter extends GetxController {
  var param = {}.obs;

  void setParam(int index, var key, var value) {
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
    super.onInit();
    ever(
      param,
      (_) {
        // ignore: avoid_print
        print('$_');
      },
    );
  }
}

class MyCustomParameter extends GetxController {
  var param = {}.obs;

  void setParam(int index, var key, var value) {
    if (param[index] == null) {
      param[index] = {}.obs;
    }
    param[index][key] = value;
  }

  @override
  void onInit() {
    super.onInit();
    ever(
      param,
      (_) {
        // ignore: avoid_print
        print('$_');
      },
    );
  }
}
