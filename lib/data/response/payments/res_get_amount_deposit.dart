// To parse this JSON data, do
//
//     final resGetDeposit = resGetDepositFromJson(jsonString);

import 'dart:convert';

ResGetAmountDeposit resGetDepositFromJson(String str) =>
    ResGetAmountDeposit.fromJson(json.decode(str));

String resGetDepositToJson(ResGetAmountDeposit data) =>
    json.encode(data.toJson());

class ResGetAmountDeposit {
  bool? success;
  String? message;
  DataTotalDeposit? data;

  ResGetAmountDeposit({
    this.success,
    this.message,
    this.data,
  });

  factory ResGetAmountDeposit.fromJson(Map<String, dynamic> json) =>
      ResGetAmountDeposit(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : DataTotalDeposit.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class DataTotalDeposit {
  String? totalDeposit;

  DataTotalDeposit({
    this.totalDeposit,
  });

  factory DataTotalDeposit.fromJson(Map<String, dynamic> json) =>
      DataTotalDeposit(
        totalDeposit: json["total_deposit"],
      );

  Map<String, dynamic> toJson() => {
        "total_deposit": totalDeposit,
      };
}
