import 'dart:convert';

// Fungsi untuk parsing JSON ke objek
ResGetMassage resGetMassageFromJson(String str) =>
    ResGetMassage.fromJson(json.decode(str));

// Fungsi untuk konversi objek ke JSON String
String resGetMassageToJson(ResGetMassage data) =>
    json.encode(data.toJson());

// Model utama
class ResGetMassage {
  bool? success;
  String? message;
  Data? data;

  ResGetMassage({
    this.success,
    this.message,
    this.data,
  });

  factory ResGetMassage.fromJson(Map<String, dynamic> json) => ResGetMassage(
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
  dynamic? idLog;
  String? subject;
  String? message;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Data({
    this.id,
    this.idLog,
    this.subject,
    this.message,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    idLog: json["id_log"],
    subject: json["subject"],
    message: json["message"],
    status: json["status"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.tryParse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.tryParse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_log": idLog,
    "subject": subject,
    "message": message,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
