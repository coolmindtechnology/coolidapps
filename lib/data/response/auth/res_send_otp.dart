// To parse this JSON data, do
//
//     final resSendOtp = resSendOtpFromJson(jsonString);

import 'dart:convert';

ResSendOtp resSendOtpFromJson(String str) =>
    ResSendOtp.fromJson(json.decode(str));

String resSendOtpToJson(ResSendOtp data) => json.encode(data.toJson());

class ResSendOtp {
  bool? success;
  String? message;
  DataSendOtp? data;

  ResSendOtp({
    this.success,
    this.message,
    this.data,
  });

  factory ResSendOtp.fromJson(Map<String, dynamic> json) => ResSendOtp(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : DataSendOtp.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class DataSendOtp {
  int? id;
  String? name;
  String? otpCode;
  DateTime? otpTime;
  String? isVerified;

  DataSendOtp({
    this.id,
    this.name,
    this.otpCode,
    this.otpTime,
    this.isVerified,
  });

  factory DataSendOtp.fromJson(Map<String, dynamic> json) => DataSendOtp(
        id: json["id"],
        name: json["name"],
        otpCode: json["otp_code"],
        otpTime:
            json["otp_time"] == null ? null : DateTime.parse(json["otp_time"]),
        isVerified: json["is_verified"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "otp_code": otpCode,
        "otp_time": otpTime?.toIso8601String(),
        "is_verified": isVerified,
      };
}
