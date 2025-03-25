// To parse this JSON data, do
//
//     final resGetListMeet = resGetListMeetFromJson(jsonString);

import 'dart:convert';

ResGetListMeet resGetListMeetFromJson(String str) => ResGetListMeet.fromJson(json.decode(str));

String resGetListMeetToJson(ResGetListMeet data) => json.encode(data.toJson());

class ResGetListMeet {
  bool? success;
  String? message;
  List<Datum>? data;

  ResGetListMeet({
    this.success,
    this.message,
    this.data,
  });

  factory ResGetListMeet.fromJson(Map<String, dynamic> json) => ResGetListMeet(
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
  String? description;
  String? status;
  String? time;
  String? place;
  String? host;
  String? createdAt;

  Datum({
    this.id,
    this.title,
    this.description,
    this.status,
    this.time,
    this.place,
    this.host,
    this.createdAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    status: json["status"],
    time: json["time"],
    place: json["place"],
    host: json["host"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "status": status,
    "time": time,
    "place": place,
    "host": host,
    "created_at": createdAt,
  };
}
