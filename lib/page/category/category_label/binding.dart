import 'package:get/get.dart';

import 'logic.dart';

class CategoryLabelBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CategoryLabelLogic());
  }
}
