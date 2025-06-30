class ResponseJoin {
  final bool success;
  final String message;
  final JoinRoomData? data;

  ResponseJoin({
    required this.success,
    required this.message,
    this.data,
  });

  factory ResponseJoin.fromJson(Map<String, dynamic> json) {
    return ResponseJoin(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? JoinRoomData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class JoinRoomData {
  final int id;
  final String consultationId;
  final String consultantId;
  final String participantId;
  final String themeId;
  final String duration;
  final String presentParticipant;
  final String? presentParticipantAt;
  final String presentConsultant;
  final String? presentConsultantAt;
  final String? startRoom;
  final String? endRoom;
  final String? deletedAt;
  final String createdAt;
  final String updatedAt;
  final String time;
  final String approvalStatusConsultant;
  final String? approvalNoteConsultant;

  JoinRoomData({
    required this.id,
    required this.consultationId,
    required this.consultantId,
    required this.participantId,
    required this.themeId,
    required this.duration,
    required this.presentParticipant,
    this.presentParticipantAt,
    required this.presentConsultant,
    this.presentConsultantAt,
    this.startRoom,
    this.endRoom,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.time,
    required this.approvalStatusConsultant,
    this.approvalNoteConsultant,
  });

  factory JoinRoomData.fromJson(Map<String, dynamic> json) {
    return JoinRoomData(
      id: json['id'],
      consultationId: json['consultation_id'] ?? '',
      consultantId: json['consultant_id'] ?? '',
      participantId: json['participant_id'] ?? '',
      themeId: json['theme_id'] ?? '',
      duration: json['duration'] ?? '',
      presentParticipant: json['present_participant'] ?? '',
      presentParticipantAt: json['present_participant_at'],
      presentConsultant: json['present_consultant'] ?? '',
      presentConsultantAt: json['present_consultant_at'],
      startRoom: json['start_room'],
      endRoom: json['end_room'],
      deletedAt: json['deleted_at'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      time: json['time'] ?? '',
      approvalStatusConsultant: json['approval_status_consultant'] ?? '',
      approvalNoteConsultant: json['approval_note_consultant'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'consultation_id': consultationId,
      'consultant_id': consultantId,
      'participant_id': participantId,
      'theme_id': themeId,
      'duration': duration,
      'present_participant': presentParticipant,
      'present_participant_at': presentParticipantAt,
      'present_consultant': presentConsultant,
      'present_consultant_at': presentConsultantAt,
      'start_room': startRoom,
      'end_room': endRoom,
      'deleted_at': deletedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'time': time,
      'approval_status_consultant': approvalStatusConsultant,
      'approval_note_consultant': approvalNoteConsultant,
    };
  }
}
