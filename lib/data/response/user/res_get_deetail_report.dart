// To parse this JSON data, do
//
//     final resGetDetailLogReport = resGetDetailLogReportFromJson(jsonString);

import 'dart:convert';

ResGetDetailLogReport resGetDetailLogReportFromJson(String str) =>
    ResGetDetailLogReport.fromJson(json.decode(str));

String resGetDetailLogReportToJson(ResGetDetailLogReport data) =>
    json.encode(data.toJson());

class ResGetDetailLogReport {
  bool? success;
  String? message;
  Data? data;

  ResGetDetailLogReport({
    this.success,
    this.message,
    this.data,
  });

  factory ResGetDetailLogReport.fromJson(Map<String, dynamic> json) =>
      ResGetDetailLogReport(
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
  int? userId;
  int? categoryId;
  String? body;
  dynamic name;
  dynamic email;
  dynamic phoneNumber;
  String? media;
  String? status;
  String? appVersion;
  DateTime? createdAt;
  DateTime? updatedAt;
  CategoryReports? categoryReports;
  DetailReport? detailReport;

  Data({
    this.id,
    this.userId,
    this.categoryId,
    this.body,
    this.name,
    this.email,
    this.phoneNumber,
    this.media,
    this.status,
    this.appVersion,
    this.createdAt,
    this.updatedAt,
    this.categoryReports,
    this.detailReport,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    userId: json["user_id"],
    categoryId: json["category_id"],
    body: json["body"],
    name: json["name"],
    email: json["email"],
    phoneNumber: json["phone_number"],
    media: json["media"],
    status: json["status"],
    appVersion: json["app_version"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    categoryReports: json["category_reports"] == null
        ? null
        : CategoryReports.fromJson(json["category_reports"]),
    detailReport: json["detail_report"] == null
        ? null
        : DetailReport.fromJson(json["detail_report"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "category_id": categoryId,
    "body": body,
    "name": name,
    "email": email,
    "phone_number": phoneNumber,
    "media": media,
    "status": status,
    "app_version": appVersion,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "category_reports": categoryReports?.toJson(),
    "detail_report": detailReport?.toJson(),
  };
}

class CategoryReports {
  int? id;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? status;

  CategoryReports({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.status,
  });

  factory CategoryReports.fromJson(Map<String, dynamic> json) =>
      CategoryReports(
        id: json["id"],
        name: json["name"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "status": status,
  };
}

class DetailReport {
  int? id;
  int? idReport;
  String? image;
  String? description;
  String? fixingStatus;
  DateTime? fixingAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  DetailReport({
    this.id,
    this.idReport,
    this.image,
    this.description,
    this.fixingStatus,
    this.fixingAt,
    this.createdAt,
    this.updatedAt,
  });

  factory DetailReport.fromJson(Map<String, dynamic> json) => DetailReport(
    id: json["id"],
    idReport: json["id_report"],
    image: json["image"],
    description: json["description"],
    fixingStatus: json["fixing_status"],
    fixingAt: json["fixing_at"] == null
        ? null
        : DateTime.tryParse(json["fixing_at"]),
    createdAt: json["created_at"] == null
        ? null
        : DateTime.tryParse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.tryParse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_report": idReport,
    "image": image,
    "description": description,
    "fixing_status": fixingStatus,
    "fixing_at": fixingAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
