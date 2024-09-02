// To parse this JSON data, do
//
//     final resSaveRekening = resSaveRekeningFromJson(jsonString);

import 'dart:convert';

ResUpgradeMember resSaveRekeningFromJson(String str) =>
    ResUpgradeMember.fromJson(json.decode(str));

String resSaveRekeningToJson(ResUpgradeMember data) =>
    json.encode(data.toJson());

class ResUpgradeMember {
  bool? success;
  String? message;
  dynamic data;

  ResUpgradeMember({
    this.success,
    this.message,
    this.data,
  });

  factory ResUpgradeMember.fromJson(Map<String, dynamic> json) =>
      ResUpgradeMember(
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
