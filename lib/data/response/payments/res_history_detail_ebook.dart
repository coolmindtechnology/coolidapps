// To parse this JSON data, do
//
//     final resDetailHistoryEbook = resDetailHistoryEbookFromJson(jsonString);

import 'dart:convert';

ResDetailHistoryEbook resDetailHistoryEbookFromJson(String str) =>
    ResDetailHistoryEbook.fromJson(json.decode(str));

String resDetailHistoryEbookToJson(ResDetailHistoryEbook data) =>
    json.encode(data.toJson());

class ResDetailHistoryEbook {
  bool? success;
  String? message;
  DataDetailHistoryEbook? data;

  ResDetailHistoryEbook({
    this.success,
    this.message,
    this.data,
  });

  factory ResDetailHistoryEbook.fromJson(Map<String, dynamic> json) =>
      ResDetailHistoryEbook(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : DataDetailHistoryEbook.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class DataDetailHistoryEbook {
  String? id;
  String? orderId;
  String? idLogs;
  String? idItemPayments;
  String? idUser;
  String? amount;
  String? discount;
  String? totalAmount;
  String? transactionType;
  String? paymentType;
  String? status;
  String? snapToken;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? title;
  String? summary;
  String? image;
  String? imagePath;
  String? content;
  String? file;
  String? filePath;
  String? price;
  String? isPremium;

  DataDetailHistoryEbook({
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
    this.title,
    this.summary,
    this.image,
    this.imagePath,
    this.content,
    this.file,
    this.filePath,
    this.price,
    this.isPremium,
  });

  factory DataDetailHistoryEbook.fromJson(Map<String, dynamic> json) =>
      DataDetailHistoryEbook(
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
        title: json["title"],
        summary: json["summary"],
        image: json["image"],
        imagePath: json["image_path"],
        content: json["content"],
        file: json["file"],
        filePath: json["file_path"],
        price: json["price"],
        isPremium: json["is_premium"],
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
        "title": title,
        "summary": summary,
        "image": image,
        "image_path": imagePath,
        "content": content,
        "file": file,
        "file_path": filePath,
        "price": price,
        "is_premium": isPremium,
      };
}
