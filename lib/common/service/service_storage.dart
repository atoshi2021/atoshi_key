import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServiceStorage extends GetxService {
  static ServiceStorage get instance => Get.find();
  late final SharedPreferences _sb;
  Future<ServiceStorage> getInstance() async {
    _sb = await SharedPreferences.getInstance();
    return this;
  }

  Future<bool> setString(String key, String value) async {
    return await _sb.setString(key, value);
  }

  Future<bool> setBool(String key, bool value) async {
    return await _sb.setBool(key, value);
  }

  String getString(String key) => _sb.getString(key) ?? '';

  bool getBool(String key) => _sb.getBool(key) ?? false;

  Future<bool> remove(String key) async {
    return await _sb.remove(key);
  }
}
