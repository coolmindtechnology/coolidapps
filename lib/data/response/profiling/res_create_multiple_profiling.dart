// To parse this JSON data, do
//
//     final resCreateMultipleProfiling = resCreateMultipleProfilingFromJson(jsonString);

import 'dart:convert';

ResCreateMultipleProfiling resCreateMultipleProfilingFromJson(String str) =>
    ResCreateMultipleProfiling.fromJson(json.decode(str));

String resCreateMultipleProfilingToJson(ResCreateMultipleProfiling data) =>
    json.encode(data.toJson());

class ResCreateMultipleProfiling {
  bool? success;
  String? message;
  List<DataCreateMultipleProfiling>? data;

  ResCreateMultipleProfiling({
    this.success,
    this.message,
    this.data,
  });

  factory ResCreateMultipleProfiling.fromJson(Map<String, dynamic> json) =>
      ResCreateMultipleProfiling(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<DataCreateMultipleProfiling>.from(json["data"]!.map((x) => DataCreateMultipleProfiling.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class DataCreateMultipleProfiling {
  String? bloodType;
  int? idUser;
  int? idProfiling;
  int? result;
  String? idMultiple;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  DataCreateMultipleProfiling({
    this.bloodType,
    this.idUser,
    this.idProfiling,
    this.result,
    this.idMultiple,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory DataCreateMultipleProfiling.fromJson(Map<String, dynamic> json) => DataCreateMultipleProfiling(
        bloodType: json["blood_type"],
        idUser: json["id_user"],
        idProfiling: json["id_profiling"],
        result: json["result"],
        idMultiple: json["id_multiple"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "blood_type": bloodType,
        "id_user": idUser,
        "id_profiling": idProfiling,
        "result": result,
        "id_multiple": idMultiple,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
      };
}
