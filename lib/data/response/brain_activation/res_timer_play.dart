// To parse this JSON data, do
//
//     final resTimerPlay = resTimerPlayFromJson(jsonString);

import 'dart:convert';

ResTimerPlay resTimerPlayFromJson(String str) =>
    ResTimerPlay.fromJson(json.decode(str));

String resTimerPlayToJson(ResTimerPlay data) => json.encode(data.toJson());

class ResTimerPlay {
  bool? success;
  String? message;
  TimePlayBrain? data;

  ResTimerPlay({
    this.success,
    this.message,
    this.data,
  });

  factory ResTimerPlay.fromJson(Map<String, dynamic> json) => ResTimerPlay(
        success: json["success"],
        message: json["message"],
        data:
            json["data"] == null ? null : TimePlayBrain.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class TimePlayBrain {
  dynamic dailyCount;
  dynamic limitAccessAudio;

  TimePlayBrain({
    this.dailyCount,
    this.limitAccessAudio,
  });

  factory TimePlayBrain.fromJson(Map<String, dynamic> json) => TimePlayBrain(
        dailyCount: json["daily_count"],
        limitAccessAudio: json["limit_access_audio"],
      );

  Map<String, dynamic> toJson() => {
        "daily_count": dailyCount,
        "limit_access_audio": limitAccessAudio,
      };
}
