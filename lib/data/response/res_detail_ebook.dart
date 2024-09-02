// To parse this JSON data, do
//
//     final resDetailEbook = resDetailEbookFromJson(jsonString);

import 'dart:convert';

ResDetailEbook resDetailEbookFromJson(String str) => ResDetailEbook.fromJson(json.decode(str));

String resDetailEbookToJson(ResDetailEbook data) => json.encode(data.toJson());

class ResDetailEbook {
  Data? data;

  ResDetailEbook({
    this.data,
  });

  factory ResDetailEbook.fromJson(Map<String, dynamic> json) => ResDetailEbook(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class Data {
  int? id;
  String? title;
  String? summary;
  String? image;
  String? imagePath;
  String? content;
  String? file;
  String? filePath;
  String? price;
  String? isPremium;
  String? status;

  Data({
    this.id,
    this.title,
    this.summary,
    this.image,
    this.imagePath,
    this.content,
    this.file,
    this.filePath,
    this.price,
    this.isPremium,
    this.status,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    title: json["title"],
    summary: json["summary"],
    image: json["image"],
    imagePath: json["image_path"],
    content: json["content"],
    file: json["file"],
    filePath: json["file_path"],
    price: json["price"],
    isPremium: json["is_premium"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "summary": summary,
    "image": image,
    "image_path": imagePath,
    "content": content,
    "file": file,
    "file_path": filePath,
    "price": price,
    "is_premium": isPremium,
    "status": status,
  };
}
