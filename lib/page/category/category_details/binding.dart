import 'package:get/get.dart';

import 'logic.dart';

class CategoryDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CategoryDetailsLogic());
  }
}
