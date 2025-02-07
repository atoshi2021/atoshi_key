import 'package:atoshi_key/common/z_common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TranslationService extends Translations {
  // static Locale? get locale => const Locale('zh', 'Hans');
  static Locale? get locale {
    if(Constant.local.isNotEmpty){
      var localArr = Constant.local.split('_');
      return Locale(localArr[0], localArr[1]);
    }
    var saveLocal = ServiceStorage.instance.getString(SPConstants.local);
    if (saveLocal.isEmpty) {
      /// 首次进入
      var localeX = Get.deviceLocale;
      var localStr = localeX.toString();
      if (localStr.startsWith('zh')) {
        if (localStr.contains('hant')) {
          Constant.local = ALocaleType.localeTypeZhHant;
        } else {
          Constant.local = ALocaleType.localeTypeZhHans;
        }
      } else {
        Constant.local = ALocaleType.localeTypeEn;
      }
    } else {
      Constant.local = saveLocal;
    }
    ServiceStorage.instance.setString(SPConstants.local, Constant.local);
    Constant.resetLanguage();
    var localArr = Constant.local.split('_');
    return Locale(localArr[0], localArr[1]);
  }

  static const fallbackLocale = Locale('en', 'US');

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enUS,
        'zh_CN': zhHans,
        'zh_Hans': zhHans,
        'zh_Hans_US': zhHans,
        'zh_HK': zhHK,
        'zh_TW': zhHK,
        'zh_Hant': zhHK,
        'zh_Hant_HK': zhHK
      };
}
