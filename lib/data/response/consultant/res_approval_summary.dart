// To parse this JSON data, do
//
//     final resApprovalConsultant = resApprovalConsultantFromJson(jsonString);

import 'dart:convert';

ResApprovalConsultant resApprovalConsultantFromJson(String str) => ResApprovalConsultant.fromJson(json.decode(str));

String resApprovalConsultantToJson(ResApprovalConsultant data) => json.encode(data.toJson());

class ResApprovalConsultant {
  bool? success;
  String? message;
  Data? data;

  ResApprovalConsultant({
    this.success,
    this.message,
    this.data,
  });

  factory ResApprovalConsultant.fromJson(Map<String, dynamic> json) => ResApprovalConsultant(
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
  List<String>? title;
  List<String>? description;
  List<String>? document;
  String? status;
  dynamic approvalNote;

  Data({
    this.id,
    this.title,
    this.description,
    this.document,
    this.status,
    this.approvalNote,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    title: json["title"] == null ? [] : List<String>.from(json["title"]!.map((x) => x)),
    description: json["description"] == null ? [] : List<String>.from(json["description"]!.map((x) => x)),
    document: json["document"] == null ? [] : List<String>.from(json["document"]!.map((x) => x)),
    status: json["status"],
    approvalNote: json["approval_note"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title == null ? [] : List<dynamic>.from(title!.map((x) => x)),
    "description": description == null ? [] : List<dynamic>.from(description!.map((x) => x)),
    "document": document == null ? [] : List<dynamic>.from(document!.map((x) => x)),
    "status": status,
    "approval_note": approvalNote,
  };
}
