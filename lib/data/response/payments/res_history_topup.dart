// To parse this JSON data, do
//
//     final resHistoryTopup = resHistoryTopupFromJson(jsonString);

import 'dart:convert';

ResHistoryTopup resHistoryTopupFromJson(String str) =>
    ResHistoryTopup.fromJson(json.decode(str));

String resHistoryTopupToJson(ResHistoryTopup data) =>
    json.encode(data.toJson());

class ResHistoryTopup {
  bool? success;
  dynamic message;
  List<DataHistoryTopup>? data;

  ResHistoryTopup({
    this.success,
    this.message,
    this.data,
  });

  factory ResHistoryTopup.fromJson(Map<String, dynamic> json) =>
      ResHistoryTopup(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<DataHistoryTopup>.from(
                json["data"]!.map((x) => DataHistoryTopup.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class DataHistoryTopup {
  dynamic id;
  dynamic orderId;
  dynamic idLogs;
  dynamic idItemPayments;
  dynamic idUser;
  dynamic amount;
  dynamic discount;
  dynamic totalAmount;
  dynamic transactionType;
  dynamic paymentType;
  dynamic status;
  dynamic snapToken;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  DataHistoryTopup({
    required this.id,
    this.orderId,
    this.idLogs,
    this.idItemPayments,
    this.idUser,
    this.amount,
    this.discount,
    this.totalAmount,
    this.transactionType,
    this.paymentType,
    this.status,
    this.snapToken,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory DataHistoryTopup.fromJson(Map<String, dynamic> json) =>
      DataHistoryTopup(
        id: json["id"],
        orderId: json["order_id"],
        idLogs: json["id_logs"],
        idItemPayments: json["id_item_payments"],
        idUser: json["id_user"],
        amount: json["amount"],
        discount: json["discount"],
        totalAmount: json["total_amount"],
        transactionType: json["transaction_type"],
        paymentType: json["payment_type"],
        status: json["status"],
        snapToken: json["snap_token"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "id_logs": idLogs,
        "id_item_payments": idItemPayments,
        "id_user": idUser,
        "amount": amount,
        "discount": discount,
        "total_amount": totalAmount,
        "transaction_type": transactionType,
        "payment_type": paymentType,
        "status": status,
        "snap_token": snapToken,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
      };
}
