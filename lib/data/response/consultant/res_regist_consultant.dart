// To parse this JSON data, do
//
//     final resRegistConsultant = resRegistConsultantFromJson(jsonString);

import 'dart:convert';

ResRegistConsultant resRegistConsultantFromJson(String str) => ResRegistConsultant.fromJson(json.decode(str));

String resRegistConsultantToJson(ResRegistConsultant data) => json.encode(data.toJson());

class ResRegistConsultant {
  bool? success;
  String? message;
  Data? data;

  ResRegistConsultant({
    this.success,
    this.message,
    this.data,
  });

  factory ResRegistConsultant.fromJson(Map<String, dynamic> json) => ResRegistConsultant(
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
  String? titleExperience;
  String? descriptionExperience;
  dynamic document;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  Data({
    this.userId,
    this.titleExperience,
    this.descriptionExperience,
    this.document,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userId: json["user_id"],
    titleExperience: json["title_experience"],
    descriptionExperience: json["description_experience"],
    document: json["document"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "title_experience": titleExperience,
    "description_experience": descriptionExperience,
    "document": document,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "id": id,
  };
}
