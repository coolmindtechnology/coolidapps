// To parse this JSON data, do
//
//     final resListProfiling = resListProfilingFromJson(jsonString);

import 'dart:convert';

ResListProfiling resListProfilingFromJson(String str) => ResListProfiling.fromJson(json.decode(str));

String resListProfilingToJson(ResListProfiling data) => json.encode(data.toJson());

class ResListProfiling {
  bool? success;
  String? message;
  List<DataProfiling>? data;

  ResListProfiling({
    this.success,
    this.message,
    this.data,
  });

  factory ResListProfiling.fromJson(Map<String, dynamic> json) => ResListProfiling(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<DataProfiling>.from(json["data"]!.map((x) => DataProfiling.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class DataProfiling {
  String? idLogResult;
  String? status;
  String? result;
  String? bloodType;
  String? profilingName;
  String? domicile;
  String? yearDate;
  String? monthDate;
  String? birthDate;
  String? character;
  String? date;

  DataProfiling({
    this.idLogResult,
    this.status,
    this.result,
    this.bloodType,
    this.profilingName,
    this.domicile,
    this.yearDate,
    this.monthDate,
    this.birthDate,
    this.character,
    this.date,
  });

  factory DataProfiling.fromJson(Map<String, dynamic> json) => DataProfiling(
    idLogResult: json["id_log_result"],
    status: json["status"],
    result: json["result"],
    bloodType: json["blood_type"],
    profilingName: json["profiling_name"],
    domicile: json["domicile"],
    yearDate: json["year_date"],
    monthDate: json["month_date"],
    birthDate: json["birth_date"],
    character: json["character"],
    date: json["date"],
  );

  Map<String, dynamic> toJson() => {
    "id_log_result": idLogResult,
    "status": status,
    "result": result,
    "blood_type": bloodType,
    "profiling_name": profilingName,
    "domicile": domicile,
    "year_date": yearDate,
    "month_date": monthDate,
    "birth_date": birthDate,
    "character": character,
    "date": date,
  };
}