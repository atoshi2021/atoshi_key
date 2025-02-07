import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../z_common.dart';

Future showGetCommonDialog(
    {required String content,
    String? title,
    String? cancelTitle,
    String? confirmTitle,
    Function? cancel,
    Function? confirm,
    bool? showCancel}) {
  return Get.dialog(Center(
    child: Container(
      padding: EdgeInsets.symmetric(
          horizontal: QSize.boundaryPage15, vertical: QSize.space20),
      decoration: whiteR10(),
      constraints: BoxConstraints(maxHeight: QSize.space400),
      margin: EdgeInsets.symmetric(horizontal: QSize.space40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Visibility(
              visible: (title ?? '').isNotEmpty,
              child: buildTitle(title: title ?? '')),
          QSpace(height: QSize.space15),
          buildDescTitle(title: content),
          QSpace(height: QSize.space20),
          Row(
            children: [
              Visibility(
                  visible: showCancel ?? true,
                  child: Expanded(
                    child: QButtonRadius(
                      bgColor: QColor.btnGrey,
                      text: cancelTitle ?? QString.commonCancel.tr,
                      callback: () => cancel?.call() ?? {Get.back()},
                    ),
              )),
              QSpace(width: QSize.space10),
              Expanded(
                child: QButtonRadius(
                  bgColor: QColor.colorBlue,
                  textColor: QColor.white,
                  text: confirmTitle ?? QString.commonConfirm.tr,
                  callback: () => confirm?.call(),
                ),
              ),
            ],
          )
        ],
      ),
    ),
  ));
}
