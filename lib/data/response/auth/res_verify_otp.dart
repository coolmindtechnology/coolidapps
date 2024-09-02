// To parse this JSON data, do
//
//     final resVerifyOtp = resVerifyOtpFromJson(jsonString);

import 'dart:convert';

ResVerifyOtp resVerifyOtpFromJson(String str) => ResVerifyOtp.fromJson(json.decode(str));

String resVerifyOtpToJson(ResVerifyOtp data) => json.encode(data.toJson());

class ResVerifyOtp {
    bool? status;
    String? message;

    ResVerifyOtp({
        this.status,
        this.message,
    });

    factory ResVerifyOtp.fromJson(Map<String, dynamic> json) => ResVerifyOtp(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
    };
}
