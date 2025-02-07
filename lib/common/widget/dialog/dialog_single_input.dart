import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../z_common.dart';

/// 单个输入框 弹窗
///
/// [hintLabel] 输入框提示文字
///
/// [isPassword] 是否是密码
Future<String?> showGetSingleInputDialog(
    {String? hintLabel, bool? isPassword}) {
  var controller = TextEditingController();
  return Get.dialog<String?>(
      Center(
        child: Container(
          constraints: BoxConstraints(maxHeight: QSize.space300),
          margin: EdgeInsets.symmetric(horizontal: QSize.space50),
          padding: EdgeInsets.symmetric(
              horizontal: QSize.boundaryPage15, vertical: QSize.space20),
          decoration: whiteR10(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              QSpace(height: QSize.space10),
              buildInputDefault(controller, hintLabel ?? '', maxLines: 1,
                  maxLength: 25, showClean: true, isPassword: isPassword),
              QSpace(height: QSize.space20),
              Row(
                children: [
                  Expanded(
                      child: QButtonGradual(
                    text: QString.commonCancel.tr,
                    fillColor: QColor.grey80,
                    function: () {
                      Get.back(result: '');
                    },
                  )),
                  QSpace(width: QSize.space10),
                  Expanded(
                      child: QButtonGradual(
                    text: QString.commonConfirm.tr,
                    function: () {
                      Get.back(result: controller.text);
                    },
                  ))
                ],
              )
            ],
          ),
        ),
      ),
      barrierDismissible: false);
}
