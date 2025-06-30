class ResStopSession {
  final bool? success;
  final String? message;
  final StopSessionData? data;

  ResStopSession({
    this.success,
    this.message,
    this.data,
  });

  factory ResStopSession.fromJson(Map<String, dynamic> json) => ResStopSession(
    success: json['success'],
    message: json['message'],
    data: json['data'] != null ? StopSessionData.fromJson(json['data']) : null,
  );

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    'data': data?.toJson(),
  };
}

class StopSessionData {
  final int? id;
  final String? consultantId;
  final String? participantId;
  final String? themeId;
  final String? startTime;
  final String? duration;
  final String? participantExplanation;
  final String? amount;
  final dynamic discount;
  final String? totalAmount;
  final dynamic paymentType;
  final String? status;
  final dynamic snapToken;
  final dynamic transactionIdPaypal;
  final dynamic currencyPaypal;
  final dynamic amountPaypal;
  final dynamic responsePaypal;
  final dynamic statusPaypal;
  final String? typeConsultation;
  final String? statusSession;
  final String? typeSession;
  final dynamic paidAt;
  final String? createdAt;
  final String? updatedAt;
  final dynamic deletedAt;
  final List<Room>? room;

  StopSessionData({
    this.id,
    this.consultantId,
    this.participantId,
    this.themeId,
    this.startTime,
    this.duration,
    this.participantExplanation,
    this.amount,
    this.discount,
    this.totalAmount,
    this.paymentType,
    this.status,
    this.snapToken,
    this.transactionIdPaypal,
    this.currencyPaypal,
    this.amountPaypal,
    this.responsePaypal,
    this.statusPaypal,
    this.typeConsultation,
    this.statusSession,
    this.typeSession,
    this.paidAt,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.room,
  });

  factory StopSessionData.fromJson(Map<String, dynamic> json) => StopSessionData(
    id: json['id'],
    consultantId: json['consultant_id'],
    participantId: json['participant_id'],
    themeId: json['theme_id'],
    startTime: json['start_time'],
    duration: json['duration'],
    participantExplanation: json['participant_explanation'],
    amount: json['amount'],
    discount: json['discount'],
    totalAmount: json['total_amount'],
    paymentType: json['payment_type'],
    status: json['status'],
    snapToken: json['snap_token'],
    transactionIdPaypal: json['transaction_id_paypal'],
    currencyPaypal: json['currency_paypal'],
    amountPaypal: json['amount_paypal'],
    responsePaypal: json['response_paypal'],
    statusPaypal: json['status_paypal'],
    typeConsultation: json['type_consultation'],
    statusSession: json['status_session'],
    typeSession: json['type_session'],
    paidAt: json['paid_at'],
    createdAt: json['created_at'],
    updatedAt: json['updated_at'],
    deletedAt: json['deleted_at'],
    room: json['room'] != null
        ? List<Room>.from(json['room'].map((x) => Room.fromJson(x)))
        : [],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'consultant_id': consultantId,
    'participant_id': participantId,
    'theme_id': themeId,
    'start_time': startTime,
    'duration': duration,
    'participant_explanation': participantExplanation,
    'amount': amount,
    'discount': discount,
    'total_amount': totalAmount,
    'payment_type': paymentType,
    'status': status,
    'snap_token': snapToken,
    'transaction_id_paypal': transactionIdPaypal,
    'currency_paypal': currencyPaypal,
    'amount_paypal': amountPaypal,
    'response_paypal': responsePaypal,
    'status_paypal': statusPaypal,
    'type_consultation': typeConsultation,
    'status_session': statusSession,
    'type_session': typeSession,
    'paid_at': paidAt,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'deleted_at': deletedAt,
    'room': room != null ? List<dynamic>.from(room!.map((x) => x.toJson())) : [],
  };
}

class Room {
  final int? id;
  final String? consultationId;
  final String? consultantId;
  final String? participantId;
  final String? themeId;
  final String? duration;
  final String? presentParticipant;
  final String? presentParticipantAt;
  final String? presentConsultant;
  final String? presentConsultantAt;
  final String? startRoom;
  final String? endRoom;
  final dynamic deletedAt;
  final String? createdAt;
  final String? updatedAt;
  final String? time;
  final String? approvalStatusConsultant;
  final dynamic approvalNoteConsultant;

  Room({
    this.id,
    this.consultationId,
    this.consultantId,
    this.participantId,
    this.themeId,
    this.duration,
    this.presentParticipant,
    this.presentParticipantAt,
    this.presentConsultant,
    this.presentConsultantAt,
    this.startRoom,
    this.endRoom,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.time,
    this.approvalStatusConsultant,
    this.approvalNoteConsultant,
  });

  factory Room.fromJson(Map<String, dynamic> json) => Room(
    id: json['id'],
    consultationId: json['consultation_id'],
    consultantId: json['consultant_id'],
    participantId: json['participant_id'],
    themeId: json['theme_id'],
    duration: json['duration'],
    presentParticipant: json['present_participant'],
    presentParticipantAt: json['present_participant_at'],
    presentConsultant: json['present_consultant'],
    presentConsultantAt: json['present_consultant_at'],
    startRoom: json['start_room'],
    endRoom: json['end_room'],
    deletedAt: json['deleted_at'],
    createdAt: json['created_at'],
    updatedAt: json['updated_at'],
    time: json['time'],
    approvalStatusConsultant: json['approval_status_consultant'],
    approvalNoteConsultant: json['approval_note_consultant'],
  );

  Map<String, dynamic> toJson() => {
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
