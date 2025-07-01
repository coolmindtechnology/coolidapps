// To parse this JSON data, do
//
//     final resDetailActivity = resDetailActivityFromJson(jsonString);

import 'dart:convert';

ResDetailActivity resDetailActivityFromJson(String str) => ResDetailActivity.fromJson(json.decode(str));

String resDetailActivityToJson(ResDetailActivity data) => json.encode(data.toJson());

class ResDetailActivity {
  bool? success;
  String? message;
  Data? data;

  ResDetailActivity({
    this.success,
    this.message,
    this.data,
  });

  factory ResDetailActivity.fromJson(Map<String, dynamic> json) => ResDetailActivity(
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
  String? id;
  String? profilingName;
  int? point;
  String? activityName;
  String? price;

  Data({
    this.id,
    this.profilingName,
    this.point,
    this.activityName,
    this.price,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    profilingName: json["profiling_name"],
    point: json["point"],
    activityName: json["activity_name"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "profiling_name": profilingName,
    "point": point,
    "activity_name": activityName,
    "price": price,
  };
}
