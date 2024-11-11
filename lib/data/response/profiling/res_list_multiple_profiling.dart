// To parse this JSON data, do
//
//     final resListMultipleProfiling = resListMultipleProfilingFromJson(jsonString);

import 'dart:convert';

import 'package:coolappflutter/data/response/profiling/res_list_profiling.dart';

ResListMultipleProfiling resListMultipleProfilingFromJson(String str) =>
    ResListMultipleProfiling.fromJson(json.decode(str));

String resListMultipleProfilingToJson(ResListMultipleProfiling data) =>
    json.encode(data.toJson());

class ResListMultipleProfiling {
  bool? success;
  dynamic message;
  List<DataListMultipleProfiling>? data;

  ResListMultipleProfiling({
    this.success,
    this.message,
    this.data,
  });

  factory ResListMultipleProfiling.fromJson(Map<String, dynamic> json) =>
      ResListMultipleProfiling(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<DataListMultipleProfiling>.from(json["data"]!
                .map((x) => DataListMultipleProfiling.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class DataListMultipleProfiling {
  dynamic name;
  dynamic idMultiple;

  List<DataProfiling>? profiling;
  int? total;

  DataListMultipleProfiling({
    this.name,
    this.idMultiple,
    this.profiling,
    this.total,
  });

  factory DataListMultipleProfiling.fromJson(Map<String, dynamic> json) =>
      DataListMultipleProfiling(
        name: json["name"],
        idMultiple: json["id_multiple"],
        profiling: json["profiling"] == null
            ? []
            : List<DataProfiling>.from(
                json["profiling"]!.map((x) => DataProfiling.fromJson(x))),
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id_multiple": idMultiple,
        "profiling": profiling == null
            ? []
            : List<dynamic>.from(profiling!.map((x) => x.toJson())),
        "total": total,
      };
}
