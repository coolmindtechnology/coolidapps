// To parse this JSON data, do
//
//     final resUpdatePassword = resUpdatePasswordFromJson(jsonString);

import 'dart:convert';

ResUpdatePassword resUpdatePasswordFromJson(String str) =>
    ResUpdatePassword.fromJson(json.decode(str));

String resUpdatePasswordToJson(ResUpdatePassword data) =>
    json.encode(data.toJson());

class ResUpdatePassword {
  bool? success;
  String? message;
  DataUpdatePassword? data;

  ResUpdatePassword({
    this.success,
    this.message,
    this.data,
  });

  factory ResUpdatePassword.fromJson(Map<String, dynamic> json) =>
      ResUpdatePassword(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : DataUpdatePassword.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class DataUpdatePassword {
  bool? success;
  String? message;

  DataUpdatePassword({
    this.success,
    this.message,
  });

  factory DataUpdatePassword.fromJson(Map<String, dynamic> json) =>
      DataUpdatePassword(
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };
}
