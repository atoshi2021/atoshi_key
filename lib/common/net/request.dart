import 'dart:io';

import 'package:atoshi_key/common/z_common.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';

class BaseRequest {
  /// get请求
  /// [url] 请求链接
  /// [onSuccess] 数据正常返回
  /// [onFailed] 请求错误
  /// [isNeedCallError] 是否需要页面处理请求,默认未false，在base类中处理
  ///
  static void get(String url,
      {required Function(dynamic entity) onSuccess,
      Function(int code, String msg)? onFailed,
      bool? isNeedCallError = false,
      bool? isCustomToast = false}) async {
    var dio = await HttpUtil.instance.getDio();
    var resp = await dio.get(url);
    result(resp.data, onSuccess, onFailed, isNeedCallError, isCustomToast);
  }

  static void getResponse(String url,
      {required Function(dynamic entity) onSuccess,
      Function(int code, String msg)? onFailed,
      bool? isNeedCallError = false}) async {
    var dio = await HttpUtil.instance.getDio();
    var resp = await dio.get(url);
    resultResponse(resp.data, onSuccess, onFailed, isNeedCallError);
  }

  /// post 请求
  static post(String url, dynamic params,
      {required Function(dynamic entity) onSuccess,
      Function(int code, String msg)? onFailed,
      bool? isNeedCallError = false,
      bool? isCustomToast = false,
      BuildContext? context}) async {
    // BaseOptions options = BaseOptions(baseUrl: Constant.baseUrl);
    // var dio = Dio(options);
    var dio = HttpUtil.instance.get();

    var resp = await dio.post(url, data: params);

    if (context != null) {
      result(resp.data, onSuccess, onFailed, isNeedCallError, isCustomToast,
          context: context!);
    } else {
      result(resp.data, onSuccess, onFailed, isNeedCallError, isCustomToast);
    }
  }

  /// post 请求
  static postResponse(String url, dynamic params,
      {required Function(dynamic entity) onSuccess,
      Function(int code, String msg)? onFailed,
      bool? isNeedCallError = false}) async {
    // BaseOptions options = BaseOptions(baseUrl: Constant.baseUrl);
    // var dio = Dio(options);
    var dio = HttpUtil.instance.get();

    var resp = await dio.post(url, data: params);
    resultResponse(resp.data, onSuccess, onFailed, isNeedCallError);
  }

  /// 处理结果
  static void result(
      dynamic response,
      Function(dynamic entity) onSuccess,
      Function(int code, String msg)? onFailed,
      bool? isNeedCallError,
      bool? isCustomToast,
      {BuildContext? context}) {
    int code = response['code'] ?? 400;
    if (code == 100) {
      dynamic data = response['data'] ?? '';
      onSuccess.call(data);
    } else {
      String msg = response['message'] ?? '';
      switch (code) {
        case 400:
          showToast(msg);

          /// toast提醒
          break;
        case 501:
          _exitAndToLogin();
          break;
        case 502:
          break;
        default:
          if (isCustomToast ?? false) {
            if (context != null) {
              showToastOffset(context, msg);
            }
          } else {
            showToast(msg);
          }

          break;
      }
      if (isNeedCallError ?? false) {
        onFailed?.call(code, msg);
      } else {
        /// toast 提醒用户错误
        showToast(msg);
      }
    }
  }

  /// 处理结果
  static void resultResponse(
      dynamic response,
      Function(dynamic entity) onSuccess,
      Function(int code, String msg)? onFailed,
      bool? isNeedCallError) {
    int code = response['code'] ?? 400;
    if (code == 100) {
      // response.logD();
      onSuccess.call(response);
    } else {
      String msg = response['message'] ?? '';
      switch (code) {
        case 400:
          showToast(msg);

          /// toast提醒
          break;
        case 501:
          _exitAndToLogin();
          break;
        case 502:
          break;
        default:
          showToast(msg);
          break;
      }
      if (isNeedCallError ?? false) {
        onFailed?.call(code, msg);
      } else {
        /// toast 提醒用户错误
        showToast(msg);
      }
    }
  }

  /// 上传文件
  static void uploadFile(File file, int type,
      {required Function(dynamic entity) onSuccess,
      Function(int code, String msg)? onFailed,
      bool? isNeedCallError = false,
      bool? isCustomToast = false}) async {
    var dio = await HttpUtil.instance.getDio();
    var resp = await dio.post(Api.uploadFile,
        data: FormData.fromMap({
          'type': type,
          'file':
              await MultipartFile.fromFile(file.path, filename: 'uploadFile')
        }));
    result(resp.data, onSuccess, onFailed, isNeedCallError, isCustomToast);
  }

  /// 上传文件
  static Future<dynamic> uploadFileDefault(File file) async {
    var dio = await HttpUtil.instance.getDio();
    var resp = await dio.post(Api.uploadFile,
        data: FormData.fromMap({
          'file':
              await MultipartFile.fromFile(file.path, filename: 'uploadFile')
        }));
    return resp.data;
  }

  /// 默认 返回
  static Future<dynamic> postDefault(String url, dynamic params) async {
    var dio = HttpUtil.instance.get();
    var resp = await dio.post(url, data: params);
    return resp.data;
  }

  static Future<dynamic> getDefault(
    String url,
  ) async {
    var dio = await HttpUtil.instance.getDio();
    var resp = await dio.get(url);
    return resp.data;
  }

  static void _exitAndToLogin() {
    ServiceUser.to.loginOut();
    AppRoutes.offAllToNamed(AppRoutes.userLogin);
  }
}
