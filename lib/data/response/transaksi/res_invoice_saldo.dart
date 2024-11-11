// To parse this JSON data, do
//
//     final resInvoiceSaldo = resInvoiceSaldoFromJson(jsonString);

import 'dart:convert';

ResInvoiceSaldo resInvoiceSaldoFromJson(String str) =>
    ResInvoiceSaldo.fromJson(json.decode(str));

String resInvoiceSaldoToJson(ResInvoiceSaldo data) =>
    json.encode(data.toJson());

class ResInvoiceSaldo {
  bool? success;
  dynamic message;
  DataInvoiceSaldo? data;

  ResInvoiceSaldo({
    this.success,
    this.message,
    this.data,
  });

  factory ResInvoiceSaldo.fromJson(Map<String, dynamic> json) =>
      ResInvoiceSaldo(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : DataInvoiceSaldo.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class DataInvoiceSaldo {
  dynamic customer;
  DateTime? transactionDate;
  dynamic status;
  dynamic orderId;
  dynamic amount;
  dynamic source;
  dynamic transactionType;
  dynamic paymentType;

  DataInvoiceSaldo({
    this.customer,
    this.transactionDate,
    this.status,
    this.orderId,
    this.amount,
    this.source,
    this.transactionType,
    this.paymentType,
  });

  factory DataInvoiceSaldo.fromJson(Map<String, dynamic> json) =>
      DataInvoiceSaldo(
        customer: json["customer"],
        transactionDate: json["transaction_date"] == null
            ? null
            : DateTime.parse(json["transaction_date"]),
        status: json["status"],
        orderId: json["order_id"],
        amount: json["amount"],
        source: json["source"],
        transactionType: json["transaction_type"],
        paymentType: json["payment_type"],
      );

  Map<String, dynamic> toJson() => {
        "customer": customer,
        "transaction_date": transactionDate?.toIso8601String(),
        "status": status,
        "order_id": orderId,
        "amount": amount,
        "source": source,
        "transaction_type": transactionType,
        "payment_type": paymentType,
      };
}
