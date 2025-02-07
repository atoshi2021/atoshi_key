import 'package:get/get.dart';

import 'logic.dart';

class CancelAccountSetPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CancelAccountSetPageSetLogic());
  }
}
