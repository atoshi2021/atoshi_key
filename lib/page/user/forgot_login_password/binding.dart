import 'package:get/get.dart';

import 'logic.dart';

class ForgotLoginPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ForgotLoginPasswordLogic());
  }
}
