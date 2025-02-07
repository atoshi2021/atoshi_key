import 'dart:collection';
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../z_common.dart';

class HttpUtil {
  static final HttpUtil _instance = HttpUtil._();
  static final headers = <String, dynamic>{};

  static HttpUtil get instance {
    return _instance;
  }

  factory HttpUtil() => _instance;
  late Dio _dio;

  Dio get() => _dio;
  CancelToken cancelToken = CancelToken();

  HttpUtil._() {
    BaseOptions options = BaseOptions(
      baseUrl: Constant.isOnline ? Constant.baseUrl : Constant.baseUrlTest,
      connectTimeout: 10000,
      receiveTimeout: 10000,
      headers: headers,
      contentType: 'application/json;charset=utf-8',
      responseType: ResponseType.json,
    );
    _dio = Dio(options);
    CookieJar cookieJar = CookieJar();
    _dio.interceptors.add(CookieManager(cookieJar));

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        if (ServiceUser.to.token.isNotEmpty) {
          var header = options.headers;
          header.addAll({'token': ServiceUser.to.token});
          // 'ServiceUser.to.token:${ServiceUser.to.token}'.logE();
          options.headers = header;
        }
        String method = options.method;
        if (method == 'POST' && options.data is! FormData) {
          options.data = setAuthorizationBody(options.data);
        }
        return handler.next(options);
      },
    ));
    _dio.interceptors.add(QLogInterceptor());
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: ((options, handler) {
        EasyLoading.instance
          ..loadingStyle = EasyLoadingStyle.custom
          ..backgroundColor = const Color(0xFFF4f7FB)
          ..indicatorColor = const Color(0xFF0082CD)
          ..textColor = const Color(0xFF0082CD)
          ..textStyle = const TextStyle(fontSize: 12)
          ..indicatorType = EasyLoadingIndicatorType.wave;

        if (!EasyLoading.isShow) {
          EasyLoading.show();
        }
        return handler.next(options);
      }),
      onResponse: ((e, handler) {
        _hideLoading();
        return handler.next(e);
      }),
      onError: (e, handler) {
        _hideLoading();
        showToast(e.message);
        return handler.next(e);
      },
    ));
  }

  Future<Dio> getDio({String? url, MapSS? header}) async {
    return _dio;
  }

  void _hideLoading() {
    if (EasyLoading.isShow) {
      EasyLoading.dismiss();
    }
  }

  /// 设置额外的body
  SplayTreeMap setAuthorizationBody(Map<dynamic, dynamic> params) {
    //创建临时map
    var treeMap = SplayTreeMap();
    //进行参数处理
    String appTimeStamp = DateTime.now().millisecondsSinceEpoch.toString();
    //同一次请求，生成一个，用字段存储一下，不要用一次调一次。
    treeMap["timestamp"] = appTimeStamp;
    //在拼接其他参数
    params.forEach((key, value) {
      if (value != null) {
        treeMap[key] = value;
      }
    });
    //存储参数字符串
    StringBuffer paramsString = StringBuffer();
    //先拼接前2个参数
    treeMap.forEach((key, value) {
      paramsString
        ..write(key)
        ..write("=")
        ..write(value)
        ..write("&");
    });
    paramsString
      ..write("signatureKey")
      ..write("=")
      ..write("c09a463f-e5bc-4834-a471-6a18c6570758");
    // print('签名前：${paramsString.toString()}');
    var appSign = EncryptUtils.generateMd5(paramsString.toString());
    treeMap["signature"] = appSign;
    // print('签名后：${treeMap.toString()}');
    return treeMap;
  }

  void resetHeaders() {
    _dio.options.headers['language'] = Constant.language;
    // headers['region'] = '';
  }

  static Future<void> initHeaders() async {
    headers.clear();
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    headers['language'] = Constant.language;
    headers['appVersion'] = '1.0.0';
    headers['appName'] = 'atoshi key';
    if (Platform.isAndroid) {
      AndroidDeviceInfo info = await deviceInfo.androidInfo;
      headers['appType'] = 'android';
      headers['deviceName'] = '${info.brand} ${info.model}';
      headers['deviceToken'] = await AppInfoUtils.getId();
    } else if (Platform.isIOS) {
      IosDeviceInfo info = await deviceInfo.iosInfo;
      headers['appType'] = 'ios';
      headers['deviceName'] = info.name ?? '';
      headers['deviceToken'] = info.identifierForVendor ?? '';
    }
  }
}
