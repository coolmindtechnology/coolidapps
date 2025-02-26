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
  int? consultantId; // Integer ID for consultant
  int? participantId; // Integer ID for participant
  int? themeId; // Integer ID for theme
  String? startTime; // Format time: "HH:MM:SS"
  int? duration; // Duration in minutes
  String? participantExplanation;
  String? amount; // Represented as String
  String? discount; // Represented as String
  String? totalAmount; // Represented as String
  dynamic paymentType; // Could be null
  String? status;
  dynamic snapToken; // Can be null
  dynamic transactionIdPaypal; // Can be null
  dynamic currencyPaypal; // Can be null
  dynamic amountPaypal; // Can be null
  dynamic responsePaypal; // Can be null
  dynamic statusPaypal; // Can be null
  String? typeConsultation;
  String? statusSession;
  String? typeSession;
  dynamic paidAt; // Can be null
  DateTime? createdAt; // Should be DateTime
  DateTime? updatedAt; // Should be DateTime
  dynamic deletedAt; // Can be null

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
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    consultantId: json["consultant_id"],
    participantId: json["participant_id"],
    themeId: json["theme_id"],
    startTime: json["start_time"], // Waktu dalam format String
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
  };
}
