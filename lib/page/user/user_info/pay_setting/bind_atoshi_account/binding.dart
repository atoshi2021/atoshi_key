import 'package:get/get.dart';

import 'logic.dart';

class BindAtoshiAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BindAtoshiAccountLogic());
  }
}
