// To parse this JSON data, do
//
//     final resCekDaily = resCekDailyFromJson(jsonString);

import 'dart:convert';

ResCekDaily resCekDailyFromJson(String str) =>
    ResCekDaily.fromJson(json.decode(str));

String resCekDailyToJson(ResCekDaily data) => json.encode(data.toJson());

class ResCekDaily {
  bool? success;
  String? message;
  CekDaily? data;

  ResCekDaily({
    this.success,
    this.message,
    this.data,
  });

  factory ResCekDaily.fromJson(Map<String, dynamic> json) => ResCekDaily(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : CekDaily.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class CekDaily {
  dynamic dailyCount;
  dynamic limitAccessAudio;

  CekDaily({
    this.dailyCount,
    this.limitAccessAudio,
  });

  factory CekDaily.fromJson(Map<String, dynamic> json) => CekDaily(
        dailyCount: json["daily_count"],
        limitAccessAudio: json["limit_access_audio"],
      );

  Map<String, dynamic> toJson() => {
        "daily_count": dailyCount,
        "limit_access_audio": limitAccessAudio,
      };
}
