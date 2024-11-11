// To parse this JSON data, do
//
//     final resAffiliate = resAffiliateFromJson(jsonString);

import 'dart:convert';

import 'package:coolappflutter/data/response/user/res_get_user.dart';

ResAffiliate resAffiliateFromJson(String str) =>
    ResAffiliate.fromJson(json.decode(str));

String resAffiliateToJson(ResAffiliate data) => json.encode(data.toJson());

class ResAffiliate {
  bool? success;
  String? message;
  DataAffiliasi? data;

  ResAffiliate({
    this.success,
    this.message,
    this.data,
  });

  factory ResAffiliate.fromJson(Map<String, dynamic> json) => ResAffiliate(
        success: json["success"],
        message: json["message"],
        data:
            json["data"] == null ? null : DataAffiliasi.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class DataAffiliasi {
  int? id;
  dynamic idUser;
  dynamic idUserMember;
  dynamic totalMember;
  dynamic totalRealMoney;
  dynamic totalSaldoAffiliate;
  String? bankName;
  dynamic bankNumber;
  String? bankAccountName;
  dynamic referralCode;
  String? depositCompleted;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic isActive;
  dynamic linkRefferalCode;
  DataUser? user;

  DataAffiliasi({
    this.id,
    this.idUser,
    this.idUserMember,
    this.totalMember,
    this.totalRealMoney,
    this.totalSaldoAffiliate,
    this.bankName,
    this.bankNumber,
    this.bankAccountName,
    this.referralCode,
    this.depositCompleted,
    this.createdAt,
    this.updatedAt,
    this.isActive,
    this.linkRefferalCode,
    this.user,
  });

  factory DataAffiliasi.fromJson(Map<String, dynamic> json) => DataAffiliasi(
        id: json["id"],
        idUser: json["id_user"],
        idUserMember: json["id_user_member"],
        totalMember: json["total_member"],
        totalRealMoney: json["total_real_money"],
        totalSaldoAffiliate: json["total_saldo_affiliate"],
        bankName: json["bank_name"],
        bankNumber: json["bank_number"],
        bankAccountName: json["bank_account_name"],
        referralCode: json["referral_code"],
        depositCompleted: json["deposit_completed"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        isActive: json["is_active"],
        linkRefferalCode: json["link_refferal_code"],
        user: json["user"] == null ? null : DataUser.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_user": idUser,
        "id_user_member": idUserMember,
        "total_member": totalMember,
        "total_real_money": totalRealMoney,
        "total_saldo_affiliate": totalSaldoAffiliate,
        "bank_name": bankName,
        "bank_number": bankNumber,
        "bank_account_name": bankAccountName,
        "referral_code": referralCode,
        "deposit_completed": depositCompleted,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "is_active": isActive,
        "link_refferal_code": linkRefferalCode,
        "user": user?.toJson(),
      };
}
