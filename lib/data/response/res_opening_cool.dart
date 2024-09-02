// To parse this JSON data, do
//
//     final resOpeningCool = resOpeningCoolFromJson(jsonString);

import 'dart:convert';

ResOpeningCool resOpeningCoolFromJson(String str) => ResOpeningCool.fromJson(json.decode(str));

String resOpeningCoolToJson(ResOpeningCool data) => json.encode(data.toJson());

class ResOpeningCool {
  bool? success;
  String? message;
  DataOpening? data;

  ResOpeningCool({
    this.success,
    this.message,
    this.data,
  });

  factory ResOpeningCool.fromJson(Map<String, dynamic> json) => ResOpeningCool(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : DataOpening.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class DataOpening {
  String? sound;

  DataOpening({
    this.sound,
  });

  factory DataOpening.fromJson(Map<String, dynamic> json) => DataOpening(
    sound: json["sound"],
  );

  Map<String, dynamic> toJson() => {
    "sound": sound,
  };
}
