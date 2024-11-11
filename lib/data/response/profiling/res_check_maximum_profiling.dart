// To parse this JSON data, do
//
//     final resCheckMaximumCreateProfiling = resCheckMaximumCreateProfilingFromJson(jsonString);

import 'dart:convert';

ResCheckMaximumCreateProfiling resCheckMaximumCreateProfilingFromJson(
        String str) =>
    ResCheckMaximumCreateProfiling.fromJson(json.decode(str));

String resCheckMaximumCreateProfilingToJson(
        ResCheckMaximumCreateProfiling data) =>
    json.encode(data.toJson());

class ResCheckMaximumCreateProfiling {
  bool? success;
  String? message;
  DataMaximumProfiling? data;

  ResCheckMaximumCreateProfiling({
    this.success,
    this.message,
    this.data,
  });

  factory ResCheckMaximumCreateProfiling.fromJson(Map<String, dynamic> json) =>
      ResCheckMaximumCreateProfiling(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : DataMaximumProfiling.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class DataMaximumProfiling {
  dynamic maxQty;

  DataMaximumProfiling({
    this.maxQty,
  });

  factory DataMaximumProfiling.fromJson(Map<String, dynamic> json) =>
      DataMaximumProfiling(
        maxQty: json["max_qty"],
      );

  Map<String, dynamic> toJson() => {
        "max_qty": maxQty,
      };
}
