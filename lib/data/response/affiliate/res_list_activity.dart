// To parse this JSON data, do
//
//     final resListActivity = resListActivityFromJson(jsonString);

import 'dart:convert';

ResListActivity resListActivityFromJson(String str) => ResListActivity.fromJson(json.decode(str));

String resListActivityToJson(ResListActivity data) => json.encode(data.toJson());

class ResListActivity {
  bool? success;
  String? message;
  List<Datum>? data;

  ResListActivity({
    this.success,
    this.message,
    this.data,
  });

  factory ResListActivity.fromJson(Map<String, dynamic> json) => ResListActivity(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  int? id;
  String? idRole;
  String? name;
  String? phoneNumber;
  String? email;
  dynamic emailVerifiedAt;
  String? address;
  String? image;
  dynamic idCardNumber;
  String? otpCode;
  DateTime? otpTime;
  String? isProfiling;
  String? isVerified;
  String? isDeposit;
  String? totalDeposit;
  String? totalRealComission;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? idAffiliate;
  String? codeReferal;
  String? idAgent;
  String? idMitra;
  int? isAffiliate;
  dynamic verificationToken;
  String? completedCommissions;
  dynamic reason;
  String? fToken;
  String? localeId;
  String? firebaseUid;
  String? myRefCode;
  String? profilingsCount;
  List<AffPoint>? affPoint;

  Datum({
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
    this.totalRealComission,
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
    this.myRefCode,
    this.profilingsCount,
    this.affPoint,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
    totalRealComission: json["total_real_comission"],
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
    myRefCode: json["my_ref_code"],
    profilingsCount: json["profilings_count"],
    affPoint: json["aff_point"] == null ? [] : List<AffPoint>.from(json["aff_point"]!.map((x) => AffPoint.fromJson(x))),
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
    "total_real_comission": totalRealComission,
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
    "my_ref_code": myRefCode,
    "profilings_count": profilingsCount,
    "aff_point": affPoint == null ? [] : List<dynamic>.from(affPoint!.map((x) => x.toJson())),
  };
}

class AffPoint {
  int? id;
  String? orderId;
  String? affiliatorId;
  String? userMemberId;
  dynamic? point;
  String? status;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  AffPoint({
    this.id,
    this.orderId,
    this.affiliatorId,
    this.userMemberId,
    this.point,
    this.status,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory AffPoint.fromJson(Map<String, dynamic> json) => AffPoint(
    id: json["id"],
    orderId: json["order_id"],
    affiliatorId: json["affiliator_id"],
    userMemberId: json["user_member_id"],
    point: json["point"],
    status: json["status"],
    deletedAt: json["deleted_at"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_id": orderId,
    "affiliator_id": affiliatorId,
    "user_member_id": userMemberId,
    "point": point,
    "status": status,
    "deleted_at": deletedAt,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
