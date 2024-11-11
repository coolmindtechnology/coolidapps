// To parse this JSON data, do
//
//     final resGetFollower = resGetFollowerFromJson(jsonString);

import 'dart:convert';

ResGetFollower resGetFollowerFromJson(String str) =>
    ResGetFollower.fromJson(json.decode(str));

String resGetFollowerToJson(ResGetFollower data) => json.encode(data.toJson());

class ResGetFollower {
  bool? success;
  dynamic message;
  DataFollower? data;

  ResGetFollower({
    this.success,
    this.message,
    this.data,
  });

  factory ResGetFollower.fromJson(Map<String, dynamic> json) => ResGetFollower(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : DataFollower.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class DataFollower {
  dynamic following;
  dynamic follower;
  dynamic post;

  DataFollower({
    this.following,
    this.follower,
    this.post,
  });

  factory DataFollower.fromJson(Map<String, dynamic> json) => DataFollower(
        following: json["following"],
        follower: json["follower"],
        post: json["post"],
      );

  Map<String, dynamic> toJson() => {
        "following": following,
        "follower": follower,
        "post": post,
      };
}
