// To parse this JSON data, do
//
//     final resUpdateProfile = resUpdateProfileFromJson(jsonString);

import 'dart:convert';

ResUpdateProfile resUpdateProfileFromJson(String str) =>
    ResUpdateProfile.fromJson(json.decode(str));

String resUpdateProfileToJson(ResUpdateProfile data) =>
    json.encode(data.toJson());

class ResUpdateProfile {
  bool? success;
  String? message;
  PhotoUser? data;

  ResUpdateProfile({
    this.success,
    this.message,
    this.data,
  });

  factory ResUpdateProfile.fromJson(Map<String, dynamic> json) =>
      ResUpdateProfile(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : PhotoUser.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class PhotoUser {
  bool? success;
  String? message;

  PhotoUser({
    this.success,
    this.message,
  });

  factory PhotoUser.fromJson(Map<String, dynamic> json) => PhotoUser(
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };
}
