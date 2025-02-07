import 'package:get/get.dart';

import 'logic.dart';

class ForgotLoginPassword2Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ForgotLoginPassword2Logic());
  }
}
