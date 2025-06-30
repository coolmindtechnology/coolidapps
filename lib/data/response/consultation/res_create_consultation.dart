class ResponseCreateConsultation {
  final bool success;
  final String message;
  final ConsultationData? data;

  ResponseCreateConsultation({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ResponseCreateConsultation.fromJson(Map<String, dynamic> json) {
    return ResponseCreateConsultation(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? ConsultationData.fromJson(json['data']) : null,
    );
  }
}

class ConsultationData {
  final dynamic id;
  final dynamic consultantId;
  final dynamic participantId;
  final dynamic themeId;
  final dynamic startTime;
  final dynamic duration;
  final dynamic participantExplanation;
  final dynamic amount;
  final dynamic totalAmount;
  final dynamic? paymentType;
  final dynamic status;
  final dynamic typeConsultation;
  final dynamic statusSession;
  final dynamic typeSession;
  final dynamic updatedAt;
  final dynamic createdAt;
  final ConsultationRoom? room;

  ConsultationData({
    required this.id,
    required this.consultantId,
    required this.participantId,
    required this.themeId,
    required this.startTime,
    required this.duration,
    required this.participantExplanation,
    required this.amount,
    required this.totalAmount,
    this.paymentType,
    required this.status,
    required this.typeConsultation,
    required this.statusSession,
    required this.typeSession,
    required this.updatedAt,
    required this.createdAt,
    this.room,
  });

  factory ConsultationData.fromJson(Map<String, dynamic> json) {
    return ConsultationData(
      id: json['id'],
      consultantId: json['consultant_id'],
      participantId: json['participant_id'],
      themeId: json['theme_id'],
      startTime: json['start_time'],
      duration: json['duration'],
      participantExplanation: json['participant_explanation'],
      amount: json['amount'],
      totalAmount: json['total_amount'],
      paymentType: json['payment_type'],
      status: json['status'],
      typeConsultation: json['type_consultation'],
      statusSession: json['status_session'],
      typeSession: json['type_session'],
      updatedAt: json['updated_at'],
      createdAt: json['created_at'],
      room: json['room'] != null ? ConsultationRoom.fromJson(json['room']) : null,
    );
  }
}

class ConsultationRoom {
  final dynamic id;
  final dynamic consultationId;
  final dynamic consultantId;
  final dynamic participantId;
  final dynamic themeId;
  final dynamic duration;
  final dynamic presentParticipant;
  final dynamic presentConsultant;
  final dynamic time;
  final dynamic updatedAt;
  final dynamic createdAt;

  ConsultationRoom({
    required this.id,
    required this.consultationId,
    required this.consultantId,
    required this.participantId,
    required this.themeId,
    required this.duration,
    required this.presentParticipant,
    required this.presentConsultant,
    required this.time,
    required this.updatedAt,
    required this.createdAt,
  });

  factory ConsultationRoom.fromJson(Map<String, dynamic> json) {
    return ConsultationRoom(
      id: json['id'],
      consultationId: json['consultation_id'],
      consultantId: json['consultant_id'],
      participantId: json['participant_id'],
      themeId: json['theme_id'],
      duration: json['duration'],
      presentParticipant: json['present_participant'],
      presentConsultant: json['present_consultant'],
      time: json['time'],
      updatedAt: json['updated_at'],
      createdAt: json['created_at'],
    );
  }
}
