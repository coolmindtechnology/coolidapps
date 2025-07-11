// To parse this JSON data, do
//
//     final resShowDetail = resShowDetailFromJson(jsonString);

import 'dart:convert';

ResShowDetail resShowDetailFromJson(String str) =>
    ResShowDetail.fromJson(json.decode(str));

String resShowDetailToJson(ResShowDetail data) => json.encode(data.toJson());

class ResShowDetail {
  bool? success;
  dynamic message;
  DataShowDetail? data;

  ResShowDetail({
    this.success,
    this.message,
    this.data,
  });

  factory ResShowDetail.fromJson(Map<String, dynamic> json) => ResShowDetail(
        success: json["success"],
        message: json["message"],
        data:
            json["data"] == null ? null : DataShowDetail.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class DataShowDetail {
  dynamic idResult;
  dynamic name;
  dynamic result;
  dynamic birthDate;
  dynamic shareCode;
  dynamic consultationQuota;
  dynamic imagetypebrain;

  DataShowDetail({
    this.idResult,
    this.name,
    this.result,
    this.birthDate,
    this.shareCode,
    this.consultationQuota,
    this.imagetypebrain
  });

  factory DataShowDetail.fromJson(Map<String, dynamic> json) => DataShowDetail(
        idResult: json["id_result"],
        name: json["name"],
        result: json["result"],
        birthDate: json["birth_date"],
        shareCode: json["share_code"],
        consultationQuota: json["consultation_quota"],
        imagetypebrain: json["image_type_brain"],
      );

  Map<String, dynamic> toJson() => {
        "id_result": idResult,
        "name": name,
        "result": result,
        "birth_date": birthDate,
        "share_code": shareCode,
        "consultation_quota": consultationQuota,
        "image_type_brain": imagetypebrain,
      };
}
