import 'package:get/get.dart';

import 'logic.dart';

class SystemMyFeedbackBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SystemMyFeedbackLogic());
  }
}
