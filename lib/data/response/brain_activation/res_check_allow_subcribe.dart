// To parse this JSON data, do
//
//     final resCheckAllowSubcribe = resCheckAllowSubcribeFromJson(jsonString);

import 'dart:convert';

ResCheckAllowSubcribe resCheckAllowSubcribeFromJson(String str) =>
    ResCheckAllowSubcribe.fromJson(json.decode(str));

String resCheckAllowSubcribeToJson(ResCheckAllowSubcribe data) =>
    json.encode(data.toJson());

class ResCheckAllowSubcribe {
  bool? success;
  String? message;
  dynamic data;

  ResCheckAllowSubcribe({
    this.success,
    this.message,
    this.data,
  });

  factory ResCheckAllowSubcribe.fromJson(Map<String, dynamic> json) =>
      ResCheckAllowSubcribe(
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
