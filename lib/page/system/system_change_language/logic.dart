import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/z_common.dart';
import '../../application/logic.dart';

class SystemChangeLanguageLogic extends GetxController {
  List<LanguageModel> languageList = [];
  final idList = 'id_list';

  @override
  void onInit() {
    _initLanguageData();
    super.onInit();
  }

  void _initLanguageData() {
    languageList.add(LanguageModel(ALocaleType.localeTypeZhHans, '简体中文'));
    languageList.add(LanguageModel(ALocaleType.localeTypeZhHant, '繁體中文'));
    languageList.add(LanguageModel(ALocaleType.localeTypeEn, 'English'));
  }

  /// 切换语言
  changeLanguage(String languageCode) {
    if (Constant.local != languageCode) {
      Constant.local = languageCode;
      update([idList]);
      Constant.resetLanguage();
      HttpUtil.instance.resetHeaders();
      var languageArr = languageCode.split('_');
      Get.updateLocale(Locale(languageArr[0], languageArr[1]));
      ServiceStorage.instance.setString(SPConstants.local, Constant.local);
      QString.systemLanguageChangeSuccessfully.tr.toast();
      AppRoutes.toNamed(AppRoutes.systemChangeLanguage)
          .then((value) => Get.find<ApplicationLogic>().resetTabs());
    }
  }
}
