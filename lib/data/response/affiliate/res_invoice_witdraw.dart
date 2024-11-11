// To parse this JSON data, do
//
//     final resInvoiceWithdrawal = resInvoiceWithdrawalFromJson(jsonString);

import 'dart:convert';

ResInvoiceWithdrawal resInvoiceWithdrawalFromJson(String str) =>
    ResInvoiceWithdrawal.fromJson(json.decode(str));

String resInvoiceWithdrawalToJson(ResInvoiceWithdrawal data) =>
    json.encode(data.toJson());

class ResInvoiceWithdrawal {
  bool? success;
  dynamic message;
  DataInvoiceWidraw? data;

  ResInvoiceWithdrawal({
    this.success,
    this.message,
    this.data,
  });

  factory ResInvoiceWithdrawal.fromJson(Map<String, dynamic> json) =>
      ResInvoiceWithdrawal(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : DataInvoiceWidraw.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class DataInvoiceWidraw {
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
  PayoutsDetail? payoutsDetail;
  User? user;
  Affiliate? affiliate;

  DataInvoiceWidraw({
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

  factory DataInvoiceWidraw.fromJson(Map<String, dynamic> json) =>
      DataInvoiceWidraw(
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
            ? null
            : PayoutsDetail.fromJson(json["payouts_detail"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        affiliate: json["affiliate"] == null
            ? null
            : Affiliate.fromJson(json["affiliate"]),
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
        "payouts_detail": payoutsDetail?.toJson(),
        "user": user?.toJson(),
        "affiliate": affiliate?.toJson(),
      };
}

class Affiliate {
  int? id;
  dynamic idUser;
  dynamic idUserMember;
  dynamic totalMember;
  dynamic totalRealMoney;
  dynamic totalSaldoAffiliate;
  dynamic bankName;
  dynamic bankNumber;
  dynamic bankAccountName;
  dynamic referralCode;
  dynamic depositCompleted;
  dynamic countRealMoney;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic isActive;

  Affiliate({
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
    this.countRealMoney,
    this.createdAt,
    this.updatedAt,
    this.isActive,
  });

  factory Affiliate.fromJson(Map<String, dynamic> json) => Affiliate(
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
        "bank_account_name": bankAccountName,
        "referral_code": referralCode,
        "deposit_completed": depositCompleted,
        "count_real_money": countRealMoney,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "is_active": isActive,
      };
}

class PayoutsDetail {
  dynamic amount;
  dynamic beneficiaryName;
  dynamic beneficiaryAccount;
  dynamic bank;
  dynamic referenceNo;
  dynamic notes;
  dynamic beneficiaryEmail;
  dynamic status;
  dynamic createdBy;
  DateTime? createdAt;
  DateTime? updatedAt;

  PayoutsDetail({
    this.amount,
    this.beneficiaryName,
    this.beneficiaryAccount,
    this.bank,
    this.referenceNo,
    this.notes,
    this.beneficiaryEmail,
    this.status,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  factory PayoutsDetail.fromJson(Map<String, dynamic> json) => PayoutsDetail(
        amount: json["amount"],
        beneficiaryName: json["beneficiary_name"],
        beneficiaryAccount: json["beneficiary_account"],
        bank: json["bank"],
        referenceNo: json["reference_no"],
        notes: json["notes"],
        beneficiaryEmail: json["beneficiary_email"],
        status: json["status"],
        createdBy: json["created_by"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "beneficiary_name": beneficiaryName,
        "beneficiary_account": beneficiaryAccount,
        "bank": bank,
        "reference_no": referenceNo,
        "notes": notes,
        "beneficiary_email": beneficiaryEmail,
        "status": status,
        "created_by": createdBy,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
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
