// To parse this JSON data, do
//
//     final resUpdateUser = resUpdateUserFromJson(jsonString);

import 'dart:convert';

ResUpdateUser resUpdateUserFromJson(String str) =>
    ResUpdateUser.fromJson(json.decode(str));

String resUpdateUserToJson(ResUpdateUser data) => json.encode(data.toJson());

class ResUpdateUser {
  bool? success;
  String? message;
  DataUpdateUser? data;
  Errors? errors;

  ResUpdateUser({
    this.success,
    this.message,
    this.data,
    this.errors,
  });

  factory ResUpdateUser.fromJson(Map<String, dynamic> json) => ResUpdateUser(
        success: json["success"],
        message: json["message"],
        data:
            json["data"] == null ? null : DataUpdateUser.fromJson(json["data"]),
        errors: json["errors"] == null ? null : Errors.fromJson(json["errors"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
        "errors": errors?.toJson(),
      };
}

class DataUpdateUser {
  int? id;
  String? idRole;
  String? name;
  String? phoneNumber;
  String? email;
  dynamic emailVerifiedAt;
  dynamic address;
  dynamic image;
  dynamic idCardNumber;
  String? otpCode;
  DateTime? otpTime;
  String? isVerified;
  String? isDeposit;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  DataUpdateUser({
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
    this.isVerified,
    this.isDeposit,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory DataUpdateUser.fromJson(Map<String, dynamic> json) => DataUpdateUser(
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
        isVerified: json["is_verified"],
        isDeposit: json["is_deposit"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
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
        "is_verified": isVerified,
        "is_deposit": isDeposit,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
      };
}

class Errors {
  List<String>? name;
  List<String>? email;
  List<String>? phoneNumber;
  List<String>? idCardNumber;
  List<String>? address;

  Errors({
    this.name,
    this.email,
    this.phoneNumber,
    this.idCardNumber,
    this.address,
  });

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
        name: json["name"] == null
            ? []
            : List<String>.from(json["name"]!.map((x) => x)),
        email: json["email"] == null
            ? []
            : List<String>.from(json["email"]!.map((x) => x)),
        phoneNumber: json["phone_number"] == null
            ? []
            : List<String>.from(json["phone_number"]!.map((x) => x)),
        idCardNumber: json["id_card_number"] == null
            ? []
            : List<String>.from(json["id_card_number"]!.map((x) => x)),
        address: json["address"] == null
            ? []
            : List<String>.from(json["address"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? [] : List<dynamic>.from(name!.map((x) => x)),
        "email": email == null ? [] : List<dynamic>.from(email!.map((x) => x)),
        "phone_number": phoneNumber == null
            ? []
            : List<dynamic>.from(phoneNumber!.map((x) => x)),
        "id_card_number": idCardNumber == null
            ? []
            : List<dynamic>.from(idCardNumber!.map((x) => x)),
        "address":
            address == null ? [] : List<dynamic>.from(address!.map((x) => x)),
      };
}
