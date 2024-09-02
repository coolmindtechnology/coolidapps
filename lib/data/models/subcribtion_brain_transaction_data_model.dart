// To parse this JSON data, do
//
//     final subscribeBrainTransactionDataModel = subscribeBrainTransactionDataModelFromJson(jsonString);

import 'dart:convert';

SubscribeBrainTransactionDataModel subscribeBrainTransactionDataModelFromJson(
        String str) =>
    SubscribeBrainTransactionDataModel.fromJson(json.decode(str));

String subscribeBrainTransactionDataModelToJson(
        SubscribeBrainTransactionDataModel data) =>
    json.encode(data.toJson());

class SubscribeBrainTransactionDataModel {
  List<int>? idBrainActivations;
  int? idLogProfiling;
  int? discount;
  String? transactionType;
  String? subscriptionType;
  String? idItemPayments;
  int? price;
  String? gateway;

  SubscribeBrainTransactionDataModel(
      {this.idBrainActivations,
      this.idLogProfiling,
      this.discount,
      this.transactionType,
      this.subscriptionType,
      this.idItemPayments,
      this.price,
      this.gateway});

  factory SubscribeBrainTransactionDataModel.fromJson(
          Map<String, dynamic> json) =>
      SubscribeBrainTransactionDataModel(
        idBrainActivations: json["id_brain_activations"] == null
            ? []
            : List<int>.from(json["id_brain_activations"]!.map((x) => x)),
        idLogProfiling: json["id_log_profiling"],
        discount: json["discount"],
        transactionType: json["transaction_type"],
        subscriptionType: json["subscription_type"],
        idItemPayments: json["id_item_payments"],
        price: json["price"],
        gateway: json["gateway"],
      );

  Map<String, dynamic> toJson() => {
        "id_brain_activations": idBrainActivations == null
            ? []
            : List<dynamic>.from(idBrainActivations!.map((x) => x)),
        "id_log_profiling": idLogProfiling,
        "discount": discount,
        "transaction_type": transactionType,
        "subscription_type": subscriptionType,
        "id_item_payments": idItemPayments,
        "price": price,
        "gateway": gateway,
      };
}
