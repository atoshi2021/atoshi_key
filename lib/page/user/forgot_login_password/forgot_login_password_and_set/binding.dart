import 'package:get/get.dart';

import 'logic.dart';

class ForgotLoginPasswordAndSetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ForgotLoginPasswordAndSetLogic());
  }
}
