class Api {
  ///检查升级
  static const upgrade = '/ap/version/getVersion';

  /// 发送验证码
  static const sendSMS = '/ap/verify/send/code';

  /// 发送验证码
  static const checkUsername = '/ap/user/check';

  /// 发送验证码
  static const register = '/ap/user/register';

  /// 登录
  static const login = '/ap/auth/login';

  /// 注销账户
  static const cancelAccount = '/ap/user/cancel';

  /// 退出登录
  static const logout = '/ap/auth/logout';

  /// 类目总览
  static const queryCategoryList = '/ap/item/category/list';

  static const queryCategoryTypeList = '/ap/item/category/all/list';

  /// 通用检测验证码
  static const checkVerifyCode = '/ap/verify/check/code';

  /// 系统解锁
  static const systemUnlock = '/ap/user/unlock';

  /// 忘记密码，设置
  static const forgotPassword = '/ap/user/forget/password';

  /// 修改用户信息
  static const updateUserinfo = '/ap/user/update';

  /// 获取子类类型列表
  static const queryCategorySubsetList = '/ap/item/list';

  /// 上传文件
  static const uploadFile = '/ap/file/upload';

  /// 类型模版
  static const categoryTemplateInfo = '/ap/item/category/template/info';

  /// 创建
  static const createSubject = '/ap/item/insert';

  /// 修改项目
  static const updateProject = '/ap/item/update';

  /// 收藏、取消收藏
  static const categoryCollect = '/ap/item/favorite';

  /// 收藏、取消收藏
  static const categoryDelete = '/ap/item/delete';

  /// 项目详情
  static const queryCategoryDetails = '/ap/item/info';

  /// 获取项目自定义字段列表
  static const queryAttributeTypeList = '/ap/item/attribute/type/list';

  /// 获取加密key
  static const getAESKey = '/ap/item/key';

  /// 注销账号
  static const accountLogout = '/ap/user/cancel';

  /// 新增投诉建议
  static const commitComplain = '/ap/user/feedback/insert';

  /// 获取支付方式
  static const getPayType = '/ap/pay/method/list';

  /// 校验验证码并登陆
  static const checkDeviceAndLogin = '/ap/verify/device/check/code';

  /// 获取所有绑定的设备信息
  static const queryBindDeviceList = '/ap/device/record/list';

  /// 获取绑定的设备信息
  static const queryDeviceDetails = '/ap/device/record/info';

  /// 删除设备的绑定记录
  static const deleteLoginDevice = '/ap/device/record/delete';

  /// 搜索项目
  static const categorySearch = '/ap/item/search';

  /// 获取用户标签
  static String queryUserLabel = '/ap/label/list';

  /// 新增label
  static String addLabel = '/ap/label/insert';

  /// 获取VIP 简介
  static String queryMemberInfo = '/ap/member/info';

  /// 获取绑定信息「ATOSHI」
  static String queryAtoshiBindInfo = '/ap/bind/record/info';

  /// 绑定atoshi账号
  static String bindAtoshiAccount = '/ap/bind/record/atoshi';

  /// 统一下支付订单
  static String placeOrder = '/ap/pay/place/order';

  /// 绑定ATOSHI加密KEY
  static String getBindAtoshiAccountKey = '/ap/bind/record/key';

  /// 获取会员支付「atoshi」加密KEY
  static String getAtoshiPayKey = '/ap/pay/key';

  /// atoshi 支付
  static String atoshiPay = '/ap/pay/atoshi/pay';

  /// 支付订单查询
  static String queryOrder = '/ap/pay/order/query';

  // 标签子集列表
  static String queryLabelProjects = '/ap/item/list/label';

  static String lock = '/ap/user/lock';

  // 获取用户信息
  static String getUserinfo = '/ap/user/info';

  // 解绑
  static String unBindAtoshiAccount = '/ap/bind/record/un/atoshi';

  // 获取 弹窗消息
  static String queryMessage = '/ap/message/getMessage';

  // 获取 会员弹窗消息
  static String queryVIPMessage = '/ap/message/getMemberMessage';

  // 判断是否能创建项目
  static String canCreateItem = '/ap/item/canCreateItem';

  // 校验登陆密码
  static String checkLoginPassword = '/ap/auth/checkPassword';

  // 获取用户的项目主题跟项目
  static String itemThemeAndItemList = '/ap/itemTheme/itemThemeAndItemList';

  // 获取用户的项目主题
  static String itemThemeList = '/ap/itemTheme/itemThemeList';

  // 提交主题修改
  static String updateItemTheme = '/ap/itemTheme/updateItemTheme';

  // 查询用户投诉建议
  static String feedbackList = '/ap/user/feedback/list';

  // 查询投诉与建议回复
  static String feedbackDetails = '/ap/user/feedback/listPatent';

  //获取未读的回复次数
  static String replyCount = '/ap/user/feedback/replyCount';

  //查询删除的项目
  static String deletList = '/ap/item/deletList';

  //取消删除项目
  static String unDelete = '/ap/item/unDelete';
}
