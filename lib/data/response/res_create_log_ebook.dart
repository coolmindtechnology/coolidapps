// To parse this JSON data, do
//
//     final resCreateLogEbook = resCreateLogEbookFromJson(jsonString);

import 'dart:convert';

ResCreateLogEbook resCreateLogEbookFromJson(String str) => ResCreateLogEbook.fromJson(json.decode(str));

String resCreateLogEbookToJson(ResCreateLogEbook data) => json.encode(data.toJson());

class ResCreateLogEbook {
  bool? success;
  String? message;
  String? data;

  ResCreateLogEbook({
    this.success,
    this.message,
    this.data,
  });

  factory ResCreateLogEbook.fromJson(Map<String, dynamic> json) => ResCreateLogEbook(
    success: json["success"],
    message: json["message"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data,
  };
}
