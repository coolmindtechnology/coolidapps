import 'dart:convert';

ResHomeConsultant resHomeConsultantFromJson(String str) => ResHomeConsultant.fromJson(json.decode(str));

String resHomeConsultantToJson(ResHomeConsultant data) => json.encode(data.toJson());

class ResHomeConsultant {
  dynamic success;
  dynamic message;
  dynamic data;

  ResHomeConsultant({
    this.success,
    this.message,
    this.data,
  });

  factory ResHomeConsultant.fromJson(Map<String, dynamic> json) => ResHomeConsultant(
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
  dynamic name;
  dynamic typeBrain;
  dynamic typeBlood;
  dynamic rating;
  dynamic availableStatus;
  dynamic sessionCompleted;
  dynamic follower;
  dynamic status;
  dynamic totalHistoryConsultations;
  dynamic totalHistoryCurhat;
  dynamic totalHistoryComission;
  dynamic totalComission;

  Data({
    this.id,
    this.name,
    this.typeBrain,
    this.typeBlood,
    this.rating,
    this.availableStatus,
    this.sessionCompleted,
    this.follower,
    this.status,
    this.totalHistoryConsultations,
    this.totalHistoryCurhat,
    this.totalHistoryComission,
    this.totalComission,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    typeBrain: json["type_brain"],
    typeBlood: json["type_blood"],
    rating: json["rating"],
    availableStatus: json["available_status"],
    sessionCompleted: json["session_completed"],
    follower: json["follower"],
    status: json["status"],
    totalHistoryConsultations: json["total_history_consultations"],
    totalHistoryCurhat: json["total_history_curhat"],
    totalHistoryComission: json["total_history_comission"],
    totalComission: json["total_comission"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "type_brain": typeBrain,
    "type_blood": typeBlood,
    "rating": rating,
    "available_status": availableStatus,
    "session_completed": sessionCompleted,
    "follower": follower,
    "status": status,
    "total_history_consultations": totalHistoryConsultations,
    "total_history_curhat": totalHistoryCurhat,
    "total_history_comission": totalHistoryComission,
    "total_comission": totalComission,
  };
}
