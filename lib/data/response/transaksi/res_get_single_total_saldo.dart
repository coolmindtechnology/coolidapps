// To parse this JSON data, do
//
//     final resGetSingleTotalSaldo = resGetSingleTotalSaldoFromJson(jsonString);

import 'dart:convert';

ResGetSingleTotalSaldo resGetSingleTotalSaldoFromJson(String str) =>
    ResGetSingleTotalSaldo.fromJson(json.decode(str));

String resGetSingleTotalSaldoToJson(ResGetSingleTotalSaldo data) =>
    json.encode(data.toJson());

class ResGetSingleTotalSaldo {
  bool? success;
  String? message;
  DataSingleTotalSaldo? data;

  ResGetSingleTotalSaldo({
    this.success,
    this.message,
    this.data,
  });

  factory ResGetSingleTotalSaldo.fromJson(Map<String, dynamic> json) =>
      ResGetSingleTotalSaldo(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : DataSingleTotalSaldo.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class DataSingleTotalSaldo {
  String? totalSaldoAffiliate;
  String? totalRealMoney;

  DataSingleTotalSaldo({
    this.totalSaldoAffiliate,
    this.totalRealMoney,
  });

  factory DataSingleTotalSaldo.fromJson(Map<String, dynamic> json) =>
      DataSingleTotalSaldo(
        totalSaldoAffiliate: json["total_saldo_affiliate"],
        totalRealMoney: json["total_real_money"],
      );

  Map<String, dynamic> toJson() => {
        "total_saldo_affiliate": totalSaldoAffiliate,
        "total_real_money": totalRealMoney,
      };
}
