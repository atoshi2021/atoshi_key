import 'package:get/get.dart';

import 'logic.dart';

class VerifyAtoshiIdBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VerifyAtoshiIdLogic());
  }
}
