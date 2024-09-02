// To parse this JSON data, do
//
//     final resLocationMember = resLocationMemberFromJson(jsonString);

import 'dart:convert';

ResMemberArea resLocationMemberFromJson(String str) => ResMemberArea.fromJson(json.decode(str));

String resLocationMemberToJson(ResMemberArea data) => json.encode(data.toJson());

class ResMemberArea {
  bool? success;
  String? message;
  MemberArea? data;

  ResMemberArea({
    this.success,
    this.message,
    this.data,
  });

  factory ResMemberArea.fromJson(Map<String, dynamic> json) => ResMemberArea(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : MemberArea.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class MemberArea {
  String? ip;
  String? country;
  String? city;

  MemberArea({
    this.ip,
    this.country,
    this.city,
  });

  factory MemberArea.fromJson(Map<String, dynamic> json) => MemberArea(
    ip: json["ip"],
    country: json["country"],
    city: json["city"],
  );

  Map<String, dynamic> toJson() => {
    "ip": ip,
    "country": country,
    "city": city,
  };
}
