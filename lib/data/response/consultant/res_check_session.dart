// To parse this JSON data, do
//
//     final resCheckSession = resCheckSessionFromJson(jsonString);

import 'dart:convert';

ResCheckSession resCheckSessionFromJson(String str) => ResCheckSession.fromJson(json.decode(str));

String resCheckSessionToJson(ResCheckSession data) => json.encode(data.toJson());

class ResCheckSession {
  bool? success;
  String? message;
  List<dynamic>? data;

  ResCheckSession({
    this.success,
    this.message,
    this.data,
  });

  factory ResCheckSession.fromJson(Map<String, dynamic> json) => ResCheckSession(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<dynamic>.from(json["data"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
  };
}
