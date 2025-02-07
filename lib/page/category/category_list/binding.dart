import 'package:get/get.dart';

import 'logic.dart';

class CategoryListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CategoryListLogic());
  }
}
