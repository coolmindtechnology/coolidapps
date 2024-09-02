// To parse this JSON data, do
//
//     final resResetPassword = resResetPasswordFromJson(jsonString);

import 'dart:convert';

ResResetPassword resResetPasswordFromJson(String str) =>
    ResResetPassword.fromJson(json.decode(str));

String resResetPasswordToJson(ResResetPassword data) =>
    json.encode(data.toJson());

class ResResetPassword {
  bool? success;
  String? message;
  Data? data;

  ResResetPassword({
    this.success,
    this.message,
    this.data,
  });

  factory ResResetPassword.fromJson(Map<String, dynamic> json) =>
      ResResetPassword(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  bool? success;
  String? message;

  Data({
    this.success,
    this.message,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };
}
