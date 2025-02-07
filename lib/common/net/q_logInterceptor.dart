// ignore_for_file: file_names

import 'dart:convert';

import 'package:atoshi_key/common/z_common.dart';
import 'package:dio/dio.dart';

class QLogInterceptor extends LogInterceptor {
  QLogInterceptor() : super(request: true, requestBody: true);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (!Constant.isOnline) {
      var sb = StringBuffer('StartTime:${DateTime.now()}');
      sb.write('\nurl:${options.baseUrl}/${options.uri.path}');
      sb.write('\nmethod:${options.method}');
      sb.write('\nheaders:');
      sb.write('\n {');
      options.headers.forEach((key, value) {
        sb.write('\n  $key:$value');
      });
      sb.write('\n }');
      sb.write('\ndata:');
      sb.write('\n${options.data.toString()}');
      sb.toString().logD();
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (!Constant.isOnline) {
      'EndTime:${DateTime.now()}'
              '\nurl:${response.realUri.toString()}'
              '\nResponse:'
              '\n${jsonEncode(response.data)}'
          .logD();
    }
    handler.next(response);
  }
}
