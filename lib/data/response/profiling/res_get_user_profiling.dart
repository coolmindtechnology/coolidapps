// To parse this JSON data, do
//
//     final resGetUserProfiling = resGetUserProfilingFromJson(jsonString);

import 'dart:convert';

ResGetUserProfiling resGetUserProfilingFromJson(String str) => ResGetUserProfiling.fromJson(json.decode(str));

String resGetUserProfilingToJson(ResGetUserProfiling data) => json.encode(data.toJson());

class ResGetUserProfiling {
  bool? success;
  String? message;
  UserProfiling? data;

  ResGetUserProfiling({
    this.success,
    this.message,
    this.data,
  });

  factory ResGetUserProfiling.fromJson(Map<String, dynamic> json) => ResGetUserProfiling(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : UserProfiling.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class UserProfiling {
  String? id;
  String? idUser;
  String? idProfiling;
  String? result;
  String? bloodType;
  dynamic idDeposit;
  dynamic idMultiple;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? idLogResult;
  String? name;
  String? birthDate;
  String? monthDate;
  String? yearDate;
  String? domicile;
  String? idRole;
  String? phoneNumber;
  String? password;
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
  dynamic totalDeposit;
  dynamic rememberToken;
  String? resultVariable;
  String? character;
  String? title;

  UserProfiling({
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
    this.idLogResult,
    this.name,
    this.birthDate,
    this.monthDate,
    this.yearDate,
    this.domicile,
    this.idRole,
    this.phoneNumber,
    this.password,
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
    this.rememberToken,
    this.resultVariable,
    this.character,
    this.title,
  });

  factory UserProfiling.fromJson(Map<String, dynamic> json) => UserProfiling(
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
    idLogResult: json["id_log_result"],
    name: json["name"],
    birthDate: json["birth_date"],
    monthDate: json["month_date"],
    yearDate: json["year_date"],
    domicile: json["domicile"],
    idRole: json["id_role"],
    phoneNumber: json["phone_number"],
    password: json["password"],
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
    rememberToken: json["remember_token"],
    resultVariable: json["result_variable"],
    character: json["character"],
    title: json["title"],
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
    "id_log_result": idLogResult,
    "name": name,
    "birth_date": birthDate,
    "month_date": monthDate,
    "year_date": yearDate,
    "domicile": domicile,
    "id_role": idRole,
    "phone_number": phoneNumber,
    "password": password,
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
    "remember_token": rememberToken,
    "result_variable": resultVariable,
    "character": character,
    "title": title,
  };
}
