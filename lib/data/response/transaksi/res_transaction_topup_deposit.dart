// To parse this JSON data, do
//
//     final resTransactionTopupDeposit = resTransactionTopupDepositFromJson(jsonString);

import 'dart:convert';

ResTransactionTopupDeposit resTransactionTopupDepositFromJson(String str) =>
    ResTransactionTopupDeposit.fromJson(json.decode(str));

String resTransactionTopupDepositToJson(ResTransactionTopupDeposit data) =>
    json.encode(data.toJson());

class ResTransactionTopupDeposit {
  bool? success;
  String? message;
  DataTransactionTopupDeposit? data;

  ResTransactionTopupDeposit({
    this.success,
    this.message,
    this.data,
  });

  factory ResTransactionTopupDeposit.fromJson(Map<String, dynamic> json) =>
      ResTransactionTopupDeposit(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : DataTransactionTopupDeposit.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class DataTransactionTopupDeposit {
  int? id;
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
  String? snapToken;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  dynamic item;
  dynamic customer;
  dynamic source;

  DataTransactionTopupDeposit({
    this.id,
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
    this.item,
    this.customer,
    this.source,
  });

  factory DataTransactionTopupDeposit.fromJson(Map<String, dynamic> json) =>
      DataTransactionTopupDeposit(
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
        item: json["item"],
        customer: json["customer"],
        source: json["source"],
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
        "item": item,
        "customer": customer,
        "source": source,
      };
}
