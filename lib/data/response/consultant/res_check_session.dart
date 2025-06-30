class ResCheckSession {
  final bool? success;
  final String? message;
  final List<SessionData>? data;

  ResCheckSession({
    this.success,
    this.message,
    this.data,
  });

  factory ResCheckSession.fromJson(Map<String, dynamic> json) => ResCheckSession(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null
        ? []
        : List<SessionData>.from(
        json["data"].map((x) => SessionData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class SessionData {
  final int? id;
  final String? targetId;
  final String? theme;
  final String? targetImage;
  final String? targetName;
  final String? targetBloodType;
  final String? targetTypeBrain;
  final String? targetAddress;
  final String? explanation;
  final String? sessionStatus;
  final dynamic rating;
  final int? remainingMinutes;
  final String? sessionStart;
  final String? sessionEnd;
  final String? timeSelected;
  final String? price;
  final bool? status;
  final String? typeSession;
  final FirebaseConf? firebaseConf;

  SessionData({
    this.id,
    this.targetId,
    this.theme,
    this.targetImage,
    this.targetName,
    this.targetBloodType,
    this.targetTypeBrain,
    this.targetAddress,
    this.explanation,
    this.sessionStatus,
    this.rating,
    this.remainingMinutes,
    this.sessionStart,
    this.sessionEnd,
    this.timeSelected,
    this.price,
    this.status,
    this.typeSession,
    this.firebaseConf,
  });

  factory SessionData.fromJson(Map<String, dynamic> json) => SessionData(
    id: json["id"],
    targetId: json["target_id"],
    theme: json["theme"],
    targetImage: json["target_image"],
    targetName: json["target_name"],
    targetBloodType: json["target_blood_type"],
    targetTypeBrain: json["target_type_brain"],
    targetAddress: json["target_address"],
    explanation: json["explanation"],
    sessionStatus: json["session_status"],
    rating: json["rating"],
    remainingMinutes: json["remaining_minutes"],
    sessionStart: json["session_start"],
    sessionEnd: json["session_end"],
    timeSelected: json["time_selected"],
    price: json["price"],
    status: json["status"],
    typeSession: json["type_session"],
    firebaseConf: json["firebase_conf"] == null
        ? null
        : FirebaseConf.fromJson(json["firebase_conf"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "target_id": targetId,
    "theme": theme,
    "target_image": targetImage,
    "target_name": targetName,
    "target_blood_type": targetBloodType,
    "target_type_brain": targetTypeBrain,
    "target_address": targetAddress,
    "explanation": explanation,
    "session_status": sessionStatus,
    "rating": rating,
    "remaining_minutes": remainingMinutes,
    "session_start": sessionStart,
    "session_end": sessionEnd,
    "time_selected": timeSelected,
    "price": price,
    "status": status,
    "type_session": typeSession,
    "firebase_conf": firebaseConf?.toJson(),
  };
}

class FirebaseConf {
  final String? participantIds;
  final String? consultantIds;

  FirebaseConf({
    this.participantIds,
    this.consultantIds,
  });

  factory FirebaseConf.fromJson(Map<String, dynamic> json) => FirebaseConf(
    participantIds: json["participant_ids"],
    consultantIds: json["consultant_ids"],
  );

  Map<String, dynamic> toJson() => {
    "participant_ids": participantIds,
    "consultant_ids": consultantIds,
  };
}
