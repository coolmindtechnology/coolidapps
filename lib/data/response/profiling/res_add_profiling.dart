// To parse this JSON data, do
//
//     final resAddProfiling = resAddProfilingFromJson(jsonString);

import 'dart:convert';

ResAddProfiling resAddProfilingFromJson(String str) => ResAddProfiling.fromJson(json.decode(str));

String resAddProfilingToJson(ResAddProfiling data) => json.encode(data.toJson());

class ResAddProfiling {
  bool? success;
  String? message;
  Data? data;

  ResAddProfiling({
    this.success,
    this.message,
    this.data,
  });

  factory ResAddProfiling.fromJson(Map<String, dynamic> json) => ResAddProfiling(
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
  String? bloodType;
  int? idUser;
  int? idProfiling;
  int? result;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  Data({
    this.bloodType,
    this.idUser,
    this.idProfiling,
    this.result,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    bloodType: json["blood_type"],
    idUser: json["id_user"],
    idProfiling: json["id_profiling"],
    result: json["result"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "blood_type": bloodType,
    "id_user": idUser,
    "id_profiling": idProfiling,
    "result": result,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "id": id,
  };
}
