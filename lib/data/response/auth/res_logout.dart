// To parse this JSON data, do
//
//     final resLogout = resLogoutFromJson(jsonString);

import 'dart:convert';

ResLogout resLogoutFromJson(String str) => ResLogout.fromJson(json.decode(str));

String resLogoutToJson(ResLogout data) => json.encode(data.toJson());

class ResLogout {
  bool? success;
  String? message;
  dynamic data;

  ResLogout({
    this.success,
    this.message,
    this.data,
  });

  factory ResLogout.fromJson(Map<String, dynamic> json) => ResLogout(
        success: json["success"],
        message: json["message"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data,
      };
}
