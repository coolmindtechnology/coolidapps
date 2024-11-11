// To parse this JSON data, do
//
//     final resHistoryRealMoney = resHistoryRealMoneyFromJson(jsonString);

import 'dart:convert';

ResHistoryRealMoney resHistoryRealMoneyFromJson(String str) =>
    ResHistoryRealMoney.fromJson(json.decode(str));

String resHistoryRealMoneyToJson(ResHistoryRealMoney data) =>
    json.encode(data.toJson());

class ResHistoryRealMoney {
  bool? success;
  dynamic message;
  DataPaginationHistoryRealMoney? data;

  ResHistoryRealMoney({
    this.success,
    this.message,
    this.data,
  });

  factory ResHistoryRealMoney.fromJson(Map<String, dynamic> json) =>
      ResHistoryRealMoney(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : DataPaginationHistoryRealMoney.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class DataPaginationHistoryRealMoney {
  int? currentPage;
  List<HistoryRealMoney>? data;
  dynamic firstPageUrl;
  int? from;
  int? lastPage;
  dynamic lastPageUrl;
  List<Link>? links;
  dynamic nextPageUrl;
  dynamic path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  DataPaginationHistoryRealMoney({
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

  factory DataPaginationHistoryRealMoney.fromJson(Map<String, dynamic> json) =>
      DataPaginationHistoryRealMoney(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<HistoryRealMoney>.from(
                json["data"]!.map((x) => HistoryRealMoney.fromJson(x))),
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

class HistoryRealMoney {
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
  User? user;
  dynamic affiliate;

  HistoryRealMoney({
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
    this.user,
    this.affiliate,
  });

  factory HistoryRealMoney.fromJson(Map<String, dynamic> json) =>
      HistoryRealMoney(
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

class Link {
  dynamic url;
  dynamic label;
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
