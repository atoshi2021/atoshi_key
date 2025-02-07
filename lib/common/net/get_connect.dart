import 'dart:collection';

import 'package:atoshi_key/common/constant/constant.dart';
import 'package:get/get_connect.dart';

import 'encrypt_utils.dart';

class BaseConnect extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = Constant.baseUrl;
    httpClient.addRequestModifier<void>((request) {
      String method = request.method;
      if (method == 'POST') {
        if (request.files != null) {}
      }
      return request;
    });
  }

  /// 设置额外的body
  SplayTreeMap setAuthorizationBody(Map<dynamic, dynamic>? params) {
    //创建临时map
    var treeMap = SplayTreeMap();
    //进行参数处理
    String appTimeStamp = DateTime.now().millisecondsSinceEpoch.toString();
    //同一次请求，生成一个，用字段存储一下，不要用一次调一次。
    String appNonce = EncryptUtils.getAppNonce();
    //先增加2个参数
    // tempMap["citizenship"] = 'AI';
    // tempMap["appTimeStamp"] = appTimeStamp;
    // tempMap["appNonce"] = appNonce;
    treeMap["appTimeStamp"] = appTimeStamp;
    treeMap["appNonce"] = appNonce;
    //在拼接其他参数
    params?.forEach((key, value) {
      if (value != null) {
        //将参数有序的添加到
        // tempMap[key] = value;
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
    //在拼接其他参数
    // params?.forEach((key, value) {
    //   if (value != null) {
    //     //将参数有序的添加到
    //     tempMap[key] = value;
    //     paramsString
    //       ..write(key)
    //       ..write("=")
    //       ..write(value)
    //       ..write("&");
    //   }
    // });
    ///
    paramsString
      ..write("signatureKey")
      ..write("=")
      ..write("c09a463f-e5bc-4834-a471-6a18c6570758");
    // ..write(EncryptUtils.getSignKey())
    // ..write(appNonce);
    // ignore: avoid_print
    // print('签名前：${paramsString.toString()}');
    var appSign = EncryptUtils.generateMd5(paramsString.toString());
    treeMap["appSign"] = appSign;
    return treeMap;
  }
}
