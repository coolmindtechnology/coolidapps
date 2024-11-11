// To parse this JSON data, do
//
//     final resHistoryBrainActivation = resHistoryBrainActivationFromJson(jsonString);

import 'dart:convert';

ResHistoryBrainActivation resHistoryBrainActivationFromJson(String str) =>
    ResHistoryBrainActivation.fromJson(json.decode(str));

String resHistoryBrainActivationToJson(ResHistoryBrainActivation data) =>
    json.encode(data.toJson());

class ResHistoryBrainActivation {
  bool? success;
  dynamic message;
  List<DataHistoryBrainActivation>? data;

  ResHistoryBrainActivation({
    this.success,
    this.message,
    this.data,
  });

  factory ResHistoryBrainActivation.fromJson(Map<String, dynamic> json) =>
      ResHistoryBrainActivation(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<DataHistoryBrainActivation>.from(json["data"]!
                .map((x) => DataHistoryBrainActivation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class DataHistoryBrainActivation {
  dynamic orderId;
  dynamic idUser;
  dynamic transactionType;
  dynamic status;
  DateTime? createdAt;
  dynamic itemPayment;

  DataHistoryBrainActivation({
    this.orderId,
    this.idUser,
    this.transactionType,
    this.status,
    this.createdAt,
    this.itemPayment,
  });

  factory DataHistoryBrainActivation.fromJson(Map<String, dynamic> json) =>
      DataHistoryBrainActivation(
        orderId: json["order_id"],
        idUser: json["id_user"],
        transactionType: json["transaction_type"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        itemPayment: json["item_payment"],
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "id_user": idUser,
        "transaction_type": transactionType,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "item_payment": itemPayment,
      };
}
