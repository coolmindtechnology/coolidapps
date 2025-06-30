class ResCheckSessionConsultant {
  final bool success;
  final String message;
  final List<SessionData> data;

  ResCheckSessionConsultant({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ResCheckSessionConsultant.fromJson(Map<String, dynamic> json) {
    return ResCheckSessionConsultant(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => SessionData.fromJson(e))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data.map((e) => e.toJson()).toList(),
    };
  }
}

class SessionData {
  final int id;
  final String targetId;
  final String theme;
  final String targetImage;
  final String targetName;
  final String targetBloodType;
  final String targetTypeBrain;
  final String targetAddress;
  final String explanation;
  final String sessionStatus;
  final int rating;
  final int remainingMinutes;
  final String sessionStart;
  final String sessionEnd;
  final String timeSelected;
  final String price;
  final bool status;
  final String typeSession;
  final FirebaseConf firebaseConf;

  SessionData({
    required this.id,
    required this.targetId,
    required this.theme,
    required this.targetImage,
    required this.targetName,
    required this.targetBloodType,
    required this.targetTypeBrain,
    required this.targetAddress,
    required this.explanation,
    required this.sessionStatus,
    required this.rating,
    required this.remainingMinutes,
    required this.sessionStart,
    required this.sessionEnd,
    required this.timeSelected,
    required this.price,
    required this.status,
    required this.typeSession,
    required this.firebaseConf,
  });

  factory SessionData.fromJson(Map<String, dynamic> json) {
    return SessionData(
      id: json['id'] ?? 0,
      targetId: json['target_id'] ?? '',
      theme: json['theme'] ?? '',
      targetImage: json['target_image'] ?? '',
      targetName: json['target_name'] ?? '',
      targetBloodType: json['target_blood_type'] ?? '',
      targetTypeBrain: json['target_type_brain'] ?? '',
      targetAddress: json['target_address'] ?? '',
      explanation: json['explanation'] ?? '',
      sessionStatus: json['session_status'] ?? '',
      rating: json['rating'] ?? 0,
      remainingMinutes: json['remaining_minutes'] ?? 0,
      sessionStart: json['session_start'] ?? '',
      sessionEnd: json['session_end'] ?? '',
      timeSelected: json['time_selected'] ?? '',
      price: json['price'] ?? '',
      status: json['status'] ?? false,
      typeSession: json['type_session'] ?? '',
      firebaseConf:
      FirebaseConf.fromJson(json['firebase_conf'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'target_id': targetId,
      'theme': theme,
      'target_image': targetImage,
      'target_name': targetName,
      'target_blood_type': targetBloodType,
      'target_type_brain': targetTypeBrain,
      'target_address': targetAddress,
      'explanation': explanation,
      'session_status': sessionStatus,
      'rating': rating,
      'remaining_minutes': remainingMinutes,
      'session_start': sessionStart,
      'session_end': sessionEnd,
      'time_selected': timeSelected,
      'price': price,
      'status': status,
      'type_session': typeSession,
      'firebase_conf': firebaseConf.toJson(),
    };
  }
}

class FirebaseConf {
  final String participantIds;
  final String consultantIds;

  FirebaseConf({
    required this.participantIds,
    required this.consultantIds,
  });

  factory FirebaseConf.fromJson(Map<String, dynamic> json) {
    return FirebaseConf(
      participantIds: json['participant_ids'] ?? '',
      consultantIds: json['consultant_ids'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'participant_ids': participantIds,
      'consultant_ids': consultantIds,
    };
  }
}
