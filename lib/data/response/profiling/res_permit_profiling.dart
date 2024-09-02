// To parse this JSON data, do
//
//     final resPermiteProfiling = resPermiteProfilingFromJson(jsonString);

import 'dart:convert';

ResPermiteProfiling resPermiteProfilingFromJson(String str) => ResPermiteProfiling.fromJson(json.decode(str));

String resPermiteProfilingToJson(ResPermiteProfiling data) => json.encode(data.toJson());

class ResPermiteProfiling {
  bool? success;
  String? message;
  String? data;

  ResPermiteProfiling({
    this.success,
    this.message,
    this.data,
  });

  factory ResPermiteProfiling.fromJson(Map<String, dynamic> json) => ResPermiteProfiling(
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
