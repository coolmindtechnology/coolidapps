import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coolappflutter/data/models/Message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class ChatService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  /// **Upload gambar ke Firebase Storage**
  Future<String?> uploadImage(XFile imageFile) async {
    try {
      String fileName = "${DateTime.now().millisecondsSinceEpoch}.jpg";
      Reference ref = FirebaseStorage.instance.ref(fileName);

      UploadTask uploadTask = ref.putFile(File(imageFile.path));
      TaskSnapshot snapshot = await uploadTask.whenComplete(() => {});

      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      print("Error uploading image: ${e.toString()}");
      return null;
    }
  }



  Future<void> sendImage(String receiverId, XFile imageFile) async {
    try {
      final file = File(imageFile.path);

      if (!file.existsSync()) {
        print("Error: File tidak ditemukan di path ${imageFile.path}");
        return;
      }

      final size = file.lengthSync();
      final bytes = await imageFile.readAsBytes();
      final image = await decodeImageFromList(bytes);
      final name = "${DateTime.now().millisecondsSinceEpoch}_${imageFile.name}";

      final User? user = _firebaseAuth.currentUser;
      if (user == null) {
        print("User belum login");
        return;
      }

      final String currentId = user.uid;
      final String currentEmail = user.email ?? "unknown@example.com";
      final Timestamp timestamp = Timestamp.now();

      // Buat base chatRoomId
      List<String> ids = [currentId, receiverId];
      ids.sort();
      String baseChatRoomId = ids.join('_');

      // Cek apakah sudah ada room yang aktif
      QuerySnapshot roomSnapshots = await _firestore
          .collection('chat_rooms')
          .where(FieldPath.documentId, isGreaterThanOrEqualTo: baseChatRoomId)
          .where(FieldPath.documentId, isLessThanOrEqualTo: "${baseChatRoomId}_\uf8ff")
          .orderBy('createdAt', descending: true)
          .get();

      String chatRoomId = baseChatRoomId;
      bool foundActiveRoom = false;

      if (roomSnapshots.docs.isNotEmpty) {
        for (var room in roomSnapshots.docs) {
          Map<String, dynamic> roomData = room.data() as Map<String, dynamic>;

          if (roomData['status'] == 'progress') {
            chatRoomId = room.id;
            foundActiveRoom = true;
            break;
          }
        }
      }

      // Jika tidak ada room aktif, buat room baru
      if (!foundActiveRoom) {
        chatRoomId = "${baseChatRoomId}_${timestamp.seconds}";
        await _firestore.collection('chat_rooms').doc(chatRoomId).set({
          'status': 'progress',
          'createdAt': timestamp
        });
      }

      // Upload gambar ke Firebase Storage di dalam folder chat room yang sesuai
      final reference = FirebaseStorage.instance.ref('chat_images/$chatRoomId/$name');
      final uploadTask = reference.putFile(file);

      uploadTask.snapshotEvents.listen((event) {
        double progress = (event.bytesTransferred / event.totalBytes) * 100;
        print("Upload Progress: ${progress.toStringAsFixed(2)}%");
      }, onError: (error) {
        print("Error saat upload: $error");
      });

      await uploadTask;
      final imageUrl = await reference.getDownloadURL();

      // Simpan metadata gambar ke Firestore dalam room yang sesuai
      await _firestore.collection('chat_rooms')
          .doc(chatRoomId)
          .collection('messages')
          .add({
        'senderId': currentId,
        'senderEmail': currentEmail,
        'receiverId': receiverId,
        'message': imageUrl,
        'timestamp': timestamp,
        'type': 'image',
        'width': image.width.toDouble(),
        'height': image.height.toDouble(),
        'size': size,
        'name': name,
      });

      print("Gambar berhasil dikirim ke chat");

    } catch (e, stacktrace) {
      print("Error sending image: $e");
      print("Stacktrace: $stacktrace");
    }
  }


  ///send
  Future<void> sendMassage(String reciverId, String massage) async {
    final String currentId = _firebaseAuth.currentUser!.uid;
    final String currentEmail = _firebaseAuth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    // Buat room chat ID dasar
    List<String> ids = [currentId, reciverId];
    ids.sort();
    String baseChatRoomId = ids.join('_');

    // Cek semua room yang berhubungan dengan kedua user
    QuerySnapshot roomSnapshots = await _firestore
        .collection('chat_rooms')
        .where(FieldPath.documentId, isGreaterThanOrEqualTo: baseChatRoomId)
        .where(FieldPath.documentId, isLessThanOrEqualTo: "${baseChatRoomId}_\uf8ff")
        .orderBy('createdAt', descending: true) // Ambil yang terbaru
        .get();

    String chatRoomId = baseChatRoomId;
    bool foundActiveRoom = false;

    if (roomSnapshots.docs.isNotEmpty) {
      for (var room in roomSnapshots.docs) {
        Map<String, dynamic> roomData = room.data() as Map<String, dynamic>;

        if (roomData['status'] == 'progress') {
          // Jika ditemukan room dengan status progress, gunakan room tersebut
          chatRoomId = room.id;
          foundActiveRoom = true;
          break;
        }
      }
    }

    // Jika semua room berstatus archive, buat room baru
    if (!foundActiveRoom) {
      chatRoomId = "${baseChatRoomId}_${timestamp.seconds}";
      await _firestore.collection('chat_rooms').doc(chatRoomId).set({
        'status': 'progress',
        'createdAt': timestamp
      });
    }

    // Buat pesan baru
    Massage newMassage = Massage(
      senderId: currentId,
      senderEmail: currentEmail,
      reciverId: reciverId,
      massage: massage,
      timestamp: timestamp,
    );

    // Tambahkan pesan ke dalam room chat yang aktif
    await _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMassage.toMap());

    // 🔥 Panggil notifyListeners agar UI diperbarui
    notifyListeners();
  }



  ///get
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String baseChatRoomId = ids.join('_');

    return _firestore
        .collection('chat_rooms')
        .where(FieldPath.documentId, isGreaterThanOrEqualTo: baseChatRoomId)
        .where(FieldPath.documentId, isLessThanOrEqualTo: "${baseChatRoomId}_\uf8ff")
        .orderBy('createdAt', descending: true) // Ambil yang terbaru
        .snapshots()
        .asyncExpand<QuerySnapshot>((roomSnapshots) async* {
      for (var room in roomSnapshots.docs) {
        Map<String, dynamic> roomData = room.data() as Map<String, dynamic>;

        if (roomData['status'] == 'progress') {
          String chatRoomId = room.id;

          yield* _firestore
              .collection('chat_rooms')
              .doc(chatRoomId)
              .collection('messages')
              .orderBy('timestamp', descending: false)
              .snapshots();
          return;
        }
      }
      yield* Stream<QuerySnapshot>.empty();
    });
  }





  Future<void> endChatSession(String reciverId) async {
    final String currentId = _firebaseAuth.currentUser!.uid;

    // Buat room chat ID dasar
    List<String> ids = [currentId, reciverId];
    ids.sort();
    String baseChatRoomId = ids.join('_');

    // Cari room aktif terbaru dengan status "progress"
    QuerySnapshot roomSnapshots = await _firestore
        .collection('chat_rooms')
        .where(FieldPath.documentId, isGreaterThanOrEqualTo: baseChatRoomId)
        .where(FieldPath.documentId, isLessThanOrEqualTo: "${baseChatRoomId}_\uf8ff")
        .orderBy('createdAt', descending: true) // Ambil room terbaru
        .get();

    if (roomSnapshots.docs.isNotEmpty) {
      for (var room in roomSnapshots.docs) {
        Map<String, dynamic> roomData = room.data() as Map<String, dynamic>;

        if (roomData['status'] == 'progress') {
          String chatRoomId = room.id;

          // Update status menjadi archive
          await _firestore.collection('chat_rooms').doc(chatRoomId).update({
            'status': 'archive'
          });

          return; // Keluar setelah menemukan dan mengupdate room aktif
        }
      }
    }

    // Jika tidak ada room dengan status "progress"
    print("Tidak ada room aktif untuk diakhiri.");
  }


  Stream<QuerySnapshot> getChatRoomsByStatus(String status) {
    return _firestore
        .collection('chat_rooms')
        .where('status', isEqualTo: status)
        .snapshots();
  }

  /// Fungsi untuk mendapatkan ID user yang sedang login
  String getCurrentUserId() {
    return _firebaseAuth.currentUser?.uid ?? "";
  }


}
