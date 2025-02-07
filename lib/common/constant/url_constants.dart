import 'package:atoshi_key/common/z_common.dart';

class UrlConstants {
  static const webUrlOnline = 'https://h5.atoshikey.com/#/';
  static const webUrlTest = 'http://appseven.libangtianbo.net.cn/#/';
  static const webUrlTestQD = 'http://10.100.103.220:9090/#/';

  static const subUrlPrivacyPolicy = 'privacyPolicy';
  static const subUrlUserAgreement = 'userAgreement';
  static const subUrlIntroduction = 'introduction';
  static const subUrlWebsite = 'aboutUs';

  static String webUrl({required String subUrl}) {
    var baseUrl = Constant.isOnline ? webUrlOnline : webUrlTest;
    return '$baseUrl$subUrl'.appendLanguage();
  }
}
