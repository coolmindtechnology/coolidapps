// To parse this JSON data, do
//
//     final resGetTerm = resGetTermFromJson(jsonString);

import 'dart:convert';

ResGetTerm resGetTermFromJson(String str) => ResGetTerm.fromJson(json.decode(str));

String resGetTermToJson(ResGetTerm data) => json.encode(data.toJson());

class ResGetTerm {
  bool? success;
  String? message;
  Data? data;

  ResGetTerm({
    this.success,
    this.message,
    this.data,
  });

  factory ResGetTerm.fromJson(Map<String, dynamic> json) => ResGetTerm(
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
  int? id;
  String? data;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? localeId;
  String? type;

  Data({
    this.id,
    this.data,
    this.createdAt,
    this.updatedAt,
    this.localeId,
    this.type,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    data: json["data"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    localeId: json["locale_id"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "data": data,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "locale_id": localeId,
    "type": type,
  };
}
