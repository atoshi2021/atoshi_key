import 'package:get/get.dart';

import 'logic.dart';

class LabelBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LabelLogic());
  }
}
