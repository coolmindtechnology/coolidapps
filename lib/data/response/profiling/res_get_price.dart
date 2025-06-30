// To parse this JSON data, do
//
//     final resPriceProfiling = resPriceProfilingFromJson(jsonString);

import 'dart:convert';

ResPriceProfiling resPriceProfilingFromJson(String str) => ResPriceProfiling.fromJson(json.decode(str));

String resPriceProfilingToJson(ResPriceProfiling data) => json.encode(data.toJson());

class ResPriceProfiling {
  bool? success;
  String? message;
  int? data;

  ResPriceProfiling({
    this.success,
    this.message,
    this.data,
  });

  factory ResPriceProfiling.fromJson(Map<String, dynamic> json) => ResPriceProfiling(
    success: json["success"],
    message: json["message"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data,
  };
}
