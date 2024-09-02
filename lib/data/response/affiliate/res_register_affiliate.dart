// To parse this JSON data, do
//
//     final resRegisterffiliate = resRegisterffiliateFromJson(jsonString);

import 'dart:convert';

ResRegisterffiliate resRegisterffiliateFromJson(String str) =>
    ResRegisterffiliate.fromJson(json.decode(str));

String resRegisterffiliateToJson(ResRegisterffiliate data) =>
    json.encode(data.toJson());

class ResRegisterffiliate {
  bool? success;
  String? message;
  DataRegisterAffiliate? data;

  ResRegisterffiliate({
    this.success,
    this.message,
    this.data,
  });

  factory ResRegisterffiliate.fromJson(Map<String, dynamic> json) =>
      ResRegisterffiliate(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : DataRegisterAffiliate.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class DataRegisterAffiliate {
  int? id;
  String? idRole;
  String? name;
  String? phoneNumber;
  String? email;
  dynamic emailVerifiedAt;
  String? address;
  dynamic image;
  String? idCardNumber;
  String? otpCode;
  DateTime? otpTime;
  String? isProfiling;
  String? isVerified;
  String? isDeposit;
  String? totalDeposit;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? idAffiliate;
  String? codeReferal;
  String? idAgent;
  String? idMitra;
  int? isAffiliate;
  Affiliate? affiliate;

  DataRegisterAffiliate({
    this.id,
    this.idRole,
    this.name,
    this.phoneNumber,
    this.email,
    this.emailVerifiedAt,
    this.address,
    this.image,
    this.idCardNumber,
    this.otpCode,
    this.otpTime,
    this.isProfiling,
    this.isVerified,
    this.isDeposit,
    this.totalDeposit,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.idAffiliate,
    this.codeReferal,
    this.idAgent,
    this.idMitra,
    this.isAffiliate,
    this.affiliate,
  });

  factory DataRegisterAffiliate.fromJson(Map<String, dynamic> json) =>
      DataRegisterAffiliate(
        id: json["id"],
        idRole: json["id_role"],
        name: json["name"],
        phoneNumber: json["phone_number"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        address: json["address"],
        image: json["image"],
        idCardNumber: json["id_card_number"],
        otpCode: json["otp_code"],
        otpTime:
            json["otp_time"] == null ? null : DateTime.parse(json["otp_time"]),
        isProfiling: json["is_profiling"],
        isVerified: json["is_verified"],
        isDeposit: json["is_deposit"],
        totalDeposit: json["total_deposit"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        idAffiliate: json["id_affiliate"],
        codeReferal: json["code_referal"],
        idAgent: json["id_agent"],
        idMitra: json["id_mitra"],
        isAffiliate: json["is_affiliate"],
        affiliate: json["affiliate"] == null
            ? null
            : Affiliate.fromJson(json["affiliate"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_role": idRole,
        "name": name,
        "phone_number": phoneNumber,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "address": address,
        "image": image,
        "id_card_number": idCardNumber,
        "otp_code": otpCode,
        "otp_time": otpTime?.toIso8601String(),
        "is_profiling": isProfiling,
        "is_verified": isVerified,
        "is_deposit": isDeposit,
        "total_deposit": totalDeposit,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "id_affiliate": idAffiliate,
        "code_referal": codeReferal,
        "id_agent": idAgent,
        "id_mitra": idMitra,
        "is_affiliate": isAffiliate,
        "affiliate": affiliate?.toJson(),
      };
}

class Affiliate {
  dynamic name;
  dynamic phoneNumber;
  dynamic email;

  Affiliate({
    this.name,
    this.phoneNumber,
    this.email,
  });

  factory Affiliate.fromJson(Map<String, dynamic> json) => Affiliate(
        name: json["name"],
        phoneNumber: json["phone_number"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "phone_number": phoneNumber,
        "email": email,
      };
}
