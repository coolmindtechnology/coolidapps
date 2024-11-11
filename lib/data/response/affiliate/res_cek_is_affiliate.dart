// To parse this JSON data, do
//
//     final resCekIsAffiliate = resCekIsAffiliateFromJson(jsonString);

import 'dart:convert';

ResCekIsAffiliate resCekIsAffiliateFromJson(String str) =>
    ResCekIsAffiliate.fromJson(json.decode(str));

String resCekIsAffiliateToJson(ResCekIsAffiliate data) =>
    json.encode(data.toJson());

class ResCekIsAffiliate {
  bool? success;
  String? message;
  DataIsAffiliate? data;

  ResCekIsAffiliate({
    this.success,
    this.message,
    this.data,
  });

  factory ResCekIsAffiliate.fromJson(Map<String, dynamic> json) =>
      ResCekIsAffiliate(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : DataIsAffiliate.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class DataIsAffiliate {
  bool? isAllow;
  dynamic idUser;

  DataIsAffiliate({
    this.isAllow,
    this.idUser,
  });

  factory DataIsAffiliate.fromJson(Map<String, dynamic> json) =>
      DataIsAffiliate(
        isAllow: json["is_allow"],
        idUser: json["id_user"],
      );

  Map<String, dynamic> toJson() => {
        "is_allow": isAllow,
        "id_user": idUser,
      };
}
