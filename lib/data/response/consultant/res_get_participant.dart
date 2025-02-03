// To parse this JSON data, do
//
//     final resGetParticipant = resGetParticipantFromJson(jsonString);

import 'dart:convert';

ResGetParticipant resGetParticipantFromJson(String str) => ResGetParticipant.fromJson(json.decode(str));

String resGetParticipantToJson(ResGetParticipant data) => json.encode(data.toJson());

class ResGetParticipant {
  bool? success;
  String? message;
  List<Datum>? data;

  ResGetParticipant({
    this.success,
    this.message,
    this.data,
  });

  factory ResGetParticipant.fromJson(Map<String, dynamic> json) => ResGetParticipant(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  int? consultationId;
  int? roomId;
  String? participantName;
  String? bloodType;
  String? profilePicture;
  String? personalityType;
  String? remainingMinutes;
  String? consultationTime;
  String? status;
  int? rate;
  String? statusSession;
  String? typeConsultation;
  String? participantExplanation;
  String? amount;
  String? theme;
  int? duration;
  String? type;

  Datum({
    this.consultationId,
    this.roomId,
    this.participantName,
    this.bloodType,
    this.profilePicture,
    this.personalityType,
    this.remainingMinutes,
    this.consultationTime,
    this.status,
    this.rate,
    this.statusSession,
    this.typeConsultation,
    this.participantExplanation,
    this.amount,
    this.theme,
    this.duration,
    this.type,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    consultationId: json["consultation_id"],
    roomId: json["room_id"],
    participantName: json["participant_name"],
    bloodType: json["blood_type"],
    profilePicture: json["profile_picture"],
    personalityType: json["personality_type"],
    remainingMinutes: json["remaining_minutes"],
    consultationTime: json["consultation_time"],
    status: json["status"],
    rate: json["rate"],
    statusSession: json["status_session"],
    typeConsultation: json["type_consultation"],
    participantExplanation: json["participant_explanation"],
    amount: json["amount"],
    theme: json["theme"],
    duration: json["duration"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "consultation_id": consultationId,
    "room_id": roomId,
    "participant_name": participantName,
    "blood_type": bloodType,
    "profile_picture": profilePicture,
    "personality_type": personalityType,
    "remaining_minutes": remainingMinutes,
    "consultation_time": consultationTime,
    "status": status,
    "rate": rate,
    "status_session": statusSession,
    "type_consultation": typeConsultation,
    "participant_explanation": participantExplanation,
    "amount": amount,
    "theme": theme,
    "duration": duration,
    "type": type,
  };
}
