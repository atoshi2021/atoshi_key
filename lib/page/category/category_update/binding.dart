import 'package:get/get.dart';

import 'logic.dart';

class CategoryUpdateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CategoryUpdateLogic());
  }
}
