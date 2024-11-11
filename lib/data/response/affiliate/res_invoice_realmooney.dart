// To parse this JSON data, do
//
//     final resInvoiceRealMoney = resInvoiceRealMoneyFromJson(jsonString);

import 'dart:convert';

ResInvoiceRealMoney resInvoiceRealMoneyFromJson(String str) =>
    ResInvoiceRealMoney.fromJson(json.decode(str));

String resInvoiceRealMoneyToJson(ResInvoiceRealMoney data) =>
    json.encode(data.toJson());

class ResInvoiceRealMoney {
  bool? success;
  dynamic message;
  DataInvoiceRealMoney? data;

  ResInvoiceRealMoney({
    this.success,
    this.message,
    this.data,
  });

  factory ResInvoiceRealMoney.fromJson(Map<String, dynamic> json) =>
      ResInvoiceRealMoney(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : DataInvoiceRealMoney.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class DataInvoiceRealMoney {
  int? id;
  dynamic idUser;
  dynamic idAffiliate;
  dynamic idSaldoAffiliate;
  dynamic amount;
  dynamic transactionType;
  dynamic status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  dynamic referenceNo;
  List<dynamic>? payoutsDetail;
  User? user;
  dynamic affiliate;

  DataInvoiceRealMoney({
    this.id,
    this.idUser,
    this.idAffiliate,
    this.idSaldoAffiliate,
    this.amount,
    this.transactionType,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.referenceNo,
    this.payoutsDetail,
    this.user,
    this.affiliate,
  });

  factory DataInvoiceRealMoney.fromJson(Map<String, dynamic> json) =>
      DataInvoiceRealMoney(
        id: json["id"],
        idUser: json["id_user"],
        idAffiliate: json["id_affiliate"],
        idSaldoAffiliate: json["id_saldo_affiliate"],
        amount: json["amount"],
        transactionType: json["transaction_type"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        referenceNo: json["reference_no"],
        payoutsDetail: json["payouts_detail"] == null
            ? []
            : List<dynamic>.from(json["payouts_detail"]!.map((x) => x)),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        affiliate: json["affiliate"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_user": idUser,
        "id_affiliate": idAffiliate,
        "id_saldo_affiliate": idSaldoAffiliate,
        "amount": amount,
        "transaction_type": transactionType,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "reference_no": referenceNo,
        "payouts_detail": payoutsDetail == null
            ? []
            : List<dynamic>.from(payoutsDetail!.map((x) => x)),
        "user": user?.toJson(),
        "affiliate": affiliate,
      };
}

class User {
  int? id;
  dynamic idRole;
  dynamic name;
  dynamic phoneNumber;
  dynamic email;
  dynamic emailVerifiedAt;
  dynamic address;
  dynamic image;
  dynamic idCardNumber;
  dynamic otpCode;
  DateTime? otpTime;
  dynamic isProfiling;
  dynamic isVerified;
  dynamic isDeposit;
  dynamic totalDeposit;
  dynamic status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  dynamic idAffiliate;
  dynamic codeReferal;
  dynamic idAgent;
  dynamic idMitra;
  dynamic isAffiliate;
  dynamic verificationToken;

  User({
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
    this.verificationToken,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
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
        verificationToken: json["verification_token"],
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
        "verification_token": verificationToken,
      };
}
