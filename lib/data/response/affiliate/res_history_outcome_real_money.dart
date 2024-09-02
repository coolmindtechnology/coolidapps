// To parse this JSON data, do
//
//     final resHistoryRealMoney = resHistoryRealMoneyFromJson(jsonString);

import 'dart:convert';

ResHistoryOutcomeRealMoney resHistoryRealMoneyFromJson(String str) =>
    ResHistoryOutcomeRealMoney.fromJson(json.decode(str));

String resHistoryRealMoneyToJson(ResHistoryOutcomeRealMoney data) =>
    json.encode(data.toJson());

class ResHistoryOutcomeRealMoney {
  bool? success;
  String? message;
  DataPaginationOutcomeHistoryRealMoney? data;

  ResHistoryOutcomeRealMoney({
    this.success,
    this.message,
    this.data,
  });

  factory ResHistoryOutcomeRealMoney.fromJson(Map<String, dynamic> json) =>
      ResHistoryOutcomeRealMoney(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : DataPaginationOutcomeHistoryRealMoney.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class DataPaginationOutcomeHistoryRealMoney {
  int? currentPage;
  List<HistoryOutcomeRealMoney>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  DataPaginationOutcomeHistoryRealMoney({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory DataPaginationOutcomeHistoryRealMoney.fromJson(
          Map<String, dynamic> json) =>
      DataPaginationOutcomeHistoryRealMoney(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<HistoryOutcomeRealMoney>.from(
                json["data"]!.map((x) => HistoryOutcomeRealMoney.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] == null
            ? []
            : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": links == null
            ? []
            : List<dynamic>.from(links!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class HistoryOutcomeRealMoney {
  int? id;
  String? idUser;
  String? idAffiliate;
  dynamic idSaldoAffiliate;
  String? amount;
  String? transactionType;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? referenceNo;
  PayoutsDetail? payoutsDetail;
  User? user;
  Affiliate? affiliate;

  HistoryOutcomeRealMoney({
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

  factory HistoryOutcomeRealMoney.fromJson(Map<String, dynamic> json) =>
      HistoryOutcomeRealMoney(
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

class User {
  int? id;
  String? idRole;
  String? name;
  String? phoneNumber;
  String? email;
  dynamic emailVerifiedAt;
  String? address;
  String? image;
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
  String? isAffiliate;
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

class Link {
  String? url;
  String? label;
  bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}

class Affiliate {
  int? id;
  String? idUser;
  String? idUserMember;
  String? totalMember;
  String? totalRealMoney;
  String? totalSaldoAffiliate;
  String? bankName;
  String? bankNumber;
  String? bankAccountName;
  String? referralCode;
  String? depositCompleted;
  String? countRealMoney;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? isActive;

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
  String? amount;
  String? beneficiaryName;
  String? beneficiaryAccount;
  String? bank;
  String? referenceNo;
  String? notes;
  String? beneficiaryEmail;
  String? status;
  String? createdBy;
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
