import 'package:get/get.dart';

import '../../../../../common/z_common.dart';

class DeviceDetailsLogic extends GetxController {
  late DeviceDetailsParams params;

  var deviceName = ''.obs;

  var lastLoginTime = ''.obs;

  @override
  void onInit() {
    params = Get.arguments as DeviceDetailsParams;
    super.onInit();
  }

  @override
  void onReady() {
    _getDeviceInfo();
    super.onReady();
  }

  void _getDeviceInfo() async {
    var response = await BaseRequest.postDefault(Api.queryDeviceDetails,
        RequestParams.queryDeviceDetails(id: params.id));

    DeviceInfoModel info = DeviceInfoModel.fromJson(response);
    if (info.code == 100) {
      deviceName.value = info.data?.deviceName ?? '';
      lastLoginTime.value = (info.data?.updateTime ?? '').replaceAll('T', ' ');
    }
  }

  void deleteDevice() {
    BaseRequest.post(
        Api.deleteLoginDevice, RequestParams.deleteLoginDevice(id: params.id),
        onSuccess: (entity) {
      Get.back();
    });
  }
}
