import 'package:atoshi_key/common/z_common.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SystemAboutUsLogic extends GetxController {
  String? appVersion;
  String idAppVersion = 'id_app_version';

  List<AboutUsModel> columnItems = [];

  @override
  void onInit() {
    _initColumns();
    super.onInit();
  }

  @override
  void onReady() {
    _initAppInfo();
    super.onReady();
  }

  void _initAppInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    // String appName = packageInfo.appName;
    // String packageName = packageInfo.packageName;
    appVersion = packageInfo.version;
    update([idAppVersion]);
    // String buildNumber = packageInfo.buildNumber;
  }

  void _initColumns() {
    columnItems.add(AboutUsModel(QString.systemWebsites.tr,
        UrlConstants.webUrl(subUrl: UrlConstants.subUrlIntroduction)));
    columnItems.add(AboutUsModel(QString.systemUserAgreement.tr,
        UrlConstants.webUrl(subUrl: UrlConstants.subUrlUserAgreement)));
    columnItems.add(AboutUsModel(QString.systemPrivacyPolicy.tr,
        UrlConstants.webUrl(subUrl: UrlConstants.subUrlPrivacyPolicy)));
  }

  @override
  void onClose() {
    Constant.isChangeLock = true;
    super.onClose();
  }
}
