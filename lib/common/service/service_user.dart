import 'dart:convert';

import 'package:atoshi_key/common/constant/z_constant.dart';
import 'package:atoshi_key/common/model/z_model.dart';
import 'package:atoshi_key/common/service/z_service.dart';
import 'package:get/get.dart';

class ServiceUser extends GetxController {
  static ServiceUser get to => Get.find();
  final Rx<Userinfo> _userinfo = Userinfo().obs;
  final RxString _token = ''.obs;
  final _isLogin = false.obs;
  Userinfo get userinfo => _userinfo.value;
  bool get isLogin => _isLogin.value;
  String get token => _token.value;

  @override
  void onInit() {
    super.onInit();
    // ignore: avoid_print

    _isLogin.value = ServiceStorage.instance.getBool(SPConstants.isLogin);
    // _isLogin.value = false;
    if (_isLogin.value) {
      Map<String, dynamic> entity = json.decode(
          ServiceStorage.instance.getString(SPConstants.keyUserinfo));
      _userinfo.value = Userinfo.fromJson(entity);
      _token.value = _userinfo.value.token ?? '';
    }
    // ignore: avoid_print
    // print('service_user___________init--_isLogin.value:${_isLogin.value}');
  }

  Future<void> saveUserinfo(Userinfo? userinfo) async {
    if (userinfo != null &&
        userinfo.token != null &&
        userinfo.token!.isNotEmpty) {
      _isLogin.value = true;
      _userinfo.value = userinfo;
      _token.value = userinfo.token ?? '';
      ServiceStorage.instance
          .setString(SPConstants.keyUserinfo, jsonEncode(userinfo));
      ServiceStorage.instance.setBool(SPConstants.isLogin, true);
    } else {
      _userinfo.value = Userinfo();
      _isLogin.value = false;
      _token.value = '';
      ServiceStorage.instance.remove(SPConstants.keyUserinfo);
      ServiceStorage.instance.setBool(SPConstants.isLogin, false);
    }
  }

  Future<void> loginOut() async {
    _userinfo.value = Userinfo();
    _isLogin.value = false;
    _token.value = '';
    ServiceStorage.instance.remove(SPConstants.keyUserinfo);
    ServiceStorage.instance.setBool(SPConstants.isLogin, false);
  }
}
