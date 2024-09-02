// To parse this JSON data, do
//
//     final resGetPostShare = resGetPostShareFromJson(jsonString);

import 'dart:convert';

ResGetPostShare resGetPostShareFromJson(String str) => ResGetPostShare.fromJson(json.decode(str));

String resGetPostShareToJson(ResGetPostShare data) => json.encode(data.toJson());

class ResGetPostShare {
  bool? success;
  dynamic message;
  String? data;

  ResGetPostShare({
    this.success,
    this.message,
    this.data,
  });

  factory ResGetPostShare.fromJson(Map<String, dynamic> json) => ResGetPostShare(
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
