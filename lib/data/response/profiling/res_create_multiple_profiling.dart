import 'dart:convert';

// Fungsi parsing dari JSON string ke model
ResCreateMultipleProfiling resCreateMultipleProfilingFromJson(String str) =>
    ResCreateMultipleProfiling.fromJson(json.decode(str));

// Fungsi konversi dari model ke JSON string
String resCreateMultipleProfilingToJson(ResCreateMultipleProfiling data) =>
    json.encode(data.toJson());

class ResCreateMultipleProfiling {
  bool? success;
  dynamic message;
  Log? log;
  List<DataCreateMultipleProfiling>? data;

  ResCreateMultipleProfiling({
    this.success,
    this.message,
    this.log,
    this.data,
  });

  factory ResCreateMultipleProfiling.fromJson(Map<String, dynamic> json) =>
      ResCreateMultipleProfiling(
        success: json["success"],
        message: json["message"],
        log: json["log"] == null ? null : Log.fromJson(json["log"]),
        data: json["data"] == null
            ? []
            : List<DataCreateMultipleProfiling>.from(
            json["data"].map((x) => DataCreateMultipleProfiling.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "log": log?.toJson(),
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class DataCreateMultipleProfiling {
  dynamic bloodType;
  dynamic idUser;
  dynamic idProfiling;
  dynamic result;
  dynamic idMultiple;
  DateTime? updatedAt;
  DateTime? createdAt;
  dynamic id;

  DataCreateMultipleProfiling({
    this.bloodType,
    this.idUser,
    this.idProfiling,
    this.result,
    this.idMultiple,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory DataCreateMultipleProfiling.fromJson(Map<String, dynamic> json) =>
      DataCreateMultipleProfiling(
        bloodType: json["blood_type"],
        idUser: json["id_user"],
        idProfiling: json["id_profiling"],
        result: json["result"],
        idMultiple: json["id_multiple"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
    "blood_type": bloodType,
    "id_user": idUser,
    "id_profiling": idProfiling,
    "result": result,
    "id_multiple": idMultiple,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "id": id,
  };
}

class Log {
  String? idLogs;
  int? discount;
  String? transactionType;
  dynamic idItemPayments;
  int? qty;
  int? price;
  String? gateway;

  Log({
    this.idLogs,
    this.discount,
    this.transactionType,
    this.idItemPayments,
    this.qty,
    this.price,
    this.gateway,
  });

  factory Log.fromJson(Map<String, dynamic> json) => Log(
    idLogs: json["id_logs"],
    discount: json["discount"],
    transactionType: json["transaction_type"],
    idItemPayments: json["id_item_payments"],
    qty: json["qty"],
    price: json["price"],
    gateway: json["gateway"],
  );

  Map<String, dynamic> toJson() => {
    "id_logs": idLogs,
    "discount": discount,
    "transaction_type": transactionType,
    "id_item_payments": idItemPayments,
    "qty": qty,
    "price": price,
    "gateway": gateway,
  };
}
