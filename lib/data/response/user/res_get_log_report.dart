import 'dart:convert';

ResGetLogReport resGetLogReportFromJson(String str) =>
    ResGetLogReport.fromJson(json.decode(str));

String resGetLogReportToJson(ResGetLogReport data) =>
    json.encode(data.toJson());

class ResGetLogReport {
  bool? success;
  String? message;
  List<Datum>? data;

  ResGetLogReport({
    this.success,
    this.message,
    this.data,
  });

  factory ResGetLogReport.fromJson(Map<String, dynamic> json) =>
      ResGetLogReport(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.map((x) => x.toJson()).toList(),
  };
}

class Datum {
  int? id;
  int? userId;
  int? categoryId;
  String? body;
  String? name;
  String? email;
  String? phoneNumber;
  String? media;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? appVersion;
  CategoryReports? categoryReports;

  Datum({
    this.id,
    this.userId,
    this.categoryId,
    this.body,
    this.name,
    this.email,
    this.phoneNumber,
    this.media,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.appVersion,
    this.categoryReports,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    userId: json["user_id"],
    categoryId: json["category_id"],
    body: json["body"],
    name: json["name"],
    email: json["email"],
    phoneNumber: json["phone_number"],
    media: json["media"],
    status: json["status"],
    createdAt: json["created_at"] != null
        ? DateTime.parse(json["created_at"])
        : null,
    updatedAt: json["updated_at"] != null
        ? DateTime.parse(json["updated_at"])
        : null,
    appVersion: json["app_version"],
    categoryReports: json["category_reports"] != null
        ? CategoryReports.fromJson(json["category_reports"])
        : null,
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
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "app_version": appVersion,
    "category_reports": categoryReports?.toJson(),
  };
}

class CategoryReports {
  int? id;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic? status;

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
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : null,
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : null,
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
