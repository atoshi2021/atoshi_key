import 'package:get/get.dart';

import 'logic.dart';

class AccountLogoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AccountLogoutLogic());
  }
}
