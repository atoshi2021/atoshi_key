import 'package:get/get.dart';

import 'logic.dart';

class CategoryCreateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CategoryCreateLogic());
  }
}
