// To parse this JSON data, do
//
//     final resListPromotion = resListPromotionFromJson(jsonString);

import 'dart:convert';

ResListPromotion resListPromotionFromJson(String str) => ResListPromotion.fromJson(json.decode(str));

String resListPromotionToJson(ResListPromotion data) => json.encode(data.toJson());

class ResListPromotion {
  String? message;
  String? totalComission;
  String? referalLink;
  String? feeComission;
  String? minimumWd;
  String? codeReferal;
  bool? isWd;
  List<Datum>? data;

  ResListPromotion({
    this.message,
    this.totalComission,
    this.referalLink,
    this.isWd,
    this.feeComission,
    this.minimumWd,
    this.codeReferal,
    this.data,
  });

  factory ResListPromotion.fromJson(Map<String, dynamic> json) => ResListPromotion(
    message: json["message"],
    totalComission: json["total_comission"],
    referalLink: json["referal_link"],
    feeComission: json["fee_comission"],
    minimumWd: json["minimum_wd"],
    codeReferal: json["code_referal"],
    isWd: json["is_wd"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "total_comission": totalComission,
    "referal_link": referalLink,
    "fee_comission": feeComission,
    "minimum_wd": minimumWd,
    "code_referal": codeReferal,
    "is_wd": isWd,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  dynamic? id;
  String? nameMember;
  String? comissionAmount;
  String? profiling;
  String? date;
  String? category;

  Datum({
    this.id,
    this.nameMember,
    this.comissionAmount,
    this.profiling,
    this.date,
    this.category,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    nameMember: json["name_member"],
    comissionAmount: json["comission_amount"],
    profiling: json["profiling"],
    date: json["date"],
    category: json["category"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name_member": nameMember,
    "comission_amount": comissionAmount,
    "profiling": profiling,
    "date": date,
    "category": category,
  };
}
