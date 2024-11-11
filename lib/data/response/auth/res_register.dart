// To parse this JSON data, do
//
//     final resRegister = resRegisterFromJson(jsonString);

import 'dart:convert';

ResRegister resRegisterFromJson(String str) =>
    ResRegister.fromJson(json.decode(str));

String resRegisterToJson(ResRegister data) => json.encode(data.toJson());

class ResRegister {
  bool? success;
  String? message;
  DataRegister? data;

  ResRegister({
    this.success,
    this.message,
    this.data,
  });

  factory ResRegister.fromJson(Map<String, dynamic> json) => ResRegister(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : DataRegister.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class DataRegister {
  DateTime? otpTime;
  dynamic userId;
  dynamic phoneNumber;
  Errors? errors;

  DataRegister({
    this.otpTime,
    this.userId,
    this.phoneNumber,
    this.errors,
  });

  factory DataRegister.fromJson(Map<String, dynamic> json) => DataRegister(
        otpTime:
            json["otp_time"] == null ? null : DateTime.parse(json["otp_time"]),
        userId: json["user_id"],
        phoneNumber: json["phone_number"],
        errors: json["errors"] == null ? null : Errors.fromJson(json["errors"]),
      );

  Map<String, dynamic> toJson() => {
        "otp_time": otpTime?.toIso8601String(),
        "user_id": userId,
        "phone_number": phoneNumber,
        "errors": errors?.toJson(),
      };
}

class Errors {
  List<String>? phoneNumber;
  List<String>? password;
  List<String>? passwordConfirmation;
  List<String>? codeReferal;
  List<String>? email;

  Errors({
    this.phoneNumber,
    this.passwordConfirmation,
    this.password,
    this.codeReferal,
    this.email,
  });

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
        phoneNumber: json["phone_number"] == null
            ? []
            : List<String>.from(json["phone_number"]!.map((x) => x)),
        password: json["password"] == null
            ? []
            : List<String>.from(json["password"]!.map((x) => x)),
        passwordConfirmation: json["password_confirmation"] == null
            ? []
            : List<String>.from(json["password_confirmation"]!.map((x) => x)),
        codeReferal: json["code_referal"] == null
            ? []
            : List<String>.from(json["code_referal"]!.map((x) => x)),
        email: json["email"] == null
            ? []
            : List<String>.from(json["email"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "phone_number": phoneNumber == null
            ? []
            : List<dynamic>.from(phoneNumber!.map((x) => x)),
        "password":
            password == null ? [] : List<dynamic>.from(password!.map((x) => x)),
        "password_confirmation": passwordConfirmation == null
            ? []
            : List<dynamic>.from(passwordConfirmation!.map((x) => x)),
        "code_referal": codeReferal == null
            ? []
            : List<dynamic>.from(codeReferal!.map((x) => x)),
        "email": email == null ? [] : List<dynamic>.from(email!.map((x) => x)),
      };
}
