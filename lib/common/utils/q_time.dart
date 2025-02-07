import 'package:atoshi_key/common/constant/z_constant.dart';
import 'package:atoshi_key/common/service/service_user.dart';
import 'package:atoshi_key/common/z_common.dart';
import 'package:intl/intl.dart';

/// 是否到达锁屏时间
bool isNeedLock() {
  /// 自动锁屏时间
  var autoLockTime = (ServiceUser.to.userinfo.autoLockTime ?? 10) * 60 * 1000;
  // '初始计时时间：${Constant.lockTimeStart}   当前时间:${nowMilliseconds()}-----'.logE();
  var timeQuantum = nowMilliseconds() - Constant.lockTimeStart;
  // '距离上次锁定时间已经过去:${timeQuantum / 1000 % 60}秒'.logE();
  if (autoLockTime >= timeQuantum) {
    return false;
  } else {
    resetAutoLockTime();
    return true;
  }
}

/// 当前时间戳
int nowMilliseconds() {
  return DateTime.now().millisecondsSinceEpoch;
}

void resetAutoLockTime() {
  Constant.lockTimeStart = nowMilliseconds();
}

///日期格式处理
String timeDisplayFormat(String createTime) {
  var date = DateTime.parse(createTime);
  var now = DateTime.now();
  var formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
  if (date.year == now.year && date.month == now.month && date.day == now.day) {
    // 是今天
    var formattedTime = DateFormat('HH:mm').format(date);
    return formattedTime;
  } else {
    var formattedDateTime = formatter.format(date);
    return formattedDateTime;
  }
}
