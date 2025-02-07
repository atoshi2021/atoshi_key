import 'package:atoshi_key/common/z_common.dart';
import 'package:get/get.dart';

class PaySettingLogic extends GetxController {
  // final List<>
  var info = ''.obs;
  AtoshiAccountInfo? atoshiInfo;

  @override
  void onReady() {
    _getBindAtoshiInfo();
    super.onReady();
  }

  void _getBindAtoshiInfo() async {
    var response = await BaseRequest.getDefault(Api.queryAtoshiBindInfo);
    UserBindAtoshiAccountInfoModel model =
        UserBindAtoshiAccountInfoModel.fromJson(response);
    if (model.code == 100) {
      info.value = model.data?.atoshi?.account ?? '';
      atoshiInfo = model.data?.atoshi;
    }
  }

  void unBindAtoshiAccount() async {
    if (atoshiInfo == null || atoshiInfo?.id == null) {
      return;
    }
    var response = await BaseRequest.postDefault(
        Api.unBindAtoshiAccount,
        RequestParams.getUnbindAtoshiAccountParams(
            id: '${atoshiInfo?.id}', type: 0));
    if (response['code'] == 100) {
      info.value = '';
      atoshiInfo = null;
    } else {
      response['message'].toString().toast();
    }
  }
}
