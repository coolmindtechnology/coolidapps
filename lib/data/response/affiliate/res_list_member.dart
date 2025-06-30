// To parse this JSON data, do
//
//     final resListMember = resListMemberFromJson(jsonString);

import 'dart:convert';

ResListMember resListMemberFromJson(String str) => ResListMember.fromJson(json.decode(str));

String resListMemberToJson(ResListMember data) => json.encode(data.toJson());

class ResListMember {
  bool? success;
  String? message;
  List<Datum>? data;

  ResListMember({
    this.success,
    this.message,
    this.data,
  });

  factory ResListMember.fromJson(Map<String, dynamic> json) => ResListMember(
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
  String? tipeOtak;
  List<ProfilingElement>? profilings;

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
    this.tipeOtak,
    this.profilings,
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
    tipeOtak: json["tipe_otak"],
    profilings: json["profilings"] == null ? [] : List<ProfilingElement>.from(json["profilings"]!.map((x) => ProfilingElement.fromJson(x))),
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
    "tipe_otak": tipeOtak,
    "profilings": profilings == null ? [] : List<dynamic>.from(profilings!.map((x) => x.toJson())),
  };
}

class ProfilingElement {
  int? id;
  String? idUser;
  String? idProfiling;
  String? result;
  String? bloodType;
  dynamic idDeposit;
  String? idMultiple;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  ProfilingProfiling? profiling;

  ProfilingElement({
    this.id,
    this.idUser,
    this.idProfiling,
    this.result,
    this.bloodType,
    this.idDeposit,
    this.idMultiple,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.profiling,
  });

  factory ProfilingElement.fromJson(Map<String, dynamic> json) => ProfilingElement(
    id: json["id"],
    idUser: json["id_user"],
    idProfiling: json["id_profiling"],
    result: json["result"],
    bloodType: json["blood_type"],
    idDeposit: json["id_deposit"],
    idMultiple: json["id_multiple"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    profiling: json["profiling"] == null ? null : ProfilingProfiling.fromJson(json["profiling"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_user": idUser,
    "id_profiling": idProfiling,
    "result": result,
    "blood_type": bloodType,
    "id_deposit": idDeposit,
    "id_multiple": idMultiple,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "profiling": profiling?.toJson(),
  };
}



class ProfilingProfiling {
  String? idUser;
  String? name;
  String? birthDate;
  String? monthDate;
  String? yearDate;
  String? bloodType;
  String? domicile;
  dynamic refCode;
  dynamic deletedAt;

  ProfilingProfiling({
    this.idUser,
    this.name,
    this.birthDate,
    this.monthDate,
    this.yearDate,
    this.bloodType,
    this.domicile,
    this.refCode,
    this.deletedAt,
  });

  factory ProfilingProfiling.fromJson(Map<String, dynamic> json) => ProfilingProfiling(
    idUser: json["id_user"],
    name: json["name"],
    birthDate: json["birth_date"],
    monthDate: json["month_date"],
    yearDate: json["year_date"],
    bloodType: json["blood_type"],
    domicile: json["domicile"],
    refCode: json["ref_code"],
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id_user": idUser,
    "name": name,
    "birth_date": birthDate,
    "month_date": monthDate,
    "year_date": yearDate,
    "blood_type": bloodType,
    "domicile": domicile,
    "ref_code": refCode,
    "deleted_at": deletedAt,
  };
}
