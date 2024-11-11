// To parse this JSON data, do
//
//     final resUpdateTransactionProfiling = resUpdateTransactionProfilingFromJson(jsonString);

import 'dart:convert';

ResUpdateTransactionProfiling resUpdateTransactionProfilingFromJson(
        String str) =>
    ResUpdateTransactionProfiling.fromJson(json.decode(str));

String resUpdateTransactionProfilingToJson(
        ResUpdateTransactionProfiling data) =>
    json.encode(data.toJson());

class ResUpdateTransactionProfiling {
  bool? success;
  dynamic message;
  DataUpdateTransactionProfiling? data;

  ResUpdateTransactionProfiling({
    this.success,
    this.message,
    this.data,
  });

  factory ResUpdateTransactionProfiling.fromJson(Map<String, dynamic> json) =>
      ResUpdateTransactionProfiling(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : DataUpdateTransactionProfiling.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class DataUpdateTransactionProfiling {
  int? id;
  dynamic idUser;
  dynamic idLogProfilingResult;
  dynamic amount;
  dynamic discount;
  dynamic totalAmount;
  dynamic status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  dynamic sisaDeposit;
  dynamic paymentType;
  int? qty;

  DataUpdateTransactionProfiling({
    this.id,
    this.idUser,
    this.idLogProfilingResult,
    this.amount,
    this.discount,
    this.totalAmount,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.sisaDeposit,
    this.paymentType,
    this.qty,
  });

  factory DataUpdateTransactionProfiling.fromJson(Map<String, dynamic> json) =>
      DataUpdateTransactionProfiling(
        id: json["id"],
        idUser: json["id_user"],
        idLogProfilingResult: json["id_log_profiling_result"],
        amount: json["amount"],
        discount: json["discount"],
        totalAmount: json["total_amount"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        sisaDeposit: json["sisa_deposit"],
        paymentType: json["payment_type"],
        qty: json["qty"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_user": idUser,
        "id_log_profiling_result": idLogProfilingResult,
        "amount": amount,
        "discount": discount,
        "total_amount": totalAmount,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "sisa_deposit": sisaDeposit,
        "payment_type": paymentType,
        "qty": qty,
      };
}
