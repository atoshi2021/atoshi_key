import 'package:atoshi_key/common/z_common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'logic.dart';

class QrCodePayPage extends StatelessWidget {
  final logic = Get.find<QrCodePayLogic>();

  QrCodePayPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: QSize.space200,
        height: QSize.space200,
        // child: QrImage(
        //   data: '',
        // ),
      ),
    );
  }
}
