// To parse this JSON data, do
//
//     final resGetComissen = resGetComissenFromJson(jsonString);

import 'dart:convert';

ResGetComissen resGetComissenFromJson(String str) => ResGetComissen.fromJson(json.decode(str));

String resGetComissenToJson(ResGetComissen data) => json.encode(data.toJson());

class ResGetComissen {
  bool? success;
  String? message;
  Data? data;

  ResGetComissen({
    this.success,
    this.message,
    this.data,
  });

  factory ResGetComissen.fromJson(Map<String, dynamic> json) => ResGetComissen(
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
  int? totalComission;
  String? type;
  List<Result>? result;

  Data({
    this.totalComission,
    this.type,
    this.result,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    totalComission: json["total_comission"],
    type: json["type"],
    result: json["result"] == null ? [] : List<Result>.from(json["result"]!.map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total_comission": totalComission,
    "type": type,
    "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class Result {
  int? id;
  String? amount;
  String? type;
  String? time;
  DateTime? date;

  Result({
    this.id,
    this.amount,
    this.type,
    this.time,
    this.date,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    amount: json["amount"],
    type: json["type"],
    time: json["time"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "amount": amount,
    "type": type,
    "time": time,
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
  };
}
