import 'package:get/get.dart';

class HomepageController extends GetxController {
  var param = {}.obs;

  void setParam(var key, var value) {
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
