import 'dart:convert';

ResApproveByConsultant resApproveByConsultantFromJson(String str) =>
    ResApproveByConsultant.fromJson(json.decode(str));

String resApproveByConsultantToJson(ResApproveByConsultant data) =>
    json.encode(data.toJson());

class ResApproveByConsultant {
  bool? success;
  String? message;
  Data? data;

  ResApproveByConsultant({
    this.success,
    this.message,
    this.data,
  });

  factory ResApproveByConsultant.fromJson(Map<String, dynamic> json) =>
      ResApproveByConsultant(
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
  int? id;
  String? consultantId;
  String? participantId;
  String? themeId;
  String? startTime;
  String? duration;
  String? participantExplanation;
  String? amount;
  String? discount;
  String? totalAmount;
  String? paymentType;
  String? status;
  String? snapToken;
  String? transactionIdPaypal;
  String? currencyPaypal;
  String? amountPaypal;
  String? responsePaypal;
  String? statusPaypal;
  String? typeConsultation;
  String? statusSession;
  String? typeSession;
  String? paidAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? deletedAt;
  List<Room>? room;

  Data({
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    consultantId: json["consultant_id"],
    participantId: json["participant_id"],
    themeId: json["theme_id"],
    startTime: json["start_time"],
    duration: json["duration"],
    participantExplanation: json["participant_explanation"],
    amount: json["amount"],
    discount: json["discount"],
    totalAmount: json["total_amount"],
    paymentType: json["payment_type"],
    status: json["status"],
    snapToken: json["snap_token"],
    transactionIdPaypal: json["transaction_id_paypal"],
    currencyPaypal: json["currency_paypal"],
    amountPaypal: json["amount_paypal"],
    responsePaypal: json["response_paypal"],
    statusPaypal: json["status_paypal"],
    typeConsultation: json["type_consultation"],
    statusSession: json["status_session"],
    typeSession: json["type_session"],
    paidAt: json["paid_at"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    room: json["room"] == null
        ? []
        : List<Room>.from(json["room"].map((x) => Room.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "consultant_id": consultantId,
    "participant_id": participantId,
    "theme_id": themeId,
    "start_time": startTime,
    "duration": duration,
    "participant_explanation": participantExplanation,
    "amount": amount,
    "discount": discount,
    "total_amount": totalAmount,
    "payment_type": paymentType,
    "status": status,
    "snap_token": snapToken,
    "transaction_id_paypal": transactionIdPaypal,
    "currency_paypal": currencyPaypal,
    "amount_paypal": amountPaypal,
    "response_paypal": responsePaypal,
    "status_paypal": statusPaypal,
    "type_consultation": typeConsultation,
    "status_session": statusSession,
    "type_session": typeSession,
    "paid_at": paidAt,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "room": room == null
        ? []
        : List<dynamic>.from(room!.map((x) => x.toJson())),
  };
}

class Room {
  int? id;
  String? consultationId;
  String? consultantId;
  String? participantId;
  String? themeId;
  String? duration;
  String? presentParticipant;
  String? presentParticipantAt;
  String? presentConsultant;
  String? presentConsultantAt;
  String? startRoom;
  String? endRoom;
  String? deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? time;
  String? approvalStatusConsultant;
  String? approvalNoteConsultant;

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
    id: json["id"],
    consultationId: json["consultation_id"],
    consultantId: json["consultant_id"],
    participantId: json["participant_id"],
    themeId: json["theme_id"],
    duration: json["duration"],
    presentParticipant: json["present_participant"],
    presentParticipantAt: json["present_participant_at"],
    presentConsultant: json["present_consultant"],
    presentConsultantAt: json["present_consultant_at"],
    startRoom: json["start_room"],
    endRoom: json["end_room"],
    deletedAt: json["deleted_at"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    time: json["time"],
    approvalStatusConsultant: json["approval_status_consultant"],
    approvalNoteConsultant: json["approval_note_consultant"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "consultation_id": consultationId,
    "consultant_id": consultantId,
    "participant_id": participantId,
    "theme_id": themeId,
    "duration": duration,
    "present_participant": presentParticipant,
    "present_participant_at": presentParticipantAt,
    "present_consultant": presentConsultant,
    "present_consultant_at": presentConsultantAt,
    "start_room": startRoom,
    "end_room": endRoom,
    "deleted_at": deletedAt,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "time": time,
    "approval_status_consultant": approvalStatusConsultant,
    "approval_note_consultant": approvalNoteConsultant,
  };
}
