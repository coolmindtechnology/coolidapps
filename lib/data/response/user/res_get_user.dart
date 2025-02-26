import 'dart:convert';

ResGetUser resGetUserFromJson(String str) =>
    ResGetUser.fromJson(json.decode(str));

String resGetUserToJson(ResGetUser data) => json.encode(data.toJson());

class ResGetUser {
  bool? success;
  String? message;
  DataUser? data;

  ResGetUser({
    this.success,
    this.message,
    this.data,
  });

  factory ResGetUser.fromJson(Map<String, dynamic> json) => ResGetUser(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : DataUser.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class DataUser {
  int id;
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
  dynamic isConsultationsFree;
  dynamic typeBrain;

  DataUser({
    required this.id,
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
    this.isConsultationsFree,
    this.typeBrain,
  });

  factory DataUser.fromJson(Map<String, dynamic> json) => DataUser(
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
    completedCommissions: json["completed_commissions"],
    reason: json["reason"],
    fToken: json["f_token"],
    localeId: json["locale_id"],
    firebaseUid: json["firebase_uid"],
    isConsultationsFree: json["is_consulations_free"],
    typeBrain: json["type_brain"],
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
    "is_consulations_free": isConsultationsFree,
    "type_brain": typeBrain,
  };
}
