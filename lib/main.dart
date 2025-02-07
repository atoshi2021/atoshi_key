import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:umeng_common_sdk/umeng_common_sdk.dart';

import 'common/z_common.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Global.init();

  if (Platform.isAndroid) {
    SystemUiOverlayStyle style = const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,

        ///这是设置状态栏的图标和字体的颜色
        ///Brightness.light  一般都是显示为白色
        ///Brightness.dark 一般都是显示为黑色
        statusBarIconBrightness: Brightness.dark);
    SystemChrome.setSystemUIOverlayStyle(style);
  } else {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  }
  runApp(const MyMainApp());
  Future.delayed(const Duration(milliseconds: 300), () {
    FlutterNativeSplash.remove();
  });
}

class MyMainApp extends StatefulWidget {
  const MyMainApp({Key? key}) : super(key: key);

  @override
  State<MyMainApp> createState() => _MyMainAppState();
}

class _MyMainAppState extends State<MyMainApp> with WidgetsBindingObserver {
  late BuildContext localContext;
  Timer? timer;

  @override
  Widget build(BuildContext context) {
    var local = TranslationService.locale;
    localContext = context;
    return ScreenUtilInit(
      builder: (context, child) {
        return GetMaterialApp(
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            RefreshLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('zh','CN'),
            Locale('en','US'),
          ],
          onInit: () => ServiceUser.to,
          debugShowCheckedModeBanner: !Constant.isOnline,
          builder: EasyLoading.init(),
          theme: Theme.of(context).copyWith(scaffoldBackgroundColor: QColor.bg),
          initialRoute: ServiceUser.to.isLogin
              ? '${AppRoutes.lock}?${ElementType.systemLockState}=${ElementType.systemLockStateExit}'
              : AppRoutes.splash,
          getPages: AppPages.pages,
          themeMode: ThemeMode.system,
          locale: local,
          fallbackLocale: TranslationService.fallbackLocale,
          translations: TranslationService(),

        );
      },
      designSize: const Size(375, 667),
      minTextAdapt: true,
      splitScreenMode: true,
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _startTimer();
    ///友盟统计
    UmengCommonSdk.initCommon(
        Constant.umengAndroidKey, Constant.umengIosIdKey, 'atoshi_key');
    if (ServiceUser.to.isLogin) {
      UmengCommonSdk.onProfileSignIn(ServiceUser.to.userinfo.username ?? '');
    }

    UmengCommonSdk.setPageCollectionModeManual();
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _stopTimer();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.resumed:
        // print('resume');
        if (Constant.isChangeLock &&
                ServiceUser.to.isLogin &&
                ((ServiceUser.to.userinfo.exitLock ?? 0) == 1) ||
            isNeedLock()) {
          AppRoutes.toNamed(
              '${AppRoutes.lock}?${ElementType.systemLockState}=${ElementType.systemLockStateLogin}');
        }

        /// 可见状态
        break;
      case AppLifecycleState.paused:
        // print('paused');

        /// 切换到后台
        break;
      case AppLifecycleState.detached:
        break;
    }
  }

  /// 启动 循环倒计时
  void _startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      // '进入倒计时方法:${Constant.currentLockState} -- ${Constant.isChangeLock} --${ServiceUser.to.isLogin} --${isNeedLock()}'
      //     .logE();
      if (!Constant.currentLockState &&
          Constant.isChangeLock &&
          ServiceUser.to.isLogin &&
          isNeedLock()) {
        AppRoutes.toNamed(
            '${AppRoutes.lock}?${ElementType.systemLockState}=${ElementType.systemLockStateLogin}');
      }
    });
  }

  void _stopTimer() {
    timer?.cancel();
  }
}
