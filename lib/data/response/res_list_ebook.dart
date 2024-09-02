// To parse this JSON data, do
//
//     final resListEbook = resListEbookFromJson(jsonString);

import 'dart:convert';

ResListEbook resListEbookFromJson(String str) =>
    ResListEbook.fromJson(json.decode(str));

String resListEbookToJson(ResListEbook data) => json.encode(data.toJson());

class ResListEbook {
  List<DataBook>? data;

  ResListEbook({
    this.data,
  });

  factory ResListEbook.fromJson(Map<String, dynamic> json) => ResListEbook(
        data: json["data"] == null
            ? []
            : List<DataBook>.from(
                json["data"]!.map((x) => DataBook.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class DataBook {
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
  LogEbook? logEbook;

  DataBook({
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
    this.logEbook,
  });

  factory DataBook.fromJson(Map<String, dynamic> json) => DataBook(
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
        logEbook: json["log_ebook"] == null
            ? null
            : LogEbook.fromJson(json["log_ebook"]),
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
        "log_ebook": logEbook?.toJson(),
      };
}

class LogEbook {
  int? id;
  String? idEbook;
  String? idUser;
  String? status;

  LogEbook({
    this.id,
    this.idEbook,
    this.idUser,
    this.status,
  });

  factory LogEbook.fromJson(Map<String, dynamic> json) => LogEbook(
        id: json["id"],
        idEbook: json["id_ebook"],
        idUser: json["id_user"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_ebook": idEbook,
        "id_user": idUser,
        "status": status,
      };
}
