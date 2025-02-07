import 'package:atoshi_key/common/route/app_routes.dart';
import 'package:atoshi_key/page/category/category_password/binding.dart';
import 'package:atoshi_key/page/category/category_password/view.dart';
import 'package:atoshi_key/page/system/system_feedback_details/binding.dart';
import 'package:atoshi_key/page/system/system_feedback_details/view.dart';
import 'package:atoshi_key/page/system/system_my_feedback/binding.dart';
import 'package:atoshi_key/page/system/system_my_feedback/view.dart';
import 'package:atoshi_key/page/z_binding.dart';
import 'package:atoshi_key/page/z_page.dart';
import 'package:get/route_manager.dart';

/// 项目路由
class AppPages {
  static final List<GetPage> pages = [
    /// 启动页
    GetPage(name: AppRoutes.splash, page: () => SplashPage()),
    // Home 页
    GetPage(name: AppRoutes.home, page: () => HomePage()),

    GetPage(
        name: AppRoutes.lock,
        page: () => const LockPage(),
        binding: LockBinding(),
        transitionDuration: const Duration(milliseconds: 0)),

    /// 主页
    GetPage(name: AppRoutes.application, page: () => ApplicationPage()),

    /// 用户
    GetPage(
      name: AppRoutes.user,
      page: () => UserInfoPage(),
    ),
    GetPage(
        name: AppRoutes.userLogin,
        page: () => LoginPage(),
        binding: LoginBinding()),

    /// 登陆验证
    GetPage(
        name: AppRoutes.userLoginAuthentication,
        page: () => const AuthenticationPage(),
        binding: AuthenticationBinding()),

    /// 注册页
    GetPage(
        name: AppRoutes.userRegister,
        page: () => const RegisterPage(),
        binding: RegisterBinding()),

    /// 忘记登录密码
    GetPage(
        name: AppRoutes.userForgotLoginPassword,
        page: () => const ForgotLoginPasswordPage(),
        binding: ForgotLoginPasswordBinding()),

    /// 忘记登录密码2
    GetPage(
        name: AppRoutes.userForgotLoginPassword2,
        page: () => const ForgotLoginPassword2Page(),
        binding: ForgotLoginPassword2Binding()),

    /// 忘记密码-设置
    GetPage(
        name: AppRoutes.userForgotLoginPasswordAndSet,
        page: () => const ForgotLoginPasswordAndSetPage(),
        binding: ForgotLoginPasswordAndSetBinding()),

    /// 用户信息设置
    GetPage(
        name: AppRoutes.userinfoSet,
        page: () => const UserinfoSetPage(),
        binding: UserinfoSetBinding()),

    /// 账号安全
    GetPage(
      name: AppRoutes.userinfoSetAccount,
      page: () => UserinfoAccountPage(),
    ),

    /// 注销账号
    GetPage(
        name: AppRoutes.userinfoSetAccountLogout,
        page: () => const AccountLogoutPage(),
        binding: AccountLogoutBinding()),

    /// 修改登陆密码
    GetPage(
        name: AppRoutes.userUpdatePassword,
        page: () => const UpdatePasswordPage(),
        binding: UpdatePasswordBinding()),

    /// 设置
    GetPage(
        name: AppRoutes.userinfoPaySetting,
        page: () => const PaySettingPage(),
        binding: PaySettingBinding()),

    /// vip 简介
    GetPage(
        name: AppRoutes.userVIPIntroduction,
        page: () => const VIPIntroductionPage(),
        binding: VIPIntroductionBinding()),

    /// VIP 支付
    GetPage(
        name: AppRoutes.userVIPPay,
        page: () => const VIPPayPage(),
        binding: VIPPayBinding()),

    /// 设备管理
    GetPage(
        name: AppRoutes.userSetDeviceManager,
        page: () => const DeviceManagerPage(),
        binding: DeviceManagerBinding()),

    /// 设备信息
    GetPage(
        name: AppRoutes.userSetDeviceDetails,
        page: () => const DeviceDetailsPage(),
        binding: DeviceDetailsBinding()),
    GetPage(
        name: AppRoutes.userSetBindAtoshiAccount,
        page: () => const BindAtoshiAccountPage(),
        binding: BindAtoshiAccountBinding()),

    //注销账户
    GetPage(
        name: AppRoutes.userCancelAccount,
        page: () => const CancelAccountSetPage(),
        binding: CancelAccountSetPageBinding()),

    /// 类目-列表页
    GetPage(name: AppRoutes.category, page: () => CategoryListPage()),

    /// 类目-创建页
    GetPage(
        name: AppRoutes.categoryCreate,
        page: () => const CategoryCreatePage(),
        binding: CategoryCreateBinding()),

    /// 类目-详情页
    GetPage(
        name: AppRoutes.categoryDetails,
        page: () => const CategoryDetailsPage(),
        binding: CategoryDetailsBinding()),

    /// 类目-修改页
    GetPage(
        name: AppRoutes.categoryUpdate,
        page: () => CategoryUpdatePage(),
        binding: CategoryUpdateBinding()),

    /// 类目 子集类型的数据列表
    GetPage(
        name: AppRoutes.categorySubsetList,
        page: () => const CategorySubsetListPage(),
        binding: CategorySubsetListBinding()),

    /// 搜索
    GetPage(
        name: AppRoutes.categorySearch,
        page: () => CategorySearchPage(),
        binding: CategorySearchBinding()),
    GetPage(
        name: AppRoutes.categoryLabel,
        page: () => const CategoryLabelPage(),
        binding: CategoryLabelBinding()),
    GetPage(
        name: AppRoutes.categoryFolderSort,
        page: () => const CategoryFolderSortPage(),
        binding: CategoryFolderSortBinding()),

    /// 系统-主页
    GetPage(
      name: AppRoutes.system,
      page: () => SystemHomePage(),
      binding: SystemHomeBinding(),
    ),

    /// 系统-修改语言页
    GetPage(
        name: AppRoutes.systemChangeLanguage,
        page: () => const SystemChangeLanguagePage(),
        binding: SystemChangeLanguageBinding()),

    /// 系统-开启自动填充指引
    GetPage(
        name: AppRoutes.systemAutoFillGuide,
        page: () => SystemAutoFillGuidePage()),

    /// 安全设置
    GetPage(
        name: AppRoutes.systemSecuritySetting,
        page: () => const SystemSecuritySettingPage(),
        binding: SystemSecuritySettingBinding()),

    /// 设置自动锁屏时间
    GetPage(
        name: AppRoutes.systemSecuritySettingAutoLockTime,
        page: () => const SystemAutoLockTimePage(),
        binding: SystemAutoLockTimeBinding()),

    /// 投诉建议
    GetPage(
        name: AppRoutes.systemComplain,
        page: () => const SystemComplainPage(),
        binding: SystemComplainBinding()),

    /// 通用设置
    GetPage(
        name: AppRoutes.systemCommonSettings,
        page: () => const SystemSettingPage(),
        binding: SystemSettingBinding()),

    /// 关于我们
    GetPage(
        name: AppRoutes.systemAboutUs,
        page: () => const SystemAboutUsPage(),
        binding: SystemAboutUsBinding()),
    // 关于我们
    GetPage(
        name: AppRoutes.systemAboutUsWeb,
        page: () => const SystemAboutUsWebPage()),

    /// 标签列表
    GetPage(
        name: AppRoutes.label,
        page: () => const LabelPage(),
        binding: LabelBinding()),

    /// 标签内容列表
    GetPage(
        name: AppRoutes.labelSubset,
        page: () => const LabelSubsetPage(),
        binding: LabelSubsetBinding()),

    /// web
    GetPage(
        name: AppRoutes.web,
        page: () => const CommonWebPage(),
        binding: CommonWebBinding()),
    GetPage(name: AppRoutes.webDefault, page: () => const DefaultWebPage()),

    ///我的反馈
    GetPage(
        name: AppRoutes.systemMyFeedback,
        page: () => const SystemMyFeedbackPage(),
        binding: SystemMyFeedbackBinding()),

    ///反馈详情
    GetPage(
        name: AppRoutes.systemFeedbackDetails,
        page: () => const SystemFeedbackDetailsPage(),
        binding: SystemFeedbackDetailsBinding()),

    ///密码回收站
    GetPage(
        name: AppRoutes.categoryPasswordRecycle,
        page: () => const CategoryPasswordRecyclePage(),
        binding: CategoryPasswordRecycleBinding()),
  ];
}
