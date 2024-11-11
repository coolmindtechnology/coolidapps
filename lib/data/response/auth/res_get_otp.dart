// To parse this JSON data, do
//
//     final resGetOtp = resGetOtpFromJson(jsonString);

import 'dart:convert';

ResGetOtp resGetOtpFromJson(String str) => ResGetOtp.fromJson(json.decode(str));

String resGetOtpToJson(ResGetOtp data) => json.encode(data.toJson());

class ResGetOtp {
  bool? status;
  String? message;
  DataOtp? data;

  ResGetOtp({
    this.status,
    this.message,
    this.data,
  });

  factory ResGetOtp.fromJson(Map<String, dynamic> json) => ResGetOtp(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : DataOtp.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class DataOtp {
  dynamic name;
  dynamic otpCode;
  DateTime? otpTime;
  dynamic isVerified;

  DataOtp({
    this.name,
    this.otpCode,
    this.otpTime,
    this.isVerified,
  });

  factory DataOtp.fromJson(Map<String, dynamic> json) => DataOtp(
        name: json["name"],
        otpCode: json["otp_code"],
        otpTime:
            json["otp_time"] == null ? null : DateTime.parse(json["otp_time"]),
        isVerified: json["is_verified"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "otp_code": otpCode,
        "otp_time": otpTime?.toIso8601String(),
        "is_verified": isVerified,
      };
}
