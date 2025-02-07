import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:hex/hex.dart';
import 'package:uuid/uuid.dart';

/// 创建时间：2022/6/17
/// 作者：lqx
/// 描述：处理加解密/hash等
class EncryptUtils {
  static const String a = "3F3327283C2F273229352A3C";
  static const String b = "0905111E0A1911041F031819";
  static const String c = "0905111E0A1911041F031819";
  static const String d =
      "2528270E1E337507066C60027474717F1C077E0E602E76302E2B1236202E1106";
  static const String e =
      "2C2432241510766C18027F371C3010767770620B60077635221C103300347604";

  static final String _signKey = _xorDecode(a + b, c);

  static final String _loginPwdKey = _xorDecode(a, b);

  static final String _payPwdKey = _xorDecode(e, c);

  static String getEncryptLoginPwd(String content) {
    return getSignature(content, _loginPwdKey);
  }

  static String getEncryptPayPwd(String content) {
    return getSignature(content, _payPwdKey);
  }

  static String getEncryptSign(String content) {
    return getSignature(content, _signKey);
  }

  static String _xorDecode(String a, String key) {
    // var hashCode = key.hashCode;//dart的hashcode 是762991048
    var hashCode = -1336014010; //这个是java的hashcode 由于不一样就写死了
    // FLog.d("a:---$a");
    // FLog.d("key:---$key");
    // FLog.d("hashCode:---$hashCode");
    List<int> decode = HEX.decode(a); //将十六进制转为字节数组
    // FLog.d("decode:$decode");
    for (int i = 0; i < decode.length; i++) {
      decode[i] = decode[i] ^ hashCode;
    }
    // FLog.d("decode:$decode");
    var resultDecode = utf8.decode(decode);
    // FLog.d("resultDecode:$resultDecode");
    return resultDecode;
  }

  /// 生成签名数据 http://www.voycn.com/article/conglingrumenhmac-sha256
  /// 验证网站: https://www.sojson.com/hash.html
  /// HMAC（Hash-based Message Authentication Code，散列消息认证码）是一种使用密码散列函数，同时结合一个加密密钥，通过特别计算方式之后产生的消息认证码（MAC）。它可以用来保证数据的完整性，同时可以用来作某个消息的身份验证。
  /// @param data 要哈希 / 散列的值
  /// @param securityKey 秘钥
  static String getSignature(String data, String securityKey) {
    // FLog.d("data:" + data);
    // FLog.d("securityKey:" + securityKey);
    var key = utf8.encode(securityKey);
    var bytes = utf8.encode(data);
    // var hmacSha256 = Hmac(sha256, key); // 使用 HMAC-SHA256
    var hmacSha1 = Hmac(sha1, key); // 使用 HMAC-SHA256
    var digest = hmacSha1.convert(bytes);
    // FLog.d("digest:" + digest.toString());
    return digest.toString();
  }

  /// 同一次请求，生成一个，用字段存储一下，不要用一次调一次。
  /// @return
  static String getAppNonce() {
    return const Uuid().v1().toString().replaceAll("-", "");
  }

  /// 计算md5
  static String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString().toUpperCase();
  }

  /// 生成key
  /// @return
  static String getSignKey() {
    return _signKey;
  }
}
