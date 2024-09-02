// To parse this JSON data, do
//
//     final resListMember = resListMemberFromJson(jsonString);

import 'dart:convert';

import '../../models/data_member_affiliate.dart';

ResListMember resListMemberFromJson(String str) => ResListMember.fromJson(json.decode(str));

String resListMemberToJson(ResListMember data) => json.encode(data.toJson());

class ResListMember {
  bool? success;
  String? message;
  List<DataMemberAffiliate>? data;

  ResListMember({
    this.success,
    this.message,
    this.data,
  });

  factory ResListMember.fromJson(Map<String, dynamic> json) => ResListMember(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<DataMemberAffiliate>.from(json["data"]!.map((x) => DataMemberAffiliate.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}