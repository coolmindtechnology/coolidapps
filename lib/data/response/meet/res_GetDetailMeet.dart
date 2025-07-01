// To parse this JSON data, do
//
//     final resGetDetailMeet = resGetDetailMeetFromJson(jsonString);

import 'dart:convert';

ResGetDetailMeet resGetDetailMeetFromJson(String str) => ResGetDetailMeet.fromJson(json.decode(str));

String resGetDetailMeetToJson(ResGetDetailMeet data) => json.encode(data.toJson());

class ResGetDetailMeet {
  bool? success;
  String? message;
  Data? data;

  ResGetDetailMeet({
    this.success,
    this.message,
    this.data,
  });

  factory ResGetDetailMeet.fromJson(Map<String, dynamic> json) => ResGetDetailMeet(
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
  int? id;
  String? title;
  String? media;
  String? status;
  String? description;
  String? time;
  String? roomId;
  String? place;
  String? createdAt;

  Data({
    this.id,
    this.title,
    this.media,
    this.status,
    this.description,
    this.time,
    this.roomId,
    this.place,
    this.createdAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    title: json["title"],
    media: json["media"],
    status: json["status"],
    description: json["description"],
    time: json["time"],
    roomId: json["room_id"],
    place: json["place"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "media": media,
    "status": status,
    "description": description,
    "time": time,
    "room_id": roomId,
    "place": place,
    "created_at": createdAt,
  };
}
