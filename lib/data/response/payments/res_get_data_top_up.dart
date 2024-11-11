// To parse this JSON data, do
//
//     final resGetDataTopUp = resGetDataTopUpFromJson(jsonString);

import 'dart:convert';

ResGetDataTopUp resGetDataTopUpFromJson(String str) =>
    ResGetDataTopUp.fromJson(json.decode(str));

String resGetDataTopUpToJson(ResGetDataTopUp data) =>
    json.encode(data.toJson());

class ResGetDataTopUp {
  bool? success;
  String? message;
  List<DataListTopUp>? data;

  ResGetDataTopUp({
    this.success,
    this.message,
    this.data,
  });

  factory ResGetDataTopUp.fromJson(Map<String, dynamic> json) =>
      ResGetDataTopUp(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<DataListTopUp>.from(
                json["data"]!.map((x) => DataListTopUp.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class DataListTopUp {
  int? id;
  dynamic idItemPayments;
  String? name;
  dynamic qty;
  dynamic discount;
  dynamic price;
  dynamic status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  DataListTopUp({
    this.id,
    this.idItemPayments,
    this.name,
    this.qty,
    this.discount,
    this.price,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory DataListTopUp.fromJson(Map<String, dynamic> json) => DataListTopUp(
        id: json["id"],
        idItemPayments: json["id_item_payments"],
        name: json["name"],
        qty: json["qty"],
        discount: json["discount"],
        price: json["price"],
        status: json["status"],
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
        "id_item_payments": idItemPayments,
        "name": name,
        "qty": qty,
        "discount": discount,
        "price": price,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
      };
}
