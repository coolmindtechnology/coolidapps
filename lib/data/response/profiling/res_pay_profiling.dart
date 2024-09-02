// To parse this JSON data, do
//
//     final resPayProfiling = resPayProfilingFromJson(jsonString);

import 'dart:convert';

ResPayProfiling resPayProfilingFromJson(String str) => ResPayProfiling.fromJson(json.decode(str));

String resPayProfilingToJson(ResPayProfiling data) => json.encode(data.toJson());

class ResPayProfiling {
  bool? success;
  String? message;
  Data? data;

  ResPayProfiling({
    this.success,
    this.message,
    this.data,
  });

  factory ResPayProfiling.fromJson(Map<String, dynamic> json) => ResPayProfiling(
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
  int? id;
  String? orderId;
  String? idLogs;
  String? idItemPayments;
  String? idUser;
  String? amount;
  String? discount;
  String? totalAmount;
  String? transactionType;
  dynamic paymentType;
  String? status;
  dynamic snapToken;
  dynamic transactionIdPaypal;
  String? currencyPaypal;
  String? amountPaypal;
  dynamic responsePaypal;
  String? statusPaypal;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  int? qty;
  String? gateway;
  List<ItemDetail>? itemDetails;

  Data({
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
    this.qty,
    this.gateway,
    this.itemDetails,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    qty: json["qty"],
    gateway: json["gateway"],
    itemDetails: json["item_details"] == null ? [] : List<ItemDetail>.from(json["item_details"]!.map((x) => ItemDetail.fromJson(x))),
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
    "qty": qty,
    "gateway": gateway,
    "item_details": itemDetails == null ? [] : List<dynamic>.from(itemDetails!.map((x) => x.toJson())),
  };
}

class ItemDetail {
  String? logId;
  String? profilingId;
  String? profilingName;
  String? userId;
  String? userName;
  String? status;
  String? bloodType;

  ItemDetail({
    this.logId,
    this.profilingId,
    this.profilingName,
    this.userId,
    this.userName,
    this.status,
    this.bloodType,
  });

  factory ItemDetail.fromJson(Map<String, dynamic> json) => ItemDetail(
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
