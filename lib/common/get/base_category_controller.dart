import 'package:get/get.dart';

import '../z_common.dart';

abstract class BaseCategoryController extends GetxController {
  queryIsCanCreateCategory({required Function callback}) async {
    var result = await BaseRequest.getDefault(Api.canCreateItem);

    var response = BaseResponse.fromJson(result);
    if (response.code == 100) {
      callback.call();
    } else if (response.code == 504) {
      showGetCommonDialog(
          content: response.message ?? '',
          title: '',
          confirm: () {
            // 去开通会员
            AppRoutes.toNamed(AppRoutes.userVIPIntroduction);
          });
    } else {
      response.message.toast();
    }
  }
}
