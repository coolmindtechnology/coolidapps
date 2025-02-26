import 'dart:convert';

ResUpdateStatus resUpdateStatusFromJson(String str) => ResUpdateStatus.fromJson(json.decode(str));

String resUpdateStatusToJson(ResUpdateStatus data) => json.encode(data.toJson());

class ResUpdateStatus {
  dynamic success;
  dynamic message;
  dynamic data;

  ResUpdateStatus({
    this.success,
    this.message,
    this.data,
  });

  factory ResUpdateStatus.fromJson(Map<String, dynamic> json) => ResUpdateStatus(
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
  dynamic id;
  dynamic userId;
  dynamic typeBrain;
  dynamic typeBlood;
  dynamic rating;
  dynamic isActive;
  dynamic availableStatus;
  dynamic totalIncome;
  dynamic sessionCompleted;
  dynamic follower;
  dynamic deletedAt;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic approvalId;

  Data({
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
