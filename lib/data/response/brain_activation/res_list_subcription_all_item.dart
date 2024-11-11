// To parse this JSON data, do
//
//     final resListSubcriptionAllItem = resListSubcriptionAllItemFromJson(jsonString);

import 'dart:convert';

ResListSubcriptionAllItem resListSubcriptionAllItemFromJson(String str) =>
    ResListSubcriptionAllItem.fromJson(json.decode(str));

String resListSubcriptionAllItemToJson(ResListSubcriptionAllItem data) =>
    json.encode(data.toJson());

class ResListSubcriptionAllItem {
  bool? success;
  String? message;
  List<DataSubcripctionAllItem>? data;

  ResListSubcriptionAllItem({
    this.success,
    this.message,
    this.data,
  });

  factory ResListSubcriptionAllItem.fromJson(Map<String, dynamic> json) =>
      ResListSubcriptionAllItem(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<DataSubcripctionAllItem>.from(
                json["data"]!.map((x) => DataSubcripctionAllItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class DataSubcripctionAllItem {
  int? id;
  dynamic idItemPayments;
  String? name;
  String? title;
  String? discount;
  String? originalPrice;
  String? discountPrice;
  dynamic originalIntlPrice;
  dynamic discountIntlPrice;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  DataSubcripctionAllItem({
    this.id,
    this.idItemPayments,
    this.name,
    this.title,
    this.discount,
    this.originalPrice,
    this.discountPrice,
    this.originalIntlPrice,
    this.discountIntlPrice,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory DataSubcripctionAllItem.fromJson(Map<String, dynamic> json) =>
      DataSubcripctionAllItem(
        id: json["id"],
        idItemPayments: json["id_item_payments"],
        name: json["name"],
        title: json["title"],
        discount: json["discount"],
        originalPrice: json["original_price"],
        discountPrice: json["discount_price"],
        originalIntlPrice: json["original_intl_price"],
        discountIntlPrice: json["discount_intl_price"],
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
        "title": title,
        "discount": discount,
        "original_price": originalPrice,
        "discount_price": discountPrice,
        "original_intl_price": originalIntlPrice,
        "discount_intl_price": discountIntlPrice,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
      };
}
