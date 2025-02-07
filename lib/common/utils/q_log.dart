import 'package:atoshi_key/common/z_common.dart';
import 'package:logger/logger.dart';

class QLog {
  static const maxLength = 800; //
  static final Logger _logger = Logger(
    printer: PrefixPrinter(PrettyPrinter(
        printTime: false,
        lineLength: 300,
        methodCount: 0,
        printEmojis: false,
        colors: true,
        noBoxingByDefault: false)),
  );

  static void logV(dynamic message) => log(message, (info) => _logger.v(info));

  static void logD(dynamic message) => log(message, (info) => _logger.d(info));

  static void logI(dynamic message) => log(message, (info) => _logger.i(info));

  static void logW(dynamic message) => log(message, (info) => _logger.w(info));

  static void logE(dynamic message) => log(message, (info) => _logger.e(info));

  static void log(dynamic message, Function(String info) fun) {
    if (Constant.isOnline) {
      return;
    }
    

    if (message.length > maxLength) {
      int count = (message.length ~/ maxLength);
      for (int i = 0; i < count; i++) {
        fun.call(
            message.toString().substring(i * maxLength, (i + 1) * maxLength));
      }
      if (message.length % maxLength != 0) {
        fun.call(message.toString().substring(count * maxLength));
      }
    } else {
      fun.call(message);
    }
  }
}
