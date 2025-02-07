import 'package:atoshi_key/common/constant/element_type.dart';
import 'package:atoshi_key/common/net/encrypt_utils.dart';
import 'package:atoshi_key/common/z_common.dart';

class RequestParams {
  ///发送验证码
  ///[username] 发送时的用户名
  ///[sendType] 功能类型：0注册
  static Map<String, dynamic> getSMSParams(String username, String sendType) =>
      {'username': username, 'sendType': sendType};

  /// 校验账号是否注册
  /// [username]
  static Map<String, dynamic> getCheckUsernameParams(String username) =>
      {'username': username};

  /// 注册
  /// [username] 登录账号
  /// [password] 登录密码
  /// [againPassword] 登录密码确认
  /// [code] 验证码
  /// [readAgree] 是否同意 用户协议/隐私政策
  static Map<String, dynamic> getRegisterParams(String username,
          String password, String againPassword, String code, bool readAgree) =>
      {
        'username': username,
        'password': password,
        'againPassword': againPassword,
        'code': code,
        'readAgree': readAgree
      };

  /// 登录 参数
  /// [username] 登录账号
  /// [password] 登录密码
  static Map<String, dynamic> getLoginParams(String username, String password,
      {int? errCode, String? code}) {
    var params = {'username': username, 'password': password};
    if (errCode != null && errCode == 502) {
      params['code'] = code ?? '';
    }
    return params;
  }

  /// 校验验证码
  /// [username]
  /// [sendType]发送类型 0-用户注册 1-忘记登录密码
  /// [code]
  static Map<String, dynamic> getCheckCodeParams(
          String username, String sendType, String code) =>
      {'username': username, 'sendType': sendType, 'code': code};

  /// 忘记密码
  /// [username]
  /// [password]
  /// [againPassword]
  static Map<String, dynamic> getForgotPasswordParams(
          String username, String password, String againPassword) =>
      {
        'username': username,
        // 'password': password,
        // 'againPassword': againPassword
        'password': EncryptUtils.getEncryptLoginPwd(password),
        'againPassword': EncryptUtils.getEncryptLoginPwd(againPassword)
      };

  static Map<String, dynamic> updateUserSettingInfo(
      {String? name,
      String? exitLock,
      String? autoLockTime,
      String? hidePassword,
      bool? hasLockKey,
      String? oldPassword,
      String? newPassword,
      String? newAgainPassword,
      required int type}) {
    var data = <String, dynamic>{'type': type};
    if (type == ElementType.updateUserinfo) {
      data['name'] = name;
    } else {
      if (exitLock != null) {
        data['exitLock'] = exitLock;
      }
      if (autoLockTime != null) {
        data['autoLockTime'] = autoLockTime;
      }
      if (hidePassword != null) {
        data['hidePassword'] = hidePassword;
      }
      if (oldPassword != null) {
        data['password'] = oldPassword.pwd();
      }
      if (newPassword != null) {
        data['newPassword'] = newPassword.pwd();
      }
      if (newAgainPassword != null) {
        data['againPassword'] = newAgainPassword.pwd();
      }
      if (hasLockKey != null) {
        data['hasLockKey'] = hasLockKey;
      }
    }
    return data;
  }

  /// 获取 项目列表
  /// [type]  类型 0-收藏 1-所有 2-类别下的项目
  /// [categoryId] 分类ID
  static Map<String, dynamic> queryCategorySubsetList(
      {required int type, int? categoryId}) {
    var data = {'type': type};
    if (categoryId != null) {
      data['categoryId'] = categoryId;
    }
    return data;
  }

  /// 登录用户解锁
  /// [password]
  static Map<String, dynamic> systemUnlock({required String password}) =>
      {'password': password};

  /// 获取文档类型模版
  /// [password]
  static Map<String, dynamic> getCategoryTemplateInfoParams(
          {required int categoryId}) =>
      {'categoryId': categoryId};

  /// 收藏、取消收藏
  /// [favorite] 0 取消收藏、1 收藏
  /// [itemId] 项目id
  static Map<String, dynamic> categoryCollectParams(
          {required int favorite, required int itemId}) =>
      {'favorite': favorite, 'itemId': itemId};

  /// 删除项目
  /// [itemId] 项目id
  static Map<String, dynamic> deleteCollectParams({required int itemId}) =>
      {'itemId': itemId};

  static Map<String, dynamic> queryCategoryDetails(
          {required int itemId, required String publicKey}) =>
      {'itemId': itemId, 'publicKey': publicKey};

  /// 获取publicKey
  static Map<String, dynamic> getAESKeyParams({required publicKey}) =>
      {'publicKey': publicKey};

  static Map<String, dynamic> getAccountLogoutParams(
          String username, String code) =>
      {'username': username, 'code': code};

  /// 提交 投诉与建议
  static Map<String, dynamic> commitComplain(
      {required int type,
      required String description,
      required String images}) {
    var data = {'type': type, 'description': description};
    if (images.isNotEmpty) {
      data['images'] = images.substring(0, images.length - 1);
    }
    return data;
  }

  /// 校验新设备并登陆
  static Map<String, dynamic> checkDeviceAndLogin(
          String username, String sendType, String code,
          {required String password}) =>
      {
        'username': username,
        'code': code,
        'sendType': sendType,
        'password': password.pwd()
      };

  /// 获取绑定的设备信息
  static Map<String, dynamic> queryDeviceDetails({required String id}) =>
      {'id': id};

  /// 闪促绑定的设备信息
  static Map<String, dynamic> deleteLoginDevice({required String id}) =>
      {'id': id};

  static Map<String, dynamic> categorySearch(
          {required String field, required int searchType}) =>
      {'field': field, 'searchType': searchType};

  static Map<String, dynamic> addLabel({required String label}) =>
      {'labelName': label};

  /// 绑定账号
  static Map<String, dynamic> bindAtoshiAccount(
          {required String account,
          required String atoshiPassword,
          required String id}) =>
      {'account': account, 'atoshiPassword': atoshiPassword, 'id': id};

  /// 统一下支付订单
  static Map<String, dynamic> getPlaceOrderParams(
          {required int payMethod, required int skuId}) =>
      {'payMethod': payMethod, 'skuId': skuId};

  /// 绑定Atoshi 账号，加密key
  static Map<String, dynamic> getBindAtoshiAccountKeyParams(
          {required String publicKey}) =>
      {'publicKey': publicKey};

  /// 绑定Atoshi 账号，加密key
  static Map<String, dynamic> getPayKeyParams({required String publicKey}) =>
      {'publicKey': publicKey};

  /// atoshi 支付
  static getAtoshiPayParams(
          {required String atoshiTradePwd,
          required int skuId,
          required String tradeNo}) =>
      {'atoshiTradePwd': atoshiTradePwd, 'skuId': skuId, 'tradeNo': tradeNo};

  /// 查询订单支付状态
  static Map<String, dynamic> queryOrderParams({required String outTradeNo}) =>
      {'outTradeNo': outTradeNo};

  // 获取 标签子集项目
  static Map<String, dynamic> queryLabelProjects({required int labelId}) =>
      {'labelId': labelId};

  // 解绑Atoshi账号
  static Map<String, dynamic> getUnbindAtoshiAccountParams(
          {required String id, required int type}) =>
      {'id': id, 'type': type};

  // 获取弹窗消息内容
  static Map<String, dynamic> queryMessage({required String paramKey}) =>
      {'paramKey': paramKey};

  // 获取sku 的支付方式
  static Map<String, dynamic> queryVipPayType({required int skuId}) =>
      {'skuId': skuId};

  // 校验用户登陆密码
  static Map<String, dynamic> getCheckUserLoginPassword(
          {required String password}) =>
      {'password': password};

  // 提交主题修改
  static Map<String, dynamic> updateItemTheme(
          {required String itemThemeList}) =>
      {'itemThemeList': itemThemeList};

  //我的反馈列表
  static Map<String, dynamic> queryFeedbackList(
          {required int pageSize, required int pageNum}) =>
      {
        'pageSize': pageSize,
        'pageNum': pageNum,
      };

  //反馈详情
  static Map<String, dynamic> feedbackDetails({required int parentId}) => {
        'parentId': parentId,
      };

  //取消删除项目
  static Map<String, dynamic> unDelete({required List itemIdList}) => {
    'itemIdList': itemIdList,
  };
}
