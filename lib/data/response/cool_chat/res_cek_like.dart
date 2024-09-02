// To parse this JSON data, do
//
//     final resCekLike = resCekLikeFromJson(jsonString);

import 'dart:convert';

ResCekLike resCekLikeFromJson(String str) => ResCekLike.fromJson(json.decode(str));

String resCekLikeToJson(ResCekLike data) => json.encode(data.toJson());

class ResCekLike {
  bool? success;
  String? message;
  DataCekList? data;

  ResCekLike({
    this.success,
    this.message,
    this.data,
  });

  factory ResCekLike.fromJson(Map<String, dynamic> json) => ResCekLike(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : DataCekList.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class DataCekList {
  int? id;
  String? idPost;
  String? idUser;
  DateTime? createdAt;
  DateTime? updatedAt;

  DataCekList({
    this.id,
    this.idPost,
    this.idUser,
    this.createdAt,
    this.updatedAt,
  });

  factory DataCekList.fromJson(Map<String, dynamic> json) => DataCekList(
    id: json["id"],
    idPost: json["id_post"],
    idUser: json["id_user"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_post": idPost,
    "id_user": idUser,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
