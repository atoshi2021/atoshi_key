import 'package:atoshi_key/common/z_common.dart';
import 'package:get/get.dart';

class VIPIntroductionLogic extends GetxController {
  VIPDescriptionModel? model;
  void toPay() {
    AppRoutes.toNamed(AppRoutes.userVIPPay, arguments:model);
  }

  var desc = ''.obs;

  @override
  void onReady() {
    _getVIPBriefIntroduction();
    super.onReady();
  }

  void _getVIPBriefIntroduction() {
    BaseRequest.getResponse(Api.queryMemberInfo, onSuccess: ((entity) {
      model = VIPDescriptionModel.fromJson(entity);
      var data = model?.data;
      if (data != null) {
        desc.value = data.description ?? '';
      }
    }));
  }

}
