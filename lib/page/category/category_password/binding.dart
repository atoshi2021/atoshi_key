import 'package:get/get.dart';

import 'logic.dart';

class CategoryPasswordRecycleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CategoryPasswordLogic());
  }
}
