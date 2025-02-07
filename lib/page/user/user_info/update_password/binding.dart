import 'package:get/get.dart';

import 'logic.dart';

class UpdatePasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UpdatePasswordLogic());
  }
}
