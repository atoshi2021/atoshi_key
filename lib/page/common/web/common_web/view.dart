import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dart:io';

import 'package:webview_flutter/webview_flutter.dart';

import '../../../../common/z_common.dart';
import 'logic.dart';

class CommonWebPage extends GetView<CommonWebLogic> {
  const CommonWebPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return QScaffold(
        title: '',
        isShowAppBar: true,
        body: WebView(
          initialUrl: controller.webUrl.value,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      );
    });
  }
}
