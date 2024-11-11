// To parse this JSON data, do
//
//     final resTransakasiBrainActivation = resTransakasiBrainActivationFromJson(jsonString);

import 'dart:convert';

ResTransakasiBrainActivation resTransakasiBrainActivationFromJson(String str) =>
    ResTransakasiBrainActivation.fromJson(json.decode(str));

String resTransakasiBrainActivationToJson(ResTransakasiBrainActivation data) =>
    json.encode(data.toJson());

class ResTransakasiBrainActivation {
  bool? success;
  dynamic message;
  DataTransaksiBrain? data;

  ResTransakasiBrainActivation({
    this.success,
    this.message,
    this.data,
  });

  factory ResTransakasiBrainActivation.fromJson(Map<String, dynamic> json) =>
      ResTransakasiBrainActivation(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : DataTransaksiBrain.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class DataTransaksiBrain {
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
  dynamic snapToken;
  dynamic transactionIdPaypal;
  dynamic currencyPaypal;
  dynamic amountPaypal;
  dynamic responsePaypal;
  dynamic statusPaypal;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  dynamic gateway;

  DataTransaksiBrain({
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
    this.transactionIdPaypal,
    this.currencyPaypal,
    this.amountPaypal,
    this.responsePaypal,
    this.statusPaypal,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.gateway,
  });

  factory DataTransaksiBrain.fromJson(Map<String, dynamic> json) =>
      DataTransaksiBrain(
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
        transactionIdPaypal: json["transaction_id_paypal"],
        currencyPaypal: json["currency_paypal"],
        amountPaypal: json["amount_paypal"],
        responsePaypal: json["response_paypal"],
        statusPaypal: json["status_paypal"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        gateway: json["gateway"],
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
        "transaction_id_paypal": transactionIdPaypal,
        "currency_paypal": currencyPaypal,
        "amount_paypal": amountPaypal,
        "response_paypal": responsePaypal,
        "status_paypal": statusPaypal,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "gateway": gateway,
      };
}
