// To parse this JSON data, do
//
//     final resUpdatePayment = resUpdatePaymentFromJson(jsonString);

import 'dart:convert';

ResUpdatePayment resUpdatePaymentFromJson(String str) => ResUpdatePayment.fromJson(json.decode(str));

String resUpdatePaymentToJson(ResUpdatePayment data) => json.encode(data.toJson());

class ResUpdatePayment {
  bool? success;
  String? message;
  String? data;

  ResUpdatePayment({
    this.success,
    this.message,
    this.data,
  });

  factory ResUpdatePayment.fromJson(Map<String, dynamic> json) => ResUpdatePayment(
    success: json["success"],
    message: json["message"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data,
  };
}
