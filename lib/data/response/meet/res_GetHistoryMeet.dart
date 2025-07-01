// To parse this JSON data, do
//
//     final resGetHistoryMeet = resGetHistoryMeetFromJson(jsonString);

import 'dart:convert';

ResGetHistoryMeet resGetHistoryMeetFromJson(String str) => ResGetHistoryMeet.fromJson(json.decode(str));

String resGetHistoryMeetToJson(ResGetHistoryMeet data) => json.encode(data.toJson());

class ResGetHistoryMeet {
  bool? success;
  String? message;
  List<Datum>? data;

  ResGetHistoryMeet({
    this.success,
    this.message,
    this.data,
  });

  factory ResGetHistoryMeet.fromJson(Map<String, dynamic> json) => ResGetHistoryMeet(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  int? id;
  String? title;
  String? category;
  String? createdAt;
  String? time;
  DateTime? dateMeet;

  Datum({
    this.id,
    this.title,
    this.category,
    this.createdAt,
    this.time,
    this.dateMeet,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    title: json["title"],
    category: json["category"],
    createdAt: json["created_at"],
    time: json["time"],
    dateMeet: json["date_meet"] == null ? null : DateTime.parse(json["date_meet"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "category": category,
    "created_at": createdAt,
    "time": time,
    "date_meet": "${dateMeet!.year.toString().padLeft(4, '0')}-${dateMeet!.month.toString().padLeft(2, '0')}-${dateMeet!.day.toString().padLeft(2, '0')}",
  };
}
