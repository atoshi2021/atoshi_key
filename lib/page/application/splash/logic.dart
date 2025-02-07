import 'package:atoshi_key/common/route/app_routes.dart';
import 'package:atoshi_key/common/service/z_service.dart';
import 'package:get/get.dart';

class SplashLogic extends GetxController {
  @override
  void onReady() {
    if (ServiceUser.to.isLogin) {
      AppRoutes.offNamed('${AppRoutes.application}?index=1');
    }
    super.onReady();
  }

  void toLogin() {
    AppRoutes.toNamed(AppRoutes.userLogin);
  }

  void toRegister() {
    AppRoutes.toNamed(AppRoutes.userRegister);
  }
}
