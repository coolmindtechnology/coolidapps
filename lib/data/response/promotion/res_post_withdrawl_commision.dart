// To parse this JSON data, do
//
//     final resPostWithDrawlCommision = resPostWithDrawlCommisionFromJson(jsonString);

import 'dart:convert';

ResPostWithDrawlCommision resPostWithDrawlCommisionFromJson(String str) => ResPostWithDrawlCommision.fromJson(json.decode(str));

String resPostWithDrawlCommisionToJson(ResPostWithDrawlCommision data) => json.encode(data.toJson());

class ResPostWithDrawlCommision {
  bool? success;
  String? message;
  Data? data;

  ResPostWithDrawlCommision({
    this.success,
    this.message,
    this.data,
  });

  factory ResPostWithDrawlCommision.fromJson(Map<String, dynamic> json) => ResPostWithDrawlCommision(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  double? amountWithdrawn;
  double? newBalance;
  String? batchId;
  String? status;
  String? url;

  Data({
    this.amountWithdrawn,
    this.newBalance,
    this.batchId,
    this.status,
    this.url,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    amountWithdrawn: json["amount_withdrawn"],
    newBalance: json["new_balance"],
    batchId: json["batch_id"],
    status: json["status"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "amount_withdrawn": amountWithdrawn,
    "new_balance": newBalance,
    "batch_id": batchId,
    "status": status,
    "url": url,
  };
}
