
class TextInputFormatterFlutter {
  ///手机号验证
  static bool isPhone(String str) {
    //先只管国内的手机号
    var hasMatch = RegExp(r"[1][3456789]\d{9}").hasMatch(str);
    if (!hasMatch) {
      // ToastUtil.showToast(S.current.please_enter_correctly_phone);
    }
    return hasMatch;
  }

  //支付密码 只能是数字
  static bool checkPayPassword(String str) {
    //先只管国内的手机号
    var hasMatch = RegExp(r"^[0-9]*$").hasMatch(str);
    if (!hasMatch) {
      return false;
    }
    return hasMatch;
  }

//验证：使用8-20个字符 字符串中至少得有 字母、数字、特殊字符 其中两类
  static bool isPassWord(String value) {
    //忽略表情
    // RegExp regexp = RegExp("[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF
    // \\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]");
    // inputFormatters.add(BlacklistingTextInputFormatter(regexp));
    var isPassword = RegExp(r"^(?![a-zA-Z]+$)(?![0-9]+$)(?![\\W_]+$)[a-zA-Z0-9\\W_]{8,20}$")
            // r'^(?=.*\\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&*()_+])[0-9a-zA-Z!@#$%^&*()_+]+$')
            .hasMatch(value);
        // && !isChinese(value) && !regexp.hasMatch(value);
    return isPassword;
  }

  ///验证中文
  static bool isChinese(String value) {
    return RegExp(
        r"[\u4e00-\u9fa5]")
        .hasMatch(value);
  }

  static bool isEmail(String input, {bool isShowToast = false}) {
    if (input.isEmpty) return false;
    // 邮箱正则
    String regexEmail =
        r"^([a-z0-9A-Z_]+[-|\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\.)+[a-zA-Z]{2,}$";
    var hasMatch = RegExp(regexEmail).hasMatch(input);
    if (!hasMatch && isShowToast) {
      // ToastUtil.showToast(S.current.please_enter_email);
    }
    return hasMatch;
  }

  ///验证输入的账号(手机号或者邮箱)是否正确
  // static bool isAccount({
  //   required String account,
  //   required String accountType,
  // }) {
  //   if (accountType == Constants.PHONE) {
  //     return isPhone(account);
  //   } else {
  //     return isEmail(account, isShowToast: true);
  //   }
  // }
}
