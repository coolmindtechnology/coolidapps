// To parse this JSON data, do
//
//     final resCheckTopupAffiliate = resCheckTopupAffiliateFromJson(jsonString);

import 'dart:convert';

ResCheckTopupAffiliate resCheckTopupAffiliateFromJson(String str) =>
    ResCheckTopupAffiliate.fromJson(json.decode(str));

String resCheckTopupAffiliateToJson(ResCheckTopupAffiliate data) =>
    json.encode(data.toJson());

class ResCheckTopupAffiliate {
  bool? success;
  String? message;
  DataCheckTopupNotif? data;

  ResCheckTopupAffiliate({
    this.success,
    this.message,
    this.data,
  });

  factory ResCheckTopupAffiliate.fromJson(Map<String, dynamic> json) =>
      ResCheckTopupAffiliate(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : DataCheckTopupNotif.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class DataCheckTopupNotif {
  dynamic data;
  dynamic notif;

  DataCheckTopupNotif({
    this.data,
    this.notif,
  });

  factory DataCheckTopupNotif.fromJson(Map<String, dynamic> json) =>
      DataCheckTopupNotif(
        data: json["data"],
        notif: json["notif"],
      );

  Map<String, dynamic> toJson() => {
        "data": data,
        "notif": notif,
      };
}
