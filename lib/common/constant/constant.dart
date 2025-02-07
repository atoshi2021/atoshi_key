import 'package:atoshi_key/common/z_common.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class Constant {
  // 是否是线上环境
  static const isOnline = false;

  /// 2021003144694147，原子密码器支付宝APP_ID
  static const alipayAppId = '2021003144694147';
  static const baseUrl = 'https://api.atoshikey.com';
  static const baseUrlTest = 'http://pwd-manager.juhaowu.cn';
  static const userDefaultHeader = 'http://rongcloud-web.qiniudn.com/docs_demo_rongcloud_logo.png';

  /// 锁屏时间
  static int userToBackTime = 0;
  /// 自动锁屏时间
  static const autoLockTime = [1, 5, 10, 30, 60];
  /// 锁屏倒计时
  static int lockTimeStart = 0;
  static bool currentLockState = false;
  /// 锁频效果跟某一些操作冲突，比如上传头像
  /// 此类操作时，需要切换为false，切换后更为true
  /// 很重要
  static bool isChangeLock = true;

  /// 当前语言
  static String local = '';
  static String language = '';
  static String region = '';

  static String umengAndroidKey ='63a94a1fba6a5259c4da019f';
  static String umengIosIdKey ='63a949f8ba6a5259c4da019c';

  static bool isChangeLanguage = false;

  /// 重置语言系统
  static void resetLanguage() {
    isChangeLanguage = true;
    if (local == ALocaleType.localeTypeZhHans) {
      language = ALanguageType.languageTypeChinese;
    } else if (local == ALocaleType.localeTypeZhHant) {
      language = ALanguageType.languageTypeTaiwan;
    } else {
      language = ALanguageType.languageTypeEnglish;
    }
    // 'local:$local Constant.language:$language}'.logE();
  }

  static LocaleType getDatePickerLocaleType() {
    if (local == ALocaleType.localeTypeZhHans) {
      return LocaleType.zh;
    } else if (local == ALocaleType.localeTypeZhHant) {
      return LocaleType.tw;
    } else {
      return LocaleType.en;
    }
  }

  /// 右侧按钮点击出现菜单
  /// [categoryEdit] 编辑
  /// [categoryCollect] 收藏
  /// [categoryDelete] 删除
  static const otherDoString = [
    QString.categoryEdit,
    QString.categoryCollect,
    QString.categoryDelete
  ];

  /// 键盘输入数据
  static const inputKeyboardData = [1, 2, 3, 4, 5, 6, 7, 8, 9, -1, 0, -2];
}
