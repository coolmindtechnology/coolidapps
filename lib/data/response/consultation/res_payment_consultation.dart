import 'dart:convert';

ResPaymentKonsultasi resPaymentKonsultasiFromJson(String str) =>
    ResPaymentKonsultasi.fromJson(json.decode(str));

String resPaymentKonsultasiToJson(ResPaymentKonsultasi data) =>
    json.encode(data.toJson());

class ResPaymentKonsultasi {
  final bool success;
  final String message;
  final Data data;

  ResPaymentKonsultasi({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ResPaymentKonsultasi.fromJson(Map<String, dynamic> json) =>
      ResPaymentKonsultasi(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  final int id;
  final String orderId;
  final String idLogs;
  final String idItemPayments;
  final String idUser;
  final String amount;
  final String discount;
  final String totalAmount;
  final String transactionType;
  final String? paymentType;
  final String status;
  final String snapToken;
  final String? transactionIdPaypal;
  final String? currencyPaypal;
  final String? amountPaypal;
  final String? responsePaypal;
  final String? statusPaypal;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? deletedAt;
  final String gateway;
  final ConsultationDetails consultationDetails;

  Data({
    required this.id,
    required this.orderId,
    required this.idLogs,
    required this.idItemPayments,
    required this.idUser,
    required this.amount,
    required this.discount,
    required this.totalAmount,
    required this.transactionType,
    this.paymentType,
    required this.status,
    required this.snapToken,
    this.transactionIdPaypal,
    this.currencyPaypal,
    this.amountPaypal,
    this.responsePaypal,
    this.statusPaypal,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.gateway,
    required this.consultationDetails,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    orderId: json["order_id"],
    idLogs: json["id_logs"],
    idItemPayments: json["id_item_payments"],
    idUser: json["id_user"],
    amount: json["amount"],
    discount: json["discount"],
    totalAmount: json["total_amount"],
    transactionType: json["transaction_type"],
    paymentType: json["payment_type"],
    status: json["status"],
    snapToken: json["snap_token"],
    transactionIdPaypal: json["transaction_id_paypal"],
    currencyPaypal: json["currency_paypal"],
    amountPaypal: json["amount_paypal"],
    responsePaypal: json["response_paypal"],
    statusPaypal: json["status_paypal"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    gateway: json["gateway"],
    consultationDetails:
    ConsultationDetails.fromJson(json["consultation_details"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_id": orderId,
    "id_logs": idLogs,
    "id_item_payments": idItemPayments,
    "id_user": idUser,
    "amount": amount,
    "discount": discount,
    "total_amount": totalAmount,
    "transaction_type": transactionType,
    "payment_type": paymentType,
    "status": status,
    "snap_token": snapToken,
    "transaction_id_paypal": transactionIdPaypal,
    "currency_paypal": currencyPaypal,
    "amount_paypal": amountPaypal,
    "response_paypal": responsePaypal,
    "status_paypal": statusPaypal,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
    "gateway": gateway,
    "consultation_details": consultationDetails.toJson(),
  };
}

class ConsultationDetails {
  final String id;
  final String consultantId;
  final String participantId;
  final String themeId;
  final String startTime;
  final String duration;
  final String participantExplanation;
  final String amount;
  final String? discount;
  final String totalAmount;
  final String? paymentType;
  final String status;
  final String? snapToken;
  final String? transactionIdPaypal;
  final String? currencyPaypal;
  final String? amountPaypal;
  final String? responsePaypal;
  final String? statusPaypal;
  final String typeConsultation;
  final String statusSession;
  final String typeSession;
  final String? paidAt;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;

  ConsultationDetails({
    required this.id,
    required this.consultantId,
    required this.participantId,
    required this.themeId,
    required this.startTime,
    required this.duration,
    required this.participantExplanation,
    required this.amount,
    this.discount,
    required this.totalAmount,
    this.paymentType,
    required this.status,
    this.snapToken,
    this.transactionIdPaypal,
    this.currencyPaypal,
    this.amountPaypal,
    this.responsePaypal,
    this.statusPaypal,
    required this.typeConsultation,
    required this.statusSession,
    required this.typeSession,
    this.paidAt,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory ConsultationDetails.fromJson(Map<String, dynamic> json) =>
      ConsultationDetails(
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
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
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
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
  };
}
