import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../common/z_common.dart';

/// 关于我们 Web 版
class SystemAboutUsWebPage extends StatefulWidget {
  const SystemAboutUsWebPage({super.key});

  @override
  State<SystemAboutUsWebPage> createState() => _SystemAboutUsWebPageState();
}

class _SystemAboutUsWebPageState extends State<SystemAboutUsWebPage> {
  String? appVersion;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
    var version = Get.parameters['version'];
    print('关于我们 ==='+ '${UrlConstants.webUrl(subUrl: UrlConstants.subUrlWebsite)}&version=$version',);
  }

  @override
  Widget build(BuildContext context) {
    var version = Get.parameters['version'];

    version?.logD();
    '${UrlConstants.webUrl(subUrl: UrlConstants.subUrlWebsite)}&version=$version'.logD();
    return QScaffold(
      title: QString.commonAboutUs.tr,
      isShowAppBar: true,
      isDefaultPadding: false,
      appBarColor: QColor.colorBlueVipBg,
      backgroundColor: QColor.transparent,
      elevation: 0,
      body: WebView(
        initialUrl:
            '${UrlConstants.webUrl(subUrl: UrlConstants.subUrlWebsite)}&version=$version',
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
              launchUrl(Uri.parse(message.message),
                  mode: LaunchMode.externalApplication);
            }
          })
    };
  }
}
