// To parse this JSON data, do
//
//     final resGetTotalSaldo = resGetTotalSaldoFromJson(jsonString);

import 'dart:convert';

ResGetTotalSaldo resGetTotalSaldoFromJson(String str) =>
    ResGetTotalSaldo.fromJson(json.decode(str));

String resGetTotalSaldoToJson(ResGetTotalSaldo data) =>
    json.encode(data.toJson());

class ResGetTotalSaldo {
  bool? success;
  String? message;
  DataTotalSaldo? data;

  ResGetTotalSaldo({
    this.success,
    this.message,
    this.data,
  });

  factory ResGetTotalSaldo.fromJson(Map<String, dynamic> json) =>
      ResGetTotalSaldo(
        success: json["success"],
        message: json["message"],
        data:
            json["data"] == null ? null : DataTotalSaldo.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class DataTotalSaldo {
  dynamic totalSaldo;
  String? currency;

  DataTotalSaldo({
    this.totalSaldo,
    this.currency,
  });

  factory DataTotalSaldo.fromJson(Map<String, dynamic> json) => DataTotalSaldo(
        totalSaldo: json["total_saldo"],
        currency: json["currency"],
      );

  Map<String, dynamic> toJson() => {
        "total_saldo": totalSaldo,
        "currency": currency,
      };
}
