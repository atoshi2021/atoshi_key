import 'package:atoshi_key/common/z_common.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

extension StringExt on String {
  void toast() {
    if (isNotEmpty) {
      showToast(this);
    }
  }

  String pwd() {
    return EncryptUtils.getEncryptLoginPwd(this);
  }

  void copy() {
    if (isNotEmpty) {
      Clipboard.setData(ClipboardData(text: this));
      QString.commonCopySuccessfully.tr.toast();
    }
  }

  /// 时间带T转换
  String toStringTime() {
    return replaceAll('T', ' ');
  }

  void logV() => QLog.logV(this);

  void logD() => QLog.logD(this);

  void logI() => QLog.logI(this);

  void logW() => QLog.logW(this);

  void logE() => QLog.logE(this);

  String appendLanguage() {
    var language = Constant.language;
    if (contains('?')) {
      return '$this&language=$language';
    } else {
      return '$this?language=$language';
    }
  }
}

extension StringEmptyExt on String? {
  void toast() {
    if (this != null && this!.isNotEmpty) {
      showToast(this!);
    }
  }

  String pwd() {
    return EncryptUtils.getEncryptLoginPwd(this ?? '');
  }

  void copy() {
    if (this != null && this!.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: this ?? ''));
      QString.commonCopySuccessfully.tr.toast();
    }
  }

  /// 时间带T转换
  String toStringTime() {
    return this ?? ''.replaceAll('T', ' ');
  }

  void logV() => QLog.logV(this);

  void logD() => QLog.logD(this);

  void logI() => QLog.logI(this);

  void logW() => QLog.logW(this);

  void logE() => QLog.logE(this);
}

extension DynamicExt on dynamic {
  void logV() => QLog.logV(toString());

  void logD() => QLog.logD(toString());

  void logI() => QLog.logI(toString());

  void logW() => QLog.logW(toString());

  void logE() => QLog.logE(toString());
}

extension MapExt on Map<String, dynamic> {
  void logV() {
    var sb = StringBuffer('[');
    forEach((key, value) {
      sb.write('$key:$value');
    });
    sb.write(']');
    QLog.logV(sb.toString());
  }

  void logD() {
    var sb = StringBuffer('[');
    forEach((key, value) {
      sb.write('$key:$value');
    });
    sb.write(']');
    QLog.logD(sb.toString());
  }

  void logI() {
    var sb = StringBuffer('[');
    forEach((key, value) {
      sb.write('$key:$value');
    });
    sb.write(']');
    QLog.logI(sb.toString());
  }

  void logW() {
    var sb = StringBuffer('[');
    forEach((key, value) {
      sb.write('$key:$value');
    });
    sb.write(']');
    QLog.logW(sb.toString());
  }

  void logE() {
    var sb = StringBuffer('[');
    forEach((key, value) {
      sb.write('$key:$value');
    });
    sb.write(']');
    QLog.logE(sb.toString());
  }
}

extension ListExt on List<dynamic> {
  void logV() {
    var sb = StringBuffer();
    for (var element in this) {
      sb.write(element.toString());
    }
    QLog.logV(sb.toString());
  }

  void logD() {
    var sb = StringBuffer();
    for (var element in this) {
      sb.write(element.toString());
    }
    QLog.logD(sb.toString());
  }

  void logI() {
    var sb = StringBuffer();
    for (var element in this) {
      sb.write(element.toString());
    }
    QLog.logI(sb.toString());
  }

  void logW() {
    var sb = StringBuffer();
    for (var element in this) {
      sb.write(element.toString());
    }
    QLog.logW(sb.toString());
  }

  void logE() {
    var sb = StringBuffer();
    for (var element in this) {
      sb.write(element.toString());
    }
    QLog.logE(sb.toString());
  }
}
