// To parse this JSON data, do
//
//     final responseCreateCurhat = responseCreateCurhatFromJson(jsonString);

import 'dart:convert';

ResponseCreateCurhat responseCreateCurhatFromJson(String str) => ResponseCreateCurhat.fromJson(json.decode(str));

String responseCreateCurhatToJson(ResponseCreateCurhat data) => json.encode(data.toJson());

class ResponseCreateCurhat {
  bool? success;
  String? message;
  Data? data;

  ResponseCreateCurhat({
    this.success,
    this.message,
    this.data,
  });

  factory ResponseCreateCurhat.fromJson(Map<String, dynamic> json) => ResponseCreateCurhat(
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
  String? consultantId;
  int? participantId;
  int? themeId;
  DateTime? startTime;
  int? duration;
  String? participantExplanation;
  int? amount;
  int? totalAmount;
  dynamic paymentType;
  String? status;
  String? typeConsultation;
  String? statusSession;
  String? typeSession;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;
  Room? room;

  Data({
    this.consultantId,
    this.participantId,
    this.themeId,
    this.startTime,
    this.duration,
    this.participantExplanation,
    this.amount,
    this.totalAmount,
    this.paymentType,
    this.status,
    this.typeConsultation,
    this.statusSession,
    this.typeSession,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.room,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    consultantId: json["consultant_id"],
    participantId: json["participant_id"],
    themeId: json["theme_id"],
    startTime: json["start_time"] == null ? null : DateTime.parse(json["start_time"]),
    duration: json["duration"],
    participantExplanation: json["participant_explanation"],
    amount: json["amount"],
    totalAmount: json["total_amount"],
    paymentType: json["payment_type"],
    status: json["status"],
    typeConsultation: json["type_consultation"],
    statusSession: json["status_session"],
    typeSession: json["type_session"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    id: json["id"],
    room: json["room"] == null ? null : Room.fromJson(json["room"]),
  );

  Map<String, dynamic> toJson() => {
    "consultant_id": consultantId,
    "participant_id": participantId,
    "theme_id": themeId,
    "start_time": startTime?.toIso8601String(),
    "duration": duration,
    "participant_explanation": participantExplanation,
    "amount": amount,
    "total_amount": totalAmount,
    "payment_type": paymentType,
    "status": status,
    "type_consultation": typeConsultation,
    "status_session": statusSession,
    "type_session": typeSession,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "id": id,
    "room": room?.toJson(),
  };
}

class Room {
  int? consultationId;
  String? consultantId;
  int? participantId;
  int? themeId;
  int? duration;
  String? presentParticipant;
  String? presentConsultant;
  String? time;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  Room({
    this.consultationId,
    this.consultantId,
    this.participantId,
    this.themeId,
    this.duration,
    this.presentParticipant,
    this.presentConsultant,
    this.time,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory Room.fromJson(Map<String, dynamic> json) => Room(
    consultationId: json["consultation_id"],
    consultantId: json["consultant_id"],
    participantId: json["participant_id"],
    themeId: json["theme_id"],
    duration: json["duration"],
    presentParticipant: json["present_participant"],
    presentConsultant: json["present_consultant"],
    time: json["time"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "consultation_id": consultationId,
    "consultant_id": consultantId,
    "participant_id": participantId,
    "theme_id": themeId,
    "duration": duration,
    "present_participant": presentParticipant,
    "present_consultant": presentConsultant,
    "time": time,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "id": id,
  };
}
