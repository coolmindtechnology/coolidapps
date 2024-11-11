// To parse this JSON data, do
//
//     final resHistoryEbook = resHistoryEbookFromJson(jsonString);

import 'dart:convert';

ResHistoryEbook resHistoryEbookFromJson(String str) =>
    ResHistoryEbook.fromJson(json.decode(str));

String resHistoryEbookToJson(ResHistoryEbook data) =>
    json.encode(data.toJson());

class ResHistoryEbook {
  bool? success;
  String? message;
  List<DataHistoryEbook>? data;

  ResHistoryEbook({
    this.success,
    this.message,
    this.data,
  });

  factory ResHistoryEbook.fromJson(Map<String, dynamic> json) =>
      ResHistoryEbook(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<DataHistoryEbook>.from(
                json["data"]!.map((x) => DataHistoryEbook.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class DataHistoryEbook {
  int? id;
  dynamic orderId;
  dynamic idLogs;
  dynamic idItemPayments;
  dynamic idUser;
  dynamic amount;
  dynamic discount;
  dynamic totalAmount;
  String? transactionType;
  String? paymentType;
  dynamic status;
  String? snapToken;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  Log? log;

  DataHistoryEbook({
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
    this.log,
  });

  factory DataHistoryEbook.fromJson(Map<String, dynamic> json) =>
      DataHistoryEbook(
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
        log: json["log"] == null ? null : Log.fromJson(json["log"]),
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
        "log": log?.toJson(),
      };
}

class Log {
  int? id;
  dynamic idEbook;
  dynamic idUser;
  dynamic status;
  dynamic ebook;

  Log({
    this.id,
    this.idEbook,
    this.idUser,
    this.status,
    this.ebook,
  });

  factory Log.fromJson(Map<String, dynamic> json) => Log(
        id: json["id"],
        idEbook: json["id_ebook"],
        idUser: json["id_user"],
        status: json["status"],
        ebook: json["ebook"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_ebook": idEbook,
        "id_user": idUser,
        "status": status,
        "ebook": ebook,
      };
}
