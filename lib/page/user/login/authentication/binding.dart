import 'package:get/get.dart';

import 'logic.dart';

class AuthenticationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthenticationLogic());
  }
}
