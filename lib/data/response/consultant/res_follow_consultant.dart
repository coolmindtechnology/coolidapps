import 'dart:convert';

ResponseFollowConsultant responseFollowConsultantFromJson(String str) =>
    ResponseFollowConsultant.fromJson(json.decode(str));

String responseFollowConsultantToJson(ResponseFollowConsultant data) =>
    json.encode(data.toJson());

class ResponseFollowConsultant {
  bool? success;
  String? message;
  DataFollowConsultant? data;

  ResponseFollowConsultant({
    this.success,
    this.message,
    this.data,
  });

  factory ResponseFollowConsultant.fromJson(Map<String, dynamic> json) =>
      ResponseFollowConsultant(
        success: json["success"],
        message: json["message"],
        data: json["data"] != null
            ? DataFollowConsultant.fromJson(json["data"])
            : null,
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class DataFollowConsultant {
  int? id;
  String? userId;
  String? typeBrain;
  String? typeBlood;
  String? rating;
  String? isActive;
  String? availableStatus;
  String? totalIncome;
  String? sessionCompleted;
  int? follower;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  String? approvalId;

  DataFollowConsultant({
    this.id,
    this.userId,
    this.typeBrain,
    this.typeBlood,
    this.rating,
    this.isActive,
    this.availableStatus,
    this.totalIncome,
    this.sessionCompleted,
    this.follower,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.approvalId,
  });

  factory DataFollowConsultant.fromJson(Map<String, dynamic> json) =>
      DataFollowConsultant(
        id: json["id"],
        userId: json["user_id"],
        typeBrain: json["type_brain"],
        typeBlood: json["type_blood"],
        rating: json["rating"],
        isActive: json["is_active"],
        availableStatus: json["available_status"],
        totalIncome: json["total_income"],
        sessionCompleted: json["session_completed"],
        follower: json["follower"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        approvalId: json["approval_id"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "type_brain": typeBrain,
    "type_blood": typeBlood,
    "rating": rating,
    "is_active": isActive,
    "available_status": availableStatus,
    "total_income": totalIncome,
    "session_completed": sessionCompleted,
    "follower": follower,
    "deleted_at": deletedAt,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "approval_id": approvalId,
  };
}
