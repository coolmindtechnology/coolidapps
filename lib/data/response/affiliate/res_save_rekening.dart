// To parse this JSON data, do
//
//     final resSaveRekening = resSaveRekeningFromJson(jsonString);

import 'dart:convert';

ResSaveRekening resSaveRekeningFromJson(String str) => ResSaveRekening.fromJson(json.decode(str));

String resSaveRekeningToJson(ResSaveRekening data) => json.encode(data.toJson());

class ResSaveRekening {
  bool? success;
  String? message;
  dynamic data;

  ResSaveRekening({
    this.success,
    this.message,
    this.data,
  });

  factory ResSaveRekening.fromJson(Map<String, dynamic> json) => ResSaveRekening(
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
