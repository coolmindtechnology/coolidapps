// To parse this JSON data, do
//
//     final resShowPriceBrainSubcribe = resShowPriceBrainSubcribeFromJson(jsonString);

import 'dart:convert';

ResShowPriceBrainSubcribe resShowPriceBrainSubcribeFromJson(String str) =>
    ResShowPriceBrainSubcribe.fromJson(json.decode(str));

String resShowPriceBrainSubcribeToJson(ResShowPriceBrainSubcribe data) =>
    json.encode(data.toJson());

class ResShowPriceBrainSubcribe {
  bool? success;
  String? message;
  DataShowPrice? data;

  ResShowPriceBrainSubcribe({
    this.success,
    this.message,
    this.data,
  });

  factory ResShowPriceBrainSubcribe.fromJson(Map<String, dynamic> json) =>
      ResShowPriceBrainSubcribe(
        success: json["success"],
        message: json["message"],
        data:
            json["data"] == null ? null : DataShowPrice.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class DataShowPrice {
  String? subscribePrice;
  String? transactionType;
  String? subscribeType;

  DataShowPrice({
    this.subscribePrice,
    this.transactionType,
    this.subscribeType,
  });

  factory DataShowPrice.fromJson(Map<String, dynamic> json) => DataShowPrice(
        subscribePrice: json["subscribe_price"],
        transactionType: json["transaction_type"],
        subscribeType: json["subscribe_type"],
      );

  Map<String, dynamic> toJson() => {
        "subscribe_price": subscribePrice,
        "transaction_type": transactionType,
        "subscribe_type": subscribeType,
      };
}
