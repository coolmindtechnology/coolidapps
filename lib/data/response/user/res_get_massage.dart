import 'dart:convert';

// Fungsi untuk parsing JSON ke objek
ResGetMassageReport resGetMassageReportFromJson(String str) =>
    ResGetMassageReport.fromJson(json.decode(str));

// Fungsi untuk konversi objek ke JSON String
String resGetMassageReportToJson(ResGetMassageReport data) =>
    json.encode(data.toJson());

// Model utama
class ResGetMassageReport {
  bool? success;
  String? message;
  Data? data;

  ResGetMassageReport({
    this.success,
    this.message,
    this.data,
  });

  factory ResGetMassageReport.fromJson(Map<String, dynamic> json) =>
      ResGetMassageReport(
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
  String? idLog;
  String? subject;
  String? status;
  List<Message>? messages;

  Data({
    this.idLog,
    this.subject,
    this.status,
    this.messages,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    idLog: json["id_log"],
    subject: json["subject"],
    status: json["status"],
    messages: json["messages"] == null
        ? []
        : List<Message>.from(
        json["messages"].map((x) => Message.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id_log": idLog,
    "subject": subject,
    "status": status,
    "messages": messages?.map((x) => x.toJson()).toList(),
  };
}

class Message {
  String? id;
  int? senderId;
  String? receiverId;
  DateTime? timestamp;
  String? text;
  String? status;
  dynamic image;

  Message({
    this.id,
    this.senderId,
    this.receiverId,
    this.timestamp,
    this.text,
    this.status,
    this.image,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    id: json["id"],
    senderId: json["sender_id"],
    receiverId: json["receiver_id"],
    timestamp: json["timestamp"] == null
        ? null
        : DateTime.tryParse(json["timestamp"]),
    text: json["text"],
    status: json["status"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sender_id": senderId,
    "receiver_id": receiverId,
    "timestamp": timestamp?.toIso8601String(),
    "text": text,
    "status": status,
    "image": image,
  };
}
