import 'package:atoshi_key/common/z_common.dart';
import 'package:get/get.dart';

class CommonWebLogic extends GetxController {
  var webUrl = ''.obs;

  @override
  void onInit() {
    webUrl.value = Get.arguments;
    super.onInit();
  }
  @override
  void onReady() {
    'publicKeyString:${webUrl.value}'.logW;
    super.onReady();
  }
}
