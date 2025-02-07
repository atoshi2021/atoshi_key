class UserinfoPageFunction {
  static const typeHeader = 0;
  static const typeAccount = 1;

  /// 账户与安全
  static const typeAutoSetting = 2;

  /// 自动填充设置
  static const typeSafety = 3;

  /// 安全
  static const typeVIP = 4;

  /// 支付设置
  static const typePayManager = 5;

  /// 通用设置
  static const typeCommonSetting = 6;

  /// 投诉与建议
  static const typeFeedback = 6;

  /// 投诉与建议
  static const typeAboutUs = 7;

  ///会员
  bool isHeader = false;
  String iconUrl;
  String title;

  ///1.头像，1 账号，2.auto setting，3.safety setting
  int type;

  UserinfoPageFunction(this.isHeader, this.iconUrl, this.title, this.type);
}
