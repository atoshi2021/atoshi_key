import 'package:get/get.dart';

class AppRoutes {
  static const splash = '/splash';
  static const application = '/application';

  static const home = '/home';

  static const lock = '/lock';

  /// 用户
  static const user = '/user';
  static const userLogin = '$user/login';
  static const userRegister = '$user/register';
  static const userForgotLoginPassword = '$user/forgotLoginPassword';
  static const userForgotLoginPassword2 = '$user/forgotLoginPassword2';
  static const userForgotLoginPasswordAndSet = '$user/forgotLoginPassword/set';
  static const userinfoSet = '$user/set';
  static const userinfoSetAccount = '$user/set/account';
  static const userinfoSetAccountLogout = '$user/set/account/logout';
  static const userUpdatePassword = '$user/updatePassword';
  static const userinfoPaySetting = '$user/set/paySetting';
  static const userVIPIntroduction = '$user/set/vip/vipIntroduction';
  static const userVIPPay = '$user/set/vip/vipPay';
  static const userLoginAuthentication = '$user/login/authentication';
  static const userSetDeviceManager = '$user/set/deviceManager';
  static const userSetDeviceDetails = '$user/set/deviceDetails';
  static const userSetBindAtoshiAccount = '$user/set/bindAtoshiAccount';
  //注销账户
  static const userCancelAccount = '$user/set/userCancelAccount';

  /// category
  static const category = '/category';
  static const categoryCreate = '$category/create';
  static const categoryDetails = '$category/details';
  static const categoryUpdate = '$category/update';
  static const categorySubsetList = '$category/subsetList';
  static const categorySearch = '$category/search';
  static const categoryLabel = '$category/label';
  static const categoryFolderSort = '$category/folderSort';
  static const categoryPasswordRecycle = '$category/passwordRecycle';

  /// system
  static const system = '/system';
  static const systemChangeLanguage = '$system/changeLanguage';
  static const systemAutoFillGuide = '$system/autofillGuide';
  static const systemSecuritySetting = '$system/securitySetting';
  static const systemSecuritySettingAutoLockTime =
      '$system/SecuritySettingAutoLockTime';
  static const systemComplain = '$system/complain';
  static const systemCommonSettings = '$system/commonSettings';
  static const systemAboutUs = '$system/aboutUs';
  static const systemAboutUsWeb = '$system/aboutUsWeb';
  static const systemMyFeedback = '$system/myFeedback';
  static const systemFeedbackDetails = '$system/feedbackDetails';

  /// label
  static const label = '/label';
  static const labelSubset = '$label/subset';

  /// web
  static const web = '/web';
  static const webDefault ='$web/default';

  static Future<dynamic> toNamed(
    String page, {
    dynamic arguments,
    int? id,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
  }) async {
    return await Get.toNamed(page,
        arguments: arguments,
        id: id,
        preventDuplicates: preventDuplicates,
        parameters: parameters);
  }

  static offAllToNamed(
    String page, {
    dynamic arguments,
    int? id,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
  }) async {
    return await Get.offAllNamed(page,
        arguments: arguments, id: id, parameters: parameters);
  }

  static offNamed(
    String page, {
    dynamic arguments,
    int? id,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
  }) {
    Get.offNamed(page,
        arguments: arguments,
        id: id,
        preventDuplicates: preventDuplicates,
        parameters: parameters);
  }
}
