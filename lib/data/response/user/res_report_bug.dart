// To parse this JSON data, do
//
//     final resReportBug = resReportBugFromJson(jsonString);

import 'dart:convert';

ResReportBug resReportBugFromJson(String str) => ResReportBug.fromJson(json.decode(str));

String resReportBugToJson(ResReportBug data) => json.encode(data.toJson());

class ResReportBug {
  bool? success;
  String? message;
  Data? data;

  ResReportBug({
    this.success,
    this.message,
    this.data,
  });

  factory ResReportBug.fromJson(Map<String, dynamic> json) => ResReportBug(
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
  int? userId;
  String? category;
  String? body;
  dynamic media;
  String? status;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  Data({
    this.userId,
    this.category,
    this.body,
    this.media,
    this.status,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userId: json["user_id"],
    category: json["category"],
    body: json["body"],
    media: json["media"],
    status: json["status"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "category": category,
    "body": body,
    "media": media,
    "status": status,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "id": id,
  };
}
