// To parse this JSON data, do
//
//     final rescreateWithdraw = rescreateWithdrawFromJson(jsonString);

import 'dart:convert';

ResCreateWithdraw rescreateWithdrawFromJson(String str) =>
    ResCreateWithdraw.fromJson(json.decode(str));

String rescreateWithdrawToJson(ResCreateWithdraw data) =>
    json.encode(data.toJson());

class ResCreateWithdraw {
  bool? success;
  dynamic message;
  Data? data;

  ResCreateWithdraw({
    this.success,
    this.message,
    this.data,
  });

  factory ResCreateWithdraw.fromJson(Map<String, dynamic> json) =>
      ResCreateWithdraw(
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
  dynamic idUser;
  dynamic idAffiliate;
  dynamic idSaldoAffiliate;
  dynamic amount;
  dynamic transactionType;
  dynamic status;
  dynamic referenceNo;
  DateTime? updatedAt;
  DateTime? createdAt;
  dynamic id;

  Data({
    this.idUser,
    this.idAffiliate,
    this.idSaldoAffiliate,
    this.amount,
    this.transactionType,
    this.status,
    this.referenceNo,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        idUser: json["id_user"],
        idAffiliate: json["id_affiliate"],
        idSaldoAffiliate: json["id_saldo_affiliate"],
        amount: json["amount"],
        transactionType: json["transaction_type"],
        status: json["status"],
        referenceNo: json["reference_no"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id_user": idUser,
        "id_affiliate": idAffiliate,
        "id_saldo_affiliate": idSaldoAffiliate,
        "amount": amount,
        "transaction_type": transactionType,
        "status": status,
        "reference_no": referenceNo,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
      };
}
