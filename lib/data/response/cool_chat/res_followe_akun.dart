// To parse this JSON data, do
//
//     final resFollowAkun = resFollowAkunFromJson(jsonString);

import 'dart:convert';

ResFollowAkun resFollowAkunFromJson(String str) => ResFollowAkun.fromJson(json.decode(str));

String resFollowAkunToJson(ResFollowAkun data) => json.encode(data.toJson());

class ResFollowAkun {
  bool? success;
  String? message;
  FollowAkun? data;

  ResFollowAkun({
    this.success,
    this.message,
    this.data,
  });

  factory ResFollowAkun.fromJson(Map<String, dynamic> json) => ResFollowAkun(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : FollowAkun.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class FollowAkun {
  bool? success;
  String? message;

  FollowAkun({
    this.success,
    this.message,
  });

  factory FollowAkun.fromJson(Map<String, dynamic> json) => FollowAkun(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}
