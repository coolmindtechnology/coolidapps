// To parse this JSON data, do
//
//     final resGetInvoiceBrainAcitovation = resGetInvoiceBrainAcitovationFromJson(jsonString);

import 'dart:convert';

ResGetInvoiceBrainAcitovation resGetInvoiceBrainAcitovationFromJson(
        String str) =>
    ResGetInvoiceBrainAcitovation.fromJson(json.decode(str));

String resGetInvoiceBrainAcitovationToJson(
        ResGetInvoiceBrainAcitovation data) =>
    json.encode(data.toJson());

class ResGetInvoiceBrainAcitovation {
  bool? success;
  dynamic message;
  DataInvoiceBrainActivation? data;

  ResGetInvoiceBrainAcitovation({
    this.success,
    this.message,
    this.data,
  });

  factory ResGetInvoiceBrainAcitovation.fromJson(Map<String, dynamic> json) =>
      ResGetInvoiceBrainAcitovation(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : DataInvoiceBrainActivation.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class DataInvoiceBrainActivation {
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
  dynamic idBrainActivations;
  dynamic idLogProfiling;
  DateTime? expDate;
  dynamic dailyCount;
  dynamic totalAccess;
  dynamic limitAccessAudio;
  dynamic lastAccessTime;
  dynamic itemPayment;
  dynamic name;
  dynamic upload;
  dynamic price;

  DataInvoiceBrainActivation({
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
    this.idBrainActivations,
    this.idLogProfiling,
    this.expDate,
    this.dailyCount,
    this.totalAccess,
    this.limitAccessAudio,
    this.lastAccessTime,
    this.itemPayment,
    this.name,
    this.upload,
    this.price,
  });

  factory DataInvoiceBrainActivation.fromJson(Map<String, dynamic> json) =>
      DataInvoiceBrainActivation(
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
        idBrainActivations: json["id_brain_activations"],
        idLogProfiling: json["id_log_profiling"],
        expDate:
            json["exp_date"] == null ? null : DateTime.parse(json["exp_date"]),
        dailyCount: json["daily_count"],
        totalAccess: json["total_access"],
        limitAccessAudio: json["limit_access_audio"],
        lastAccessTime: json["last_access_time"],
        itemPayment: json["item_payment"],
        name: json["name"],
        upload: json["upload"],
        price: json["price"],
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
        "id_brain_activations": idBrainActivations,
        "id_log_profiling": idLogProfiling,
        "exp_date": expDate?.toIso8601String(),
        "daily_count": dailyCount,
        "total_access": totalAccess,
        "limit_access_audio": limitAccessAudio,
        "last_access_time": lastAccessTime,
        "item_payment": itemPayment,
        "name": name,
        "upload": upload,
        "price": price,
      };
}
