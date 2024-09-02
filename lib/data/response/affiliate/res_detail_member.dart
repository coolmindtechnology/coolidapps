// To parse this JSON data, do
//
//     final resDetailMeber = resDetailMeberFromJson(jsonString);

import 'dart:convert';

import '../../models/data_member_affiliate.dart';

ResDetailMeber resDetailMeberFromJson(String str) => ResDetailMeber.fromJson(json.decode(str));

String resDetailMeberToJson(ResDetailMeber data) => json.encode(data.toJson());

class ResDetailMeber {
  bool? success;
  String? message;
  DataMemberAffiliate? data;

  ResDetailMeber({
    this.success,
    this.message,
    this.data,
  });

  factory ResDetailMeber.fromJson(Map<String, dynamic> json) => ResDetailMeber(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : DataMemberAffiliate.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}


