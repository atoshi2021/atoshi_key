import 'dart:io';

import 'package:atoshi_key/common/z_common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DefaultWebPage extends StatefulWidget {
  const DefaultWebPage({Key? key}) : super(key: key);

  @override
  State<DefaultWebPage> createState() => _DefaultWebPageState();
}

class _DefaultWebPageState extends State<DefaultWebPage> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    var url = Get.arguments;
    return QScaffold(
      title: '',
      isShowAppBar: true,
      isDefaultPadding: false,
      appBarColor: QColor.colorBlueVipBg,
      backgroundColor: QColor.transparent,
      elevation: 0,
      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
        javascriptChannels: _buildChannels(context),
      ),
    );
  }

  Set<JavascriptChannel> _buildChannels(BuildContext context) {
    return {
      JavascriptChannel(
          name: 'jumpToUrl',
          onMessageReceived: (JavascriptMessage message) {
            // message.message.toast();
            if (message.message.startsWith('http')) {
              launch(message.message);
            }
          })
    };
  }
}
