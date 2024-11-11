// To parse this JSON data, do
//
//     final resCekFollow = resCekFollowFromJson(jsonString);

import 'dart:convert';

ResCekFollow resCekFollowFromJson(String str) =>
    ResCekFollow.fromJson(json.decode(str));

String resCekFollowToJson(ResCekFollow data) => json.encode(data.toJson());

class ResCekFollow {
  bool? success;
  String? message;
  DataFollowing? data;

  ResCekFollow({
    this.success,
    this.message,
    this.data,
  });

  factory ResCekFollow.fromJson(Map<String, dynamic> json) => ResCekFollow(
        success: json["success"],
        message: json["message"],
        data:
            json["data"] == null ? null : DataFollowing.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class DataFollowing {
  int? id;
  String? userId;
  String? followingId;
  DateTime? createdAt;
  DateTime? updatedAt;

  DataFollowing({
    this.id,
    this.userId,
    this.followingId,
    this.createdAt,
    this.updatedAt,
  });

  factory DataFollowing.fromJson(Map<String, dynamic> json) => DataFollowing(
        id: json["id"],
        userId: json["user_id"],
        followingId: json["following_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "following_id": followingId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
