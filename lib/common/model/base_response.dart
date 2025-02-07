import 'dart:convert';

BaseResponse baseResponseFromJson(String str) =>
    BaseResponse.fromJson(json.decode(str));

String baseResponseToJson(BaseResponse data) => json.encode(data.toJson());

class BaseResponse {
  BaseResponse({
    required this.code,
    required this.message,
    this.data,
  });

  final int code;
  final String? message;
  final dynamic data;

  factory BaseResponse.fromJson(Map<String, dynamic> json) => BaseResponse(
      code: json["code"], message: json["message"], data: json["data"]);

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data,
      };
}
