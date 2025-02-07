import 'package:atoshi_key/common/z_common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:version_update/i18n_upDate_model.dart';
import 'package:version_update/version_update.dart';

import '../z_page.dart';

class ApplicationLogic extends GetxController {
  // AppUpdateInfo? _updateInfo;

  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  var hasLockKey = false.obs;

  // Platform messages are asynchronous, so we initialize in an async method.
  late int initTabIndex;
  final tabs = [
    BottomNavigationBarItem(
        icon: Image.asset(QImage.icMainTabHomeNormalPng),
        activeIcon: Image.asset(QImage.icMainTabHomeSelectedPng),
        label: QString.home.tr),
    BottomNavigationBarItem(
        icon: Image.asset(QImage.icMainTabCategoryNormalPng),
        activeIcon: Image.asset(QImage.icMainTabCategorySelectedPng),
        label: QString.category.tr),
    BottomNavigationBarItem(
        icon: Image.asset(QImage.icMainTabSearchNormalPng),
        activeIcon: Image.asset(QImage.icMainTabSearchSelectedPng),
        label: QString.categorySearch.tr),
    BottomNavigationBarItem(
        icon: Image.asset(QImage.icMainTabMineNormalPng),
        activeIcon: Image.asset(QImage.icMainTabMineSelectedPng),
        label: QString.mine.tr)
  ].obs;
  final pages = [
    // const CollectListPage(),
    HomePage(),
    CategoryListPage(),
    CategorySearchPage(),
    UserInfoPage()
  ];
  final pageController = PageController();
  RxInt currentIndex = 0.obs;

  bool isRegister = false;

  @override
  void onInit() {
    hasLockKey.value = (ServiceUser.to.userinfo.hasLockKey ?? false);
    initIndex();
    super.onInit();
  }

  void resetTabs() {
    tabs.clear();
    tabs.add(BottomNavigationBarItem(
        icon: Image.asset(QImage.icMainTabHomeNormalPng),
        activeIcon: Image.asset(QImage.icMainTabHomeSelectedPng),
        label: QString.home.tr));
    tabs.add(BottomNavigationBarItem(
        icon: Image.asset(QImage.icMainTabCategoryNormalPng),
        activeIcon: Image.asset(QImage.icMainTabCategorySelectedPng),
        label: QString.category.tr));
    tabs.add(BottomNavigationBarItem(
        icon: Image.asset(QImage.icMainTabSearchNormalPng),
        activeIcon: Image.asset(QImage.icMainTabSearchSelectedPng),
        label: QString.categorySearch.tr));
    tabs.add(BottomNavigationBarItem(
        icon: Image.asset(QImage.icMainTabMineNormalPng),
        activeIcon: Image.asset(QImage.icMainTabMineSelectedPng),
        label: QString.mine.tr));
  }

  @override
  void onReady() {
    pageController.jumpToPage(currentIndex.value);
    // checkForUpdate();
    delayRequest();

    super.onReady();
  }

  onPageChanged(int index) {
    pageController.jumpToPage(index);
  }

  void initIndex() {
    var params = Get.parameters['index'];
    initTabIndex = int.parse(params ?? '0');
    if (initTabIndex != 0) {
      initTabIndex = 0;
      isRegister = true;
    }
    currentIndex.value = initTabIndex;
  }

  Future<void> checkForUpdate() async {
    InAppUpdate.checkForUpdate().then((info) {
      // _updateInfo = info;
    }).catchError((e) {
      e.toString().logE();
    });
  }

  void delayRequest() {
    if (!isRegister) {
      isRegister = true;
      requestMessage();
    } else {
      requestVIPMessage();
    }
  }

  void requestMessage() {
    BaseRequest.post(
        Api.queryMessage, RequestParams.queryMessage(paramKey: 'REGISTER'),
        onSuccess: (result) {
          showGetCommonDialog(content: result['context'], title: QString.tipWellComeAtoshi.tr, confirmTitle: QString.commonIKnow.tr,
              cancel: null, confirm: () {Get.back();}, showCancel: false);
    });
  }

  void requestVIPMessage() async {
    var response = await BaseRequest.getDefault(Api.queryVIPMessage);
    var result = MemberMessageModel.fromJson(response);
    var data = result.data;
    var title = data?.title;
    var message = data?.context;
    if (title != null &&
        title.isNotEmpty &&
        message != null &&
        message.isNotEmpty) {
      showGetCommonDialog(
          content: message,
          title: title,
          confirm: () {
            Get..back()..toNamed(AppRoutes.userVIPIntroduction);
          });
    }
  }

  void buildUpgradeDialog(BuildContext context) {
    BaseRequest.post(Api.upgrade, {}, onSuccess: (data) {
      var versionQueryModel = VersionQueryModelDart.fromJson(data);
      AppUpdate.check(
          context: context,
          showCheckLoading: false,
          updateData: UpdateData(
            // topImage: Assets.iconsBgDialogUpdateTop.getImageFromLocal(width: QSize.space150,
            // height: QSize.space50, fit: BoxFit.fitWidth,),
              backColor: Colors.red,
              mandatoryUpdate: true,
              version: versionQueryModel.version?.versionNumber ?? "1.0.0",
              locale: getLocale(),
              downloadUrl: versionQueryModel.version?.url ?? "",
              content: versionQueryModel.version?.info ?? ""));
    });
  }

  LocaleType getLocale() {
    if (Constant.local == ALocaleType.localeTypeZhHans) {
      return LocaleType.zh;
    } else if (Constant.local == ALocaleType.localeTypeZhHant) {
      return LocaleType.tw;
    } else {
      return LocaleType.en;
    }
  }
}
