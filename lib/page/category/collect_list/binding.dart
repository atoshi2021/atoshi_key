import 'package:get/get.dart';

import 'logic.dart';

class CollectListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CollectListLogic());
  }
}
