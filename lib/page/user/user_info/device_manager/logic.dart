import 'dart:io';

import 'package:atoshi_key/common/z_common.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';

class DeviceManagerLogic extends GetxController {
  late String currentDeviceId;

  var idDevice = 'id_device';
  List<DeviceInfo> deviceList =[];

  @override
  void onInit() {
    _initCurrentDevice();
    super.onInit();
  }

  @override
  void onReady() {
    getDeviceInfo();
    super.onReady();
  }

  void _initCurrentDevice() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      // AndroidDeviceInfo info = await deviceInfo.androidInfo;
      currentDeviceId = await AppInfoUtils.getId();
    } else if (Platform.isIOS) {
      IosDeviceInfo info = await deviceInfo.iosInfo;
      currentDeviceId = info.identifierForVendor ?? '';
    }
  }

  void getDeviceInfo() async {
    var response = await BaseRequest.getDefault(Api.queryBindDeviceList);
    var data = DeviceListModel.fromJson(response);
    if(data.code==100){
      var list = data.data??[];
      
      if(list.isNotEmpty){
          deviceList.clear();
          deviceList.addAll(list);
          update([idDevice]);
      }
    }
  }
}
