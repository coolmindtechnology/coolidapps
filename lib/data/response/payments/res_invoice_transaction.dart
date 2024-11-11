// To parse this JSON data, do
//
//     final resInvoiceTransaction = resInvoiceTransactionFromJson(jsonString);

import 'dart:convert';

ResInvoiceTransaction resInvoiceTransactionFromJson(String str) =>
    ResInvoiceTransaction.fromJson(json.decode(str));

String resInvoiceTransactionToJson(ResInvoiceTransaction data) =>
    json.encode(data.toJson());

class ResInvoiceTransaction {
  bool? success;
  dynamic message;
  DataInvoiceTransaction? data;

  ResInvoiceTransaction({
    this.success,
    this.message,
    this.data,
  });

  factory ResInvoiceTransaction.fromJson(Map<String, dynamic> json) =>
      ResInvoiceTransaction(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : DataInvoiceTransaction.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class DataInvoiceTransaction {
  dynamic orderId;
  dynamic customer;
  DateTime? transactionDate;
  dynamic paymentType;
  dynamic status;
  dynamic idLogs;
  dynamic idItemPayments;
  dynamic discount;
  dynamic totalAmount;
  List<ItemDetail>? itemDetails;

  DataInvoiceTransaction({
    this.orderId,
    this.customer,
    this.transactionDate,
    this.paymentType,
    this.status,
    this.idLogs,
    this.idItemPayments,
    this.discount,
    this.totalAmount,
    this.itemDetails,
  });

  factory DataInvoiceTransaction.fromJson(Map<String, dynamic> json) =>
      DataInvoiceTransaction(
        orderId: json["order_id"],
        customer: json["customer"],
        transactionDate: json["transaction_date"] == null
            ? null
            : DateTime.parse(json["transaction_date"]),
        paymentType: json["payment_type"],
        status: json["status"],
        idLogs: json["id_logs"],
        idItemPayments: json["id_item_payments"],
        discount: json["discount"],
        totalAmount: json["total_amount"],
        itemDetails: json["item_details"] == null
            ? []
            : List<ItemDetail>.from(
                json["item_details"]!.map((x) => ItemDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "customer": customer,
        "transaction_date": transactionDate?.toIso8601String(),
        "payment_type": paymentType,
        "status": status,
        "id_logs": idLogs,
        "id_item_payments": idItemPayments,
        "discount": discount,
        "total_amount": totalAmount,
        "item_details": itemDetails == null
            ? []
            : List<dynamic>.from(itemDetails!.map((x) => x.toJson())),
      };
}

class ItemDetail {
  dynamic id;
  dynamic idUser;
  dynamic amount;
  dynamic statusPayment;
  dynamic quantity;
  DateTime? createdAt;
  DateTime? updatedAt;

  ItemDetail({
    this.id,
    this.idUser,
    this.amount,
    this.statusPayment,
    this.quantity,
    this.createdAt,
    this.updatedAt,
  });

  factory ItemDetail.fromJson(Map<String, dynamic> json) => ItemDetail(
        id: json["id"],
        idUser: json["id_user"],
        amount: json["amount"],
        statusPayment: json["status_payment"],
        quantity: json["quantity"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_user": idUser,
        "amount": amount,
        "status_payment": statusPayment,
        "quantity": quantity,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
