// To parse this JSON data, do
//
//     final dataCheckoutTransaction = dataCheckoutTransactionFromJson(jsonString);

import 'dart:convert';

import 'package:decimal/decimal.dart';

DataCheckoutTransaction dataCheckoutTransactionFromJson(String str) =>
    DataCheckoutTransaction.fromJson(json.decode(str));

String dataCheckoutTransactionToJson(DataCheckoutTransaction data) =>
    json.encode(data.toJson());

class DataCheckoutTransaction {
  List<int>? idLogs;
  String? discount;
  String? transactionType;
  String? idItemPayments;
  int? qty;
  Decimal? price;
  int? idUser;
  String? idEbook;
  String? gateway;

  DataCheckoutTransaction({
    this.idLogs,
    this.discount,
    this.transactionType,
    this.idItemPayments,
    this.qty,
    this.price,
    this.idUser,
    this.idEbook,
    this.gateway,
  });

  factory DataCheckoutTransaction.fromJson(Map<String, dynamic> json) =>
      DataCheckoutTransaction(
        idLogs: json["id_logs"] == null
            ? []
            : List<int>.from(json["id_logs"]!.map((x) => x)),
        discount: json["discount"],
        transactionType: json["transaction_type"],
        idItemPayments: json["id_item_payments"],
        qty: json["qty"],
        price: json["price"],
        idUser: json["id_user"],
        idEbook: json["id_ebook"],
        gateway: json["gateway"],
      );

  Map<String, dynamic> toJson() => {
        "id_logs":
            idLogs == null ? [] : List<dynamic>.from(idLogs!.map((x) => x)),
        "discount": discount,
        "transaction_type": transactionType,
        "id_item_payments": idItemPayments,
        "qty": qty,
        "price": price,
        "id_user": idUser,
        "id_ebook": idEbook,
        "gateway": gateway
      };
}
