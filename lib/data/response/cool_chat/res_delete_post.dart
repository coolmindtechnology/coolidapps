// To parse this JSON data, do
//
//     final resDeletePost = resDeletePostFromJson(jsonString);

import 'dart:convert';

ResDeletePost resDeletePostFromJson(String str) => ResDeletePost.fromJson(json.decode(str));

String resDeletePostToJson(ResDeletePost data) => json.encode(data.toJson());

class ResDeletePost {
  bool? success;
  String? message;
  dynamic data;

  ResDeletePost({
    this.success,
    this.message,
    this.data,
  });

  factory ResDeletePost.fromJson(Map<String, dynamic> json) => ResDeletePost(
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
