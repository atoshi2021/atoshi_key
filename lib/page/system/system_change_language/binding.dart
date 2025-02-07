import 'package:get/get.dart';

import 'logic.dart';

class SystemChangeLanguageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SystemChangeLanguageLogic());
  }
}
