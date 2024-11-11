// To parse this JSON data, do
//
//     final resGetVersionApp = resGetVersionAppFromJson(jsonString);

import 'dart:convert';

ResGetVersionApp resGetVersionAppFromJson(String str) =>
    ResGetVersionApp.fromJson(json.decode(str));

String resGetVersionAppToJson(ResGetVersionApp data) =>
    json.encode(data.toJson());

class ResGetVersionApp {
  bool? success;
  String? message;
  DataVersionApp? data;

  ResGetVersionApp({
    this.success,
    this.message,
    this.data,
  });

  factory ResGetVersionApp.fromJson(Map<String, dynamic> json) =>
      ResGetVersionApp(
        success: json["success"],
        message: json["message"],
        data:
            json["data"] == null ? null : DataVersionApp.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class DataVersionApp {
  dynamic id;
  String? stableVersion;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? incomingVersion;
  String? version;

  DataVersionApp({
    this.id,
    this.stableVersion,
    this.createdAt,
    this.updatedAt,
    this.incomingVersion,
    this.version,
  });

  factory DataVersionApp.fromJson(Map<String, dynamic> json) => DataVersionApp(
        id: json["id"],
        stableVersion: json["stable_version"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        incomingVersion: json["incoming_version"],
        version: json["version"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "stable_version": stableVersion,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "incoming_version": incomingVersion,
        "version": version,
      };
}
