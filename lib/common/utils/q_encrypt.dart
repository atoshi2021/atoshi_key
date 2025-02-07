
import 'package:atoshi_key/common/z_common.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter/services.dart';
import 'package:pointycastle/asymmetric/api.dart';

class QEncrypt {
  static String _publicKey = 'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAtebUTEgxZgIttpB5cA7e\n'
      '2jPbfCbUcvehtiI2w+qgMfNTKPSV6WMfKd5UQrfDDP0onkLQOk9aif4eLpeDkmh3\n'
      '8Qn25xZ/r0tiVMr8Z1S317yIsgVU2ajiQ1Q1/SVCqYXgDYoa5qjyq8pB76sNNdGv\n'
      'HcqyfqMKuxMrqVbpSmD4FZQGOinRUeYiwkVfmEcErnUjgfVGc/Ngo4Afofehj2hV\n'
      'lG7re6MdRTzXIUdY77nz0vnrTh/xodpA538DNXc2iZ8PbK3R/Nb0aTlyWK/vF6Nb\n'
      'Hfspig8qs3BTM7RhbiaF87jJzCiR6ndoTxyulTJzMF+NMhl85y2QxgQGvGvVCFI8\n'
      'vQIDAQAB';
  static String _privateKey =
      'MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC15tRMSDFmAi22\n'
      'kHlwDt7aM9t8JtRy96G2IjbD6qAx81Mo9JXpYx8p3lRCt8MM/SieQtA6T1qJ/h4u\n'
      'l4OSaHfxCfbnFn+vS2JUyvxnVLfXvIiyBVTZqOJDVDX9JUKpheANihrmqPKrykHv\n'
      'qw010a8dyrJ+owq7EyupVulKYPgVlAY6KdFR5iLCRV+YRwSudSOB9UZz82CjgB+h\n'
      '96GPaFWUbut7ox1FPNchR1jvufPS+etOH/Gh2kDnfwM1dzaJnw9srdH81vRpOXJY\n'
      'r+8Xo1sd+ymKDyqzcFMztGFuJoXzuMnMKJHqd2hPHK6VMnMwX40yGXznLZDGBAa8\n'
      'a9UIUjy9AgMBAAECggEBAKGLtcFlYBGjH6wCVQcy/bG12lhBN+4+hCx36EFIbyrN\n'
      'WW6HAVg7gqKxZA24m44+isM6vSj77oGc4HsqblwpUVQNMGx8q7snbNW3TEAMmhUL\n'
      'yC6p03hWp1N6R1RhsflR/vCnVUrCgnoU70gFln7UkPwZVzpmXBJWbTFAEYHP6qNl\n'
      'yWTI+BxJfXKlXWOgkrvnHcSumGKt15A+MXLPyNbiPj50a6TIoYJfB9QEeiqfmYjy\n'
      'voGVF7/dPaERk+pfCpy7MgFLFwIH77xJJx6WLuiFzxXQE6s5JakiiTgbbYnQLzOA\n'
      'Er/8g2FVCX1tXnT7ishvUYcb1GIp4aoMeHTNUHjaEvUCgYEA6GR/OZOGbOQEMdZK\n'
      'tp2VKDjT4EYr3lmFZaTDmbZQq9/Q8KEFN4iPo4fFKJ0RZ2aAQAgk/9N1mZOU4UQS\n'
      '6UGB1jn8aaV12/9VeFNen9LNgGGNDOE4djhv3WnJwJsppnoRTbKP7/GqHefxsBVu\n'
      'SU2wu2JQTlCuxZLp1HEG5NefkOcCgYEAyGFJnOf/Z3z1XQcCgm5gcnKuN80H+acA\n'
      'kIZ9S9uGPhP68suSs8MszplYLukaLRKlQnMEaJAsaLy6Pi5OL9J9FnLSPGRZs+Mj\n'
      'JQiq+SUnqpfEzWGn45Ko8HCNKM7zhrroXUw4e2qMDMrm+lGuCmtgOYmHVxaelgy3\n'
      'h4RFX8bg/LsCgYAJPaXJdlJMFi0MhkbmSBHcTZYvPtsTtl+VkR2uCQ/gJcA7MUvx\n'
      'z15W1FlEqio9AFhtM2W1PoVYnAO5iWlvGQm+qQOed9Pd8aNGa5pBpLJDPp3LO1Fx\n'
      'cgEQvtok7IaVdhkmC8mpcuSe19BGfjOqeopiiSBEXPT2KkdeCTiK9QAFVQKBgBAn\n'
      '5+uCuRD6/j115znk9FnF7U4Kde4nDOCaN1f6ZyRyL/WLfFSKE/7EVlvR545ixnhJ\n'
      'Fb3ogewf61RAH4WzjupUb6b24FSkp5zAyig0WrJicjes/ABZPs3EBV2Y8gGW6E09\n'
      'bABnYstVQLJGC6ZDagq5j/Pxmu+2LsX6YC2Mt28pAoGAA96aWOI4HhZdRot1jVXN\n'
      'ocCOHa5UQjmfNGsu50kuYV0ay4WNSdo7PnceR83BzMdralTzO9/yFtKO59raB2N3\n'
      '4mx+WhoKiLIPUQqex92vGvQoN35bECeAbW4PBeD1yiIS4GR/fcYT/Njw1fFhmn/u\n'
      'S0J8E35XYW8Abfd9rM7X+wU=';

  static Future<String> getPublicKey() async {
    if (_publicKey.isNotEmpty) {
      return _publicKey;
    }
    String key = await rootBundle.loadString('assets/rsa/public_key.pem');
    final rows = key.split(RegExp(r'\r?|'));
    var newRows = rows
      ..removeLast()
      ..removeAt(0);
    StringBuffer sb = StringBuffer();
    for (var element in newRows) {
      sb.write(element);
    }
    _publicKey = sb.toString();
    return _publicKey;
  }

  ///  加密
  static encryption(content) async {
    final parser = RSAKeyParser();
    // String publicKeyString =
    //     await rootBundle.loadString('assets/rsa/public_key.pem');
    String publicKeyString = "-----BEGIN PUBLIC KEY-----\n$_publicKey\n-----END PUBLIC KEY-----";
    // 'publicKeyString=$publicKeyString'.logI(); // 注意这一行的输出
    RSAPublicKey publicKey = parser.parse(publicKeyString) as RSAPublicKey;
    final encryptor = Encrypter(RSA(publicKey: publicKey));
    return encryptor.encrypt(content).base64;
  }

  static void printKey() async {
    String privateKeyString =
    await rootBundle.loadString('assets/rsa/private_key.pem');
    'privateKeyString:\n$privateKeyString'.logV();
    // '_privateKey:$_privateKey'.logV();
    String rsaPrivate =
        "-----BEGIN PRIVATE KEY-----\n$_privateKey\n-----END PRIVATE KEY-----";
    '_privateKey:\n$rsaPrivate'.logV();
    'rsaPrivate==privateKeyString1${rsaPrivate == privateKeyString}'.logE();

    'privateKeyString.length:${privateKeyString.length}__rsaPrivate.length:${rsaPrivate.length}'.logE();
    String publicKeyString =
    await rootBundle.loadString('assets/rsa/public_key.pem');
    // String privateKeyString =
    // await rootBundle.loadString('assets/rsa/private_key.pem');
    'publicKeyString:\n$publicKeyString'.logV();
    String rsaPublic = "-----BEGIN PUBLIC KEY-----\n$_publicKey\n-----END PUBLIC KEY-----";
    '_publicKey:\n$rsaPublic'.logV();
    'rsaPrivate==privateKeyString1${publicKeyString == rsaPublic}'.logE();
    'publicKeyString.length:${publicKeyString.length}__rsaPublic.length:${rsaPublic.length}'.logE();
  }

  /// 解密
  static Future<String> decrypt(String decoded) async {
    final parser = RSAKeyParser();
    // String privateKeyString =
    //     await rootBundle.loadString('assets/rsa/private_key.pem');
    // 'privateKeyString:$privateKeyString'.logV();
    String privateKeyString =
        "-----BEGIN PRIVATE KEY-----\n$_privateKey\n-----END PRIVATE KEY-----";
    final privateKey = parser.parse(privateKeyString) as RSAPrivateKey;
    final encryptor = Encrypter(RSA(privateKey: privateKey));
    return encryptor.decrypt(Encrypted.fromBase64(decoded));
  }

  ///  服务器数据 加密
  static serviceEncryption(String content, serviceKey) async {
    final parser = RSAKeyParser();
    'publicKeyString=$serviceKey'.logI(); // 注意这一行的输出

    // start
    /// 这个格式千万别动，相信我
    String publicKeyString = '''
    -----BEGIN PUBLIC KEY-----
    $serviceKey
    -----END PUBLIC KEY-----
    ''';
    RSAPublicKey publicKey = parser.parse(publicKeyString) as RSAPublicKey;
    final encryptor = Encrypter(RSA(publicKey: publicKey));
    return encryptor.encrypt(content).base64;
  }

  /// 服务器数据 解密
  static Future<String> serviceDecrypt(
      String decoded, String serviceKey) async {
    final parser = RSAKeyParser();
    // String privateKeyString = await rootBundle.loadString('assets/rsa/private_key.pem');
    final privateKey = parser.parse(serviceKey) as RSAPrivateKey;
    final encryptor = Encrypter(RSA(privateKey: privateKey));
    return encryptor.decrypt(Encrypted.fromBase64(decoded));
  }

  static encryptAES_(plainText, String key) {
    final aesKey = Key.fromUtf8(key);
    final iv = IV.fromLength(16);
    // final b64key = Key.fromBase64(base64Url.encode(aesKey.bytes));
    // 'b64key:$b64key'.logE();
    // final fernet = Fernet(aesKey);
    final encryptor = Encrypter(AES(aesKey, mode: AESMode.ecb));
    return encryptor.encrypt(plainText, iv: iv).base64;
  }

  static decryptAES_(String plainText, String key) {
    // 'serviceKey:$key'.logE();
    final aesKey = Key.fromUtf8(key);
    final iv = IV.fromLength(16);
    final encryptor = Encrypter(AES(aesKey, mode: AESMode.ecb));
    return encryptor.decrypt(Encrypted.fromBase64(plainText), iv: iv);
  }
}
