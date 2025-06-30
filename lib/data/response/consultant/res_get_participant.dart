import 'dart:convert';

ResGetParticipant resGetParticipantFromJson(String str) =>
    ResGetParticipant.fromJson(json.decode(str));

String resGetParticipantToJson(ResGetParticipant data) =>
    json.encode(data.toJson());

class ResGetParticipant {
  bool? success;
  String? message;
  List<Datum>? data;

  ResGetParticipant({
    this.success,
    this.message,
    this.data,
  });

  factory ResGetParticipant.fromJson(Map<String, dynamic> json) =>
      ResGetParticipant(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
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
  double? rate; // ✅ Diperbaiki dari int ke double
  String? statusSession;
  String? typeConsultation;
  String? participantExplanation;
  String? amount;
  String? theme;
  String? idDocument;
  dynamic? duration;
  String? type;
  FirebaseData? firebaseConf; // ✅ Disesuaikan dengan JSON

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
    this.idDocument,
    this.duration,
    this.type,
    this.firebaseConf,
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
    rate: json["rate"]?.toDouble(), // ✅ Pastikan dikonversi ke double
    statusSession: json["status_session"],
    typeConsultation: json["type_consultation"],
    participantExplanation: json["participant_explanation"],
    amount: json["amount"],
    theme: json["theme"],
    idDocument: json["id_document"],
    duration: json["duration"],
    type: json["type"],
    firebaseConf: json["firebase_conf"] == null
        ? null
        : FirebaseData.fromJson(json["firebase_conf"]),
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
    "id_document": idDocument,
    "duration": duration,
    "type": type,
    "firebase_conf": firebaseConf?.toJson(),
  };
}

class FirebaseData {
  String? participantIds; // ✅ Ubah ke String
  String? consultantIds; // ✅ Ubah ke String

  FirebaseData({
    this.participantIds,
    this.consultantIds,
  });

  factory FirebaseData.fromJson(Map<String, dynamic> json) => FirebaseData(
    participantIds: json["participant_ids"],
    consultantIds: json["consultant_ids"],
  );

  Map<String, dynamic> toJson() => {
    "participant_ids": participantIds,
    "consultant_ids": consultantIds,
  };
}
