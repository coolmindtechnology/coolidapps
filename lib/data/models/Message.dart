import 'package:cloud_firestore/cloud_firestore.dart';

class Massage {
  final String senderId;
  final String senderEmail;
  final String reciverId;
  final String massage;
  final Timestamp timestamp;

  Massage({
    required this.senderId,
    required this.senderEmail,
    required this.reciverId,
    required this.massage,
    required this.timestamp,
  });

  //ubah ka map
  Map<String, dynamic> toMap() {
    return{
      'senderId' : senderId,
      'senderEmail' : senderEmail,
      'reciverId' : reciverId,
      'massage' : massage,
      'timestamp' : timestamp,
    };
  }
}
