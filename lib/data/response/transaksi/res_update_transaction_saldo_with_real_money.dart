// To parse this JSON data, do
//
//     final resUpdateTransactionSaldoWithRealMoney = resUpdateTransactionSaldoWithRealMoneyFromJson(jsonString);

import 'dart:convert';

ResUpdateTransactionSaldoWithRealMoney
    resUpdateTransactionSaldoWithRealMoneyFromJson(String str) =>
        ResUpdateTransactionSaldoWithRealMoney.fromJson(json.decode(str));

String resUpdateTransactionSaldoWithRealMoneyToJson(
        ResUpdateTransactionSaldoWithRealMoney data) =>
    json.encode(data.toJson());

class ResUpdateTransactionSaldoWithRealMoney {
  bool? success;
  dynamic message;
  DataUpdateTransactionSaldoWithRealMoney? data;

  ResUpdateTransactionSaldoWithRealMoney({
    this.success,
    this.message,
    this.data,
  });

  factory ResUpdateTransactionSaldoWithRealMoney.fromJson(
          Map<String, dynamic> json) =>
      ResUpdateTransactionSaldoWithRealMoney(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : DataUpdateTransactionSaldoWithRealMoney.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class DataUpdateTransactionSaldoWithRealMoney {
  int? id;
  dynamic idUser;
  dynamic idUserMember;
  dynamic totalMember;
  dynamic totalRealMoney;
  dynamic totalSaldoAffiliate;
  dynamic bankName;
  dynamic bankNumber;
  dynamic referralCode;
  dynamic depositCompleted;
  dynamic countRealMoney;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic isActive;

  DataUpdateTransactionSaldoWithRealMoney({
    this.id,
    this.idUser,
    this.idUserMember,
    this.totalMember,
    this.totalRealMoney,
    this.totalSaldoAffiliate,
    this.bankName,
    this.bankNumber,
    this.referralCode,
    this.depositCompleted,
    this.countRealMoney,
    this.createdAt,
    this.updatedAt,
    this.isActive,
  });

  factory DataUpdateTransactionSaldoWithRealMoney.fromJson(
          Map<String, dynamic> json) =>
      DataUpdateTransactionSaldoWithRealMoney(
        id: json["id"],
        idUser: json["id_user"],
        idUserMember: json["id_user_member"],
        totalMember: json["total_member"],
        totalRealMoney: json["total_real_money"],
        totalSaldoAffiliate: json["total_saldo_affiliate"],
        bankName: json["bank_name"],
        bankNumber: json["bank_number"],
        referralCode: json["referral_code"],
        depositCompleted: json["deposit_completed"],
        countRealMoney: json["count_real_money"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        isActive: json["is_active"],
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
        "referral_code": referralCode,
        "deposit_completed": depositCompleted,
        "count_real_money": countRealMoney,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "is_active": isActive,
      };
}
