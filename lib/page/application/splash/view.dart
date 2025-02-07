import 'package:atoshi_key/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:atoshi_key/common/z_common.dart';
import 'package:version_update/i18n_upDate_model.dart';
import 'package:version_update/version_update.dart';
import 'logic.dart';

class SplashPage extends GetWidget<SplashLogic> {
  final logic = Get.put(SplashLogic());
  var count = 0;

  SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (count == 0) {
      buildUpgradeDialog(context);
      count++;
    }
    return QScaffold(
      backgroundColor: QColor.white,
      body: Stack(
        children: [
          _buildContent(),
          // _nextButton(),
          // _buildForgotPassword(),
        ],
      ),
    );
  }

  _buildContent() {
    return QPadding(
        child: Column(
      children: [
        _buildLogo(),
        QSpace(height: QSize.space50),
        Text(QString.contentSplash1.tr, style: QStyle.secondTitleStyle),
        QSpace(height: QSize.space40),
        QButtonGradual(
            boxShadow: QStyle.blueShadow,
            text: QString.login.tr,
            function: () {
              logic.toLogin();
            }),
        QSpace(height: QSize.space20),
        QButtonBorder(
            text: QString.registerCode.tr,
            function: () {
              logic.toRegister();
            }),
      ],
    ));
  }

  _buildLogo() {
    return Container(
      margin: EdgeInsets.only(top: QSize.space122),
      alignment: Alignment.center,
      child: Image.asset(
        Assets.logoIcIconNew,
        width: QSize.space80,
        height: QSize.space80,
        fit: BoxFit.cover,
      ),
    );
  }

  _buildForgotPassword() {
    return Positioned(
        left: QSize.space0,
        right: QSize.space0,
        bottom: QSize.space20,
        child: QButtonText(
            text: QString.loginForgotPassword.tr, function: () => {}));
  }

  void buildUpgradeDialog(BuildContext context){
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
              locale: LocaleType.zh,
              // locale: getDatePickerLocaleType(),
              downloadUrl: versionQueryModel.version?.url ?? "",
              content: versionQueryModel.version?.info ?? ""));
    });
  }
}
