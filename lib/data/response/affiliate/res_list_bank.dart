// To parse this JSON data, do
//
//     final resListBank = resListBankFromJson(jsonString);

import 'dart:convert';

ResListBank resListBankFromJson(String str) =>
    ResListBank.fromJson(json.decode(str));

String resListBankToJson(ResListBank data) => json.encode(data.toJson());

class ResListBank {
  int? status;
  String? message;
  List<DataRek>? data;

  ResListBank({
    this.status,
    this.message,
    this.data,
  });

  factory ResListBank.fromJson(Map<String, dynamic> json) => ResListBank(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<DataRek>.from(json["data"]!.map((x) => DataRek.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class DataRek {
  String? code;
  String? name;
  List<String>? routingCode;

  DataRek({
    this.code,
    this.name,
    this.routingCode,
  });

  factory DataRek.fromJson(Map<String, dynamic> json) => DataRek(
        code: json["code"],
        name: json["name"],
        routingCode: json["routing_code"] == null
            ? []
            : List<String>.from(json["routing_code"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "routing_code": routingCode == null
            ? []
            : List<dynamic>.from(routingCode!.map((x) => x)),
      };
}
