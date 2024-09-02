// To parse this JSON data, do
//
//     final resGetListComment = resGetListCommentFromJson(jsonString);

import 'dart:convert';

ResGetListComment resGetListCommentFromJson(String str) => ResGetListComment.fromJson(json.decode(str));

String resGetListCommentToJson(ResGetListComment data) => json.encode(data.toJson());

class ResGetListComment {
  bool? success;
  String? message;
  Data? data;

  ResGetListComment({
    this.success,
    this.message,
    this.data,
  });

  factory ResGetListComment.fromJson(Map<String, dynamic> json) => ResGetListComment(
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
  int? currentPage;
  List<DataListComment>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  Data({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    currentPage: json["current_page"],
    data: json["data"] == null ? [] : List<DataListComment>.from(json["data"]!.map((x) => DataListComment.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toJson())),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class DataListComment {
  int? id;
  String? idPost;
  String? idUser;
  String? comment;
  String? isAnonim;
  DateTime? createdAt;
  DateTime? updatedAt;

  DataListComment({
    this.id,
    this.idPost,
    this.idUser,
    this.comment,
    this.isAnonim,
    this.createdAt,
    this.updatedAt,
  });

  factory DataListComment.fromJson(Map<String, dynamic> json) => DataListComment(
    id: json["id"],
    idPost: json["id_post"],
    idUser: json["id_user"],
    comment: json["comment"],
    isAnonim: json["is_anonim"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_post": idPost,
    "id_user": idUser,
    "comment": comment,
    "is_anonim": isAnonim,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class Link {
  String? url;
  String? label;
  bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}
