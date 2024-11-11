// To parse this JSON data, do
//
//     final resGetTotalCountByPost = resGetTotalCountByPostFromJson(jsonString);

import 'dart:convert';

ResGetTotalCountByPost resGetTotalCountByPostFromJson(String str) =>
    ResGetTotalCountByPost.fromJson(json.decode(str));

String resGetTotalCountByPostToJson(ResGetTotalCountByPost data) =>
    json.encode(data.toJson());

class ResGetTotalCountByPost {
  bool? success;
  String? message;
  DataTotalCountByPost? data;

  ResGetTotalCountByPost({
    this.success,
    this.message,
    this.data,
  });

  factory ResGetTotalCountByPost.fromJson(Map<String, dynamic> json) =>
      ResGetTotalCountByPost(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : DataTotalCountByPost.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class DataTotalCountByPost {
  dynamic likes;
  dynamic comment;
  dynamic share;

  DataTotalCountByPost({
    this.likes,
    this.comment,
    this.share,
  });

  factory DataTotalCountByPost.fromJson(Map<String, dynamic> json) =>
      DataTotalCountByPost(
        likes: json["likes"],
        comment: json["comment"],
        share: json["share"],
      );

  Map<String, dynamic> toJson() => {
        "likes": likes,
        "comment": comment,
        "share": share,
      };
}
