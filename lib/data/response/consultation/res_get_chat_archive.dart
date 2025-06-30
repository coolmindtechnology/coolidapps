import 'dart:convert';

ResGetChatArchived resGetChatArchivedFromJson(String str) =>
    ResGetChatArchived.fromJson(json.decode(str));

String resGetChatArchivedToJson(ResGetChatArchived data) =>
    json.encode(data.toJson());

class ResGetChatArchived {
  final bool success;
  final String message;
  final List<ChatMessageData> data;

  ResGetChatArchived({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ResGetChatArchived.fromJson(Map<String, dynamic> json) =>
      ResGetChatArchived(
        success: json["success"],
        message: json["message"],
        data: List<ChatMessageData>.from(
            json["data"].map((x) => ChatMessageData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class ChatMessageData {
  final int id;
  final String idConsultation;
  final String firestoreDocId;
  final String senderFirebaseUid;
  final String receiverFirebaseUid;
  final String senderEmail;
  final String messageContent;
  final String messageType;
  final String status;
  final DateTime firestoreTimestamp;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  ChatMessageData({
    required this.id,
    required this.idConsultation,
    required this.firestoreDocId,
    required this.senderFirebaseUid,
    required this.receiverFirebaseUid,
    required this.senderEmail,
    required this.messageContent,
    required this.messageType,
    required this.status,
    required this.firestoreTimestamp,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory ChatMessageData.fromJson(Map<String, dynamic> json) =>
      ChatMessageData(
        id: json["id"],
        idConsultation: json["id_consultation"],
        firestoreDocId: json["firestore_doc_id"],
        senderFirebaseUid: json["sender_firebase_uid"],
        receiverFirebaseUid: json["receiver_firebase_uid"],
        senderEmail: json["sender_email"],
        messageContent: json["message_content"],
        messageType: json["message_type"],
        status: json["status"],
        firestoreTimestamp: DateTime.parse(json["firestore_timestamp"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"] == null
            ? null
            : DateTime.parse(json["deleted_at"]),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_consultation": idConsultation,
    "firestore_doc_id": firestoreDocId,
    "sender_firebase_uid": senderFirebaseUid,
    "receiver_firebase_uid": receiverFirebaseUid,
    "sender_email": senderEmail,
    "message_content": messageContent,
    "message_type": messageType,
    "status": status,
    "firestore_timestamp": firestoreTimestamp.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt?.toIso8601String(),
  };
}
