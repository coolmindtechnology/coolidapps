// To parse this JSON data, do
//
//     final resOverView = resOverViewFromJson(jsonString);

import 'dart:convert';

ResOverView resOverViewFromJson(String str) => ResOverView.fromJson(json.decode(str));

String resOverViewToJson(ResOverView data) => json.encode(data.toJson());

class ResOverView {
  bool? success;
  String? message;
  Data? data;

  ResOverView({
    this.success,
    this.message,
    this.data,
  });

  factory ResOverView.fromJson(Map<String, dynamic> json) => ResOverView(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  int? id;
  dynamic idUser;
  dynamic idAgentCool;
  dynamic idUserMember;
  dynamic totalMember;
  dynamic totalRealMoney;
  dynamic totalSaldoAffiliate;
  dynamic oldTotalSaldoAffiliate;
  dynamic bankName;
  dynamic bankNumber;
  dynamic bankAccountName;
  dynamic referralCode;
  dynamic depositCompleted;
  dynamic countRealMoney;
  dynamic loanSaldo;
  dynamic statusTenggang;
  dynamic nonActiveDate;
  dynamic startVacumDate;
  dynamic totalVacumDay;
  dynamic waVacum;
  dynamic isVacumNotif;
  dynamic totalActivePeriod;
  dynamic lastTransactionDate;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic isActive;
  dynamic dateLoan;
  dynamic totalPoint;
  dynamic linkRefferalCode;
  User? user;
  dynamic statusApprovalConsultant;
  dynamic idConsultant;
  dynamic totalEbook;
  dynamic linkreferalcode;
  Data({
    this.id,
    this.idUser,
    this.idAgentCool,
    this.idUserMember,
    this.totalMember,
    this.totalRealMoney,
    this.totalSaldoAffiliate,
    this.oldTotalSaldoAffiliate,
    this.bankName,
    this.bankNumber,
    this.bankAccountName,
    this.referralCode,
    this.depositCompleted,
    this.countRealMoney,
    this.loanSaldo,
    this.statusTenggang,
    this.nonActiveDate,
    this.startVacumDate,
    this.totalVacumDay,
    this.waVacum,
    this.isVacumNotif,
    this.totalActivePeriod,
    this.lastTransactionDate,
    this.createdAt,
    this.updatedAt,
    this.isActive,
    this.dateLoan,
    this.totalPoint,
    this.linkRefferalCode,
    this.user,
    this.statusApprovalConsultant,
    this.idConsultant,
    this.totalEbook,
    this.linkreferalcode,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    idUser: json["id_user"],
    idAgentCool: json["id_agent_cool"],
    idUserMember: json["id_user_member"],
    totalMember: json["total_member"],
    totalRealMoney: json["total_real_money"],
    totalSaldoAffiliate: json["total_saldo_affiliate"],
    oldTotalSaldoAffiliate: json["old_total_saldo_affiliate"],
    bankName: json["bank_name"],
    bankNumber: json["bank_number"],
    bankAccountName: json["bank_account_name"],
    referralCode: json["referral_code"],
    depositCompleted: json["deposit_completed"],
    countRealMoney: json["count_real_money"],
    loanSaldo: json["loan_saldo"],
    statusTenggang: json["statusTenggang"],
    nonActiveDate: json["non_active_date"],
    startVacumDate: json["start_vacum_date"],
    totalVacumDay: json["total_vacum_day"],
    waVacum: json["wa_vacum"],
    isVacumNotif: json["is_vacum_notif"],
    totalActivePeriod: json["total_active_period"],
    lastTransactionDate: json["last_transaction_date"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    isActive: json["is_active"],
    dateLoan: json["date_loan"],
    totalPoint: json["total_point"],
    linkRefferalCode: json["link_refferal_code"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    statusApprovalConsultant: json["status_approval_consultant"],
    idConsultant: json["id_consultant"],
    totalEbook: json["total_ebook"],
    linkreferalcode: json["link_refferal_code"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_user": idUser,
    "id_agent_cool": idAgentCool,
    "id_user_member": idUserMember,
    "total_member": totalMember,
    "total_real_money": totalRealMoney,
    "total_saldo_affiliate": totalSaldoAffiliate,
    "old_total_saldo_affiliate": oldTotalSaldoAffiliate,
    "bank_name": bankName,
    "bank_number": bankNumber,
    "bank_account_name": bankAccountName,
    "referral_code": referralCode,
    "deposit_completed": depositCompleted,
    "count_real_money": countRealMoney,
    "loan_saldo": loanSaldo,
    "statusTenggang": statusTenggang,
    "non_active_date": nonActiveDate,
    "start_vacum_date": startVacumDate,
    "total_vacum_day": totalVacumDay,
    "wa_vacum": waVacum,
    "is_vacum_notif": isVacumNotif,
    "total_active_period": totalActivePeriod,
    "last_transaction_date": lastTransactionDate,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "is_active": isActive,
    "date_loan": dateLoan,
    "total_point": totalPoint,
    "link_refferal_code": linkRefferalCode,
    "user": user?.toJson(),
    "status_approval_consultant": statusApprovalConsultant,
    "id_consultant": idConsultant,
    "total_ebook": totalEbook,
    "link_refferal_code": linkreferalcode,
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
  dynamic completedCommissions;
  dynamic reason;
  dynamic fToken;
  dynamic localeId;
  dynamic firebaseUid;

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
    this.completedCommissions,
    this.reason,
    this.fToken,
    this.localeId,
    this.firebaseUid,
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
    otpTime: json["otp_time"] == null ? null : DateTime.parse(json["otp_time"]),
    isProfiling: json["is_profiling"],
    isVerified: json["is_verified"],
    isDeposit: json["is_deposit"],
    totalDeposit: json["total_deposit"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    idAffiliate: json["id_affiliate"],
    codeReferal: json["code_referal"],
    idAgent: json["id_agent"],
    idMitra: json["id_mitra"],
    isAffiliate: json["is_affiliate"],
    verificationToken: json["verification_token"],
    completedCommissions: json["completed_commissions"],
    reason: json["reason"],
    fToken: json["f_token"],
    localeId: json["locale_id"],
    firebaseUid: json["firebase_uid"],
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
    "completed_commissions": completedCommissions,
    "reason": reason,
    "f_token": fToken,
    "locale_id": localeId,
    "firebase_uid": firebaseUid,
  };
}

