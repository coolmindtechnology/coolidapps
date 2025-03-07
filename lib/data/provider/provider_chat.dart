import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coolappflutter/data/models/Message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class ChatService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ///send
  Future<void> sendMassage(String reciverId, String massage) async {
    //get current user info
    final String currentId = _firebaseAuth.currentUser!.uid;
    final String currentEmail = _firebaseAuth.currentUser!.email!.toString();
    final Timestamp timestamp = Timestamp.now();

    /// buek pesan baru
    Massage newMassage = Massage(
        senderId: currentId,
        senderEmail: currentEmail,
        reciverId: reciverId,
        massage: massage,
        timestamp: timestamp);

    /// construk room chat dari id user kini samo reciver id
    List<String> ids = [currentId, reciverId];
    ids.sort(); //memastikan room id samo
    String chatRoomId = ids.join('_');

    /// manambahkan data pesan ke room chat
    await _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMassage.toMap());
  }

  ///get
  Stream<QuerySnapshot> getMassages(String userId, String otherUserid) {
    // konstruks room chat
    List<String> ids = [userId, otherUserid];
    ids.sort();
    String chatRoomId = ids.join('_');
    return _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
