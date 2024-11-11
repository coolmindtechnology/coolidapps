// To parse this JSON data, do
//
//     final resCheckProfile = resCheckProfileFromJson(jsonString);

import 'dart:convert';

ResCheckProfile resCheckProfileFromJson(String str) =>
    ResCheckProfile.fromJson(json.decode(str));

String resCheckProfileToJson(ResCheckProfile data) =>
    json.encode(data.toJson());

class ResCheckProfile {
  bool? success;
  dynamic message;
  dynamic data;

  ResCheckProfile({
    this.success,
    this.message,
    this.data,
  });

  factory ResCheckProfile.fromJson(Map<String, dynamic> json) =>
      ResCheckProfile(
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
