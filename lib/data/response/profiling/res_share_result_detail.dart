// To parse this JSON data, do
//
//     final resShareResultDetail = resShareResultDetailFromJson(jsonString);

import 'dart:convert';

ResShareResultDetail resShareResultDetailFromJson(String str) =>
    ResShareResultDetail.fromJson(json.decode(str));

String resShareResultDetailToJson(ResShareResultDetail data) =>
    json.encode(data.toJson());

class ResShareResultDetail {
  bool? success;
  dynamic message;
  DataShareResultDetail? data;

  ResShareResultDetail({
    this.success,
    this.message,
    this.data,
  });

  factory ResShareResultDetail.fromJson(Map<String, dynamic> json) =>
      ResShareResultDetail(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : DataShareResultDetail.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class DataShareResultDetail {
  dynamic facebook;
  dynamic twitter;
  dynamic linkedin;
  dynamic telegram;
  dynamic whatsapp;
  dynamic others;

  DataShareResultDetail({
    this.facebook,
    this.twitter,
    this.linkedin,
    this.telegram,
    this.whatsapp,
    this.others,
  });

  factory DataShareResultDetail.fromJson(Map<String, dynamic> json) =>
      DataShareResultDetail(
        facebook: json["facebook"],
        twitter: json["twitter"],
        linkedin: json["linkedin"],
        telegram: json["telegram"],
        whatsapp: json["whatsapp"],
        others: json["others"],
      );

  Map<String, dynamic> toJson() => {
        "facebook": facebook,
        "twitter": twitter,
        "linkedin": linkedin,
        "telegram": telegram,
        "whatsapp": whatsapp,
        "others": others,
      };
}
