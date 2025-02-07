class ElementType {
  static const register = '0';
  static const forgotLoginPassword = '1';
  static const accountLogout = '2';
  static const bindAtoshiAccount = '3';
  static const newDevice = '4';

  static const updateUserinfo = 0;
  static const updateUserSetting = 1;
  static const updateUserLoginPassword = 2;

  /// 查询收藏
  static const requestCategoryListTypeCollect = 0;

  /// 查询所有项目
  static const requestCategoryListTypeAll = 1;

  /// 查询单种类型项目
  static const requestCategoryListTypeSingle = 2;

  static const systemLockState = 'system_lock_state';

  /// 登录并进入程序，前后台切换
  static const systemLockStateLogin = '0';

  /// 用户杀进程后进入
  static const systemLockStateExit = '1';

  /// 上传头像： 0-修改头像
  static const uploadFileType = 0;
}

/// 变量类型
/// [attributeTypeImage0] 图片
/// [attributeTypePassword1] 密码
/// [attributeTypeText2] 文本
/// [attributeTypeDate3]日期
class AttributeType {
  static const attributeTypeImage0 = 0;
  static const attributeTypePassword1 = 1;
  static const attributeTypeText2 = 2;
  static const attributeTypeDate3 = 3;
}

/// 语种 language
class ALanguageType {
  static const languageTypeChinese = 'chinese';
  static const languageTypeEnglish = 'english';
  static const languageTypeTaiwan = 'taiwan';
}

/// 本地语言 locale
class ALocaleType {
  static const localeTypeEn = 'en_US';
  static const localeTypeZhHans = 'zh_Hans';
  static const localeTypeZhHant = 'zh_Hant';
}
