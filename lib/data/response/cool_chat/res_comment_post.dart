// To parse this JSON data, do
//
//     final resCreateComment = resCreateCommentFromJson(jsonString);

import 'dart:convert';

ResCreateComment resCreateCommentFromJson(String str) =>
    ResCreateComment.fromJson(json.decode(str));

String resCreateCommentToJson(ResCreateComment data) =>
    json.encode(data.toJson());

class ResCreateComment {
  bool? success;
  dynamic message;
  Data? data;

  ResCreateComment({
    this.success,
    this.message,
    this.data,
  });

  factory ResCreateComment.fromJson(Map<String, dynamic> json) =>
      ResCreateComment(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  dynamic idPost;
  dynamic comment;
  dynamic isAnonim;
  dynamic idUser;
  DateTime? updatedAt;
  DateTime? createdAt;
  dynamic id;

  Data({
    this.idPost,
    this.comment,
    this.isAnonim,
    this.idUser,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        idPost: json["id_post"],
        comment: json["comment"],
        isAnonim: json["is_anonim"],
        idUser: json["id_user"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id_post": idPost,
        "comment": comment,
        "is_anonim": isAnonim,
        "id_user": idUser,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
      };
}
