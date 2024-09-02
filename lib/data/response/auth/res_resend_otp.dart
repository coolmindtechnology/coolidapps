// To parse this JSON data, do
//
//     final resResendOtp = resResendOtpFromJson(jsonString);

import 'dart:convert';

ResResendOtp resResendOtpFromJson(String str) => ResResendOtp.fromJson(json.decode(str));

String resResendOtpToJson(ResResendOtp data) => json.encode(data.toJson());

class ResResendOtp {
    bool? status;
    String? message;
    DataResendOtp? data;

    ResResendOtp({
        this.status,
        this.message,
        this.data,
    });

    factory ResResendOtp.fromJson(Map<String, dynamic> json) => ResResendOtp(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : DataResendOtp.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
    };
}

class DataResendOtp {
    dynamic name;
    String? otpCode;
    DateTime? otpTime;
    String? isVerified;

    DataResendOtp({
        this.name,
        this.otpCode,
        this.otpTime,
        this.isVerified,
    });

    factory DataResendOtp.fromJson(Map<String, dynamic> json) => DataResendOtp(
        name: json["name"],
        otpCode: json["otp_code"],
        otpTime: json["otp_time"] == null ? null : DateTime.parse(json["otp_time"]),
        isVerified: json["is_verified"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "otp_code": otpCode,
        "otp_time": otpTime?.toIso8601String(),
        "is_verified": isVerified,
    };
}
