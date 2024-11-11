// To parse this JSON data, do
//
//     final resTransactionProfiling = resTransactionProfilingFromJson(jsonString);

import 'dart:convert';

ResUpdateTransactionProfiling resTransactionProfilingFromJson(String str) =>
    ResUpdateTransactionProfiling.fromJson(json.decode(str));

String resTransactionProfilingToJson(ResUpdateTransactionProfiling data) =>
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
  dynamic id;
  dynamic idUser;
  dynamic idLogProfilingResult;
  dynamic amount;
  dynamic discount;
  dynamic totalAmount;
  dynamic status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  dynamic paymentType;
  int? qty;
  List<ItemDetailProfiling>? itemDetails;

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
    this.paymentType,
    this.qty,
    this.itemDetails,
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
        paymentType: json["payment_type"],
        qty: json["qty"],
        itemDetails: json["item_details"] == null
            ? []
            : List<ItemDetailProfiling>.from(json["item_details"]!
                .map((x) => ItemDetailProfiling.fromJson(x))),
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
        "payment_type": paymentType,
        "qty": qty,
        "item_details": itemDetails == null
            ? []
            : List<dynamic>.from(itemDetails!.map((x) => x.toJson())),
      };
}

class ItemDetailProfiling {
  dynamic logId;
  dynamic profilingId;
  dynamic profilingName;
  dynamic userId;
  dynamic userName;
  dynamic status;
  dynamic bloodType;

  ItemDetailProfiling({
    this.logId,
    this.profilingId,
    this.profilingName,
    this.userId,
    this.userName,
    this.status,
    this.bloodType,
  });

  factory ItemDetailProfiling.fromJson(Map<String, dynamic> json) =>
      ItemDetailProfiling(
        logId: json["log_id"],
        profilingId: json["profiling_id"],
        profilingName: json["profiling_name"],
        userId: json["user_id"],
        userName: json["user_name"],
        status: json["status"],
        bloodType: json["blood_type"],
      );

  Map<String, dynamic> toJson() => {
        "log_id": logId,
        "profiling_id": profilingId,
        "profiling_name": profilingName,
        "user_id": userId,
        "user_name": userName,
        "status": status,
        "blood_type": bloodType,
      };
}
