// To parse this JSON data, do
//
//     final resGetCategory = resGetCategoryFromJson(jsonString);

import 'dart:convert';

ResGetCategory resGetCategoryFromJson(String str) => ResGetCategory.fromJson(json.decode(str));

String resGetCategoryToJson(ResGetCategory data) => json.encode(data.toJson());

class ResGetCategory {
  bool? success;
  String? message;
  List<Datum>? data;

  ResGetCategory({
    this.success,
    this.message,
    this.data,
  });

  factory ResGetCategory.fromJson(Map<String, dynamic> json) => ResGetCategory(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  int? id;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
