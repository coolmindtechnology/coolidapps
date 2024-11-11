// To parse this JSON data, do
//
//     final resSearchContent = resSearchContentFromJson(jsonString);

import 'dart:convert';

import 'package:coolappflutter/data/models/data_post.dart';

ResSearchContent resSearchContentFromJson(String str) =>
    ResSearchContent.fromJson(json.decode(str));

String resSearchContentToJson(ResSearchContent data) =>
    json.encode(data.toJson());

class ResSearchContent {
  Data? data;

  ResSearchContent({
    this.data,
  });

  factory ResSearchContent.fromJson(Map<String, dynamic> json) =>
      ResSearchContent(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  Posts? posts;
  Profiling? profiling;

  Data({
    this.posts,
    this.profiling,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        posts: json["posts"] == null ? null : Posts.fromJson(json["posts"]),
        profiling: json["profiling"] == null
            ? null
            : Profiling.fromJson(json["profiling"]),
      );

  Map<String, dynamic> toJson() => {
        "posts": posts?.toJson(),
        "profiling": profiling?.toJson(),
      };
}

class Posts {
  dynamic currentPage;
  List<DataPost>? data;
  dynamic firstPageUrl;
  dynamic from;
  dynamic lastPage;
  dynamic lastPageUrl;
  List<Link>? links;
  dynamic nextPageUrl;
  dynamic path;
  dynamic perPage;
  dynamic prevPageUrl;
  dynamic to;
  dynamic total;

  Posts({
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

  factory Posts.fromJson(Map<String, dynamic> json) => Posts(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<DataPost>.from(
                json["data"]!.map((x) => DataPost.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] == null
            ? []
            : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": links == null
            ? []
            : List<dynamic>.from(links!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class Link {
  dynamic url;
  dynamic label;
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

class Profiling {
  dynamic currentPage;
  List<ProfilingDatum>? data;
  dynamic firstPageUrl;
  dynamic from;
  dynamic lastPage;
  dynamic lastPageUrl;
  List<Link>? links;
  dynamic nextPageUrl;
  dynamic path;
  dynamic perPage;
  dynamic prevPageUrl;
  dynamic to;
  dynamic total;

  Profiling({
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

  factory Profiling.fromJson(Map<String, dynamic> json) => Profiling(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<ProfilingDatum>.from(
                json["data"]!.map((x) => ProfilingDatum.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] == null
            ? []
            : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": links == null
            ? []
            : List<dynamic>.from(links!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class ProfilingDatum {
  dynamic id;
  dynamic idUser;
  dynamic idProfiling;
  dynamic result;
  dynamic bloodType;
  dynamic idDeposit;
  dynamic idMultiple;
  dynamic status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  DataProfile? dataProfile;
  ResultName? resultName;

  ProfilingDatum({
    this.id,
    this.idUser,
    this.idProfiling,
    this.result,
    this.bloodType,
    this.idDeposit,
    this.idMultiple,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.dataProfile,
    this.resultName,
  });

  factory ProfilingDatum.fromJson(Map<String, dynamic> json) => ProfilingDatum(
        id: json["id"],
        idUser: json["id_user"],
        idProfiling: json["id_profiling"],
        result: json["result"],
        bloodType: json["blood_type"],
        idDeposit: json["id_deposit"],
        idMultiple: json["id_multiple"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        dataProfile: json["data_profile"] == null
            ? null
            : DataProfile.fromJson(json["data_profile"]),
        resultName: json["result_name"] == null
            ? null
            : ResultName.fromJson(json["result_name"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_user": idUser,
        "id_profiling": idProfiling,
        "result": result,
        "blood_type": bloodType,
        "id_deposit": idDeposit,
        "id_multiple": idMultiple,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "data_profile": dataProfile?.toJson(),
        "result_name": resultName?.toJson(),
      };
}

class DataProfile {
  dynamic idUser;
  dynamic name;
  dynamic birthDate;
  dynamic monthDate;
  dynamic yearDate;
  dynamic bloodType;
  dynamic domicile;
  dynamic deletedAt;

  DataProfile({
    this.idUser,
    this.name,
    this.birthDate,
    this.monthDate,
    this.yearDate,
    this.bloodType,
    this.domicile,
    this.deletedAt,
  });

  factory DataProfile.fromJson(Map<String, dynamic> json) => DataProfile(
        idUser: json["id_user"],
        name: json["name"],
        birthDate: json["birth_date"],
        monthDate: json["month_date"],
        yearDate: json["year_date"],
        bloodType: json["blood_type"],
        domicile: json["domicile"],
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id_user": idUser,
        "name": name,
        "birth_date": birthDate,
        "month_date": monthDate,
        "year_date": yearDate,
        "blood_type": bloodType,
        "domicile": domicile,
        "deleted_at": deletedAt,
      };
}

class ResultName {
  dynamic id;
  dynamic name;
  dynamic createdAt;
  dynamic updatedAt;

  ResultName({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory ResultName.fromJson(Map<String, dynamic> json) => ResultName(
        id: json["id"],
        name: json["name"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
