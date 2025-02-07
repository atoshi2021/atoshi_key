import 'dart:async';

import 'package:atoshi_key/common/get/base_category_controller.dart';
import 'package:atoshi_key/common/z_common.dart';
import 'package:get/get.dart';

abstract class BaseController extends BaseCategoryController {
  /// 发送后进入倒计时，设置为true
  bool enableSendSMS = false;
  Timer? _timer;
  String sendCodeText = QString.commonGetCode.tr;
  int downCount = 60;
  final idSendEms = 'id_send_ems';

  @override
  void onClose() {
    super.onClose();
    _timer?.cancel();
  }

  startSMSCountDown() {
    downCount = 60;
    enableSendSMS = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      downCount--;
      if (downCount <= 0) {
        enableSendSMS = false;
        sendCodeText = QString.commonGetCode.tr;
        _timer?.cancel();
      } else {
        sendCodeText = downCount.toString();
      }
      update([idSendEms]);
    });
  }
}
