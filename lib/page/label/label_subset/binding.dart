import 'package:get/get.dart';

import 'logic.dart';

class LabelSubsetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LabelSubsetLogic());
  }
}
