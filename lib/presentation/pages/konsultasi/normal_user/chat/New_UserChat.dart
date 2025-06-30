import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:coolappflutter/data/networks/endpoint/api_endpoint.dart';
import 'package:coolappflutter/data/provider/provider_chat.dart';
import 'package:coolappflutter/data/provider/provider_consultant.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/normal_user/chat/firebase_chat/rating_chat.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class NewUserChatPage extends StatefulWidget {
  final String reciverUserID;
  final String consultantID;
  final String consultationID;
  final String Tema;
  final String nama;
  final String tipeotak;
  final String waktu;
  final String image;
  final String type;
  final bool status;
  final String explanation;
  const NewUserChatPage(
      {super.key,
      required this.reciverUserID,
      required this.Tema,
      required this.nama,
      required this.tipeotak,
      required this.waktu,
      required this.image,
      required this.type,
      required this.status,
      required this.consultantID,
      required this.consultationID,
      required this.explanation,});

  @override
  State<NewUserChatPage> createState() => _NewUserChatPageState();
}

class _NewUserChatPageState extends State<NewUserChatPage> {
  final TextEditingController _massageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final ValueNotifier<int> _remainingSeconds = ValueNotifier<int>(1800);
  bool _isTyping = false;
  bool _isLoadingTime = true;
  String? _activeRoomId;

  Timer? _timer;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    if (_massageController.text.isNotEmpty) {
      await _chatService.sendMassage(
          widget.reciverUserID, _massageController.text, widget.consultationID);
      _massageController.clear();
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.status) {
      _prepareRoomAndStartTimer();// 🔄 gunakan fungsi baru
    }
  }


  Future<void> _prepareRoomAndStartTimer() async {
    setState(() {
      _isLoadingTime = true;
    });

    try {
      // ✅ Simpan langsung ke _activeRoomId
      try {
        _activeRoomId = await _chatService.getActiveChatRoomId(
          _firebaseAuth.currentUser!.uid,
          widget.reciverUserID,
        );
      } catch (e) {
        print("Room tidak ditemukan, membuat room baru...");
        await _chatService.sendMassage(
            widget.reciverUserID, widget.explanation, widget.consultationID);
        _activeRoomId = await _chatService.getActiveChatRoomId(
          _firebaseAuth.currentUser!.uid,
          widget.reciverUserID,
        );
      }

      final docRef = FirebaseFirestore.instance
          .collection('chat_rooms')
          .doc(_activeRoomId);
      final snapshot = await docRef.get();
      final data = snapshot.data();

      if (data?['start_time'] == null) {
        await docRef.update({'start_time': FieldValue.serverTimestamp()});
        await Future.delayed(Duration(milliseconds: 500));
      }

      int seconds = await _chatService.getRemainingTime(_activeRoomId!);
      _remainingSeconds.value = seconds;

      _startTimer();
    } catch (e) {
      print("Gagal siapkan room dan timer: $e");
    } finally {
      setState(() {
        _isLoadingTime = false;
      });
    }
  }





  void pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      await _chatService.sendImage(widget.reciverUserID, image);
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingSeconds.value > 0) {
        _remainingSeconds.value--;
      } else {
        timer.cancel();
        Future.microtask(() {
          context.read<ConsultantProvider>().stopSession(
            context,
            widget.consultationID,
            widget.type,
            _activeRoomId ?? '', // ✅ Pakai yang disimpan
          );
          _chatService.endChatSession(widget.reciverUserID);
        });
      }
    });
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return "${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              widget.Tema,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        centerTitle: true,
        actions:  [
          ValueListenableBuilder<int>(
            valueListenable: _remainingSeconds,
            builder: (context, seconds, child) {
              return AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child: _isLoadingTime
                    ? Container(
                  width: 40,
                  height: 40,
                  padding: const EdgeInsets.all(8),
                  child: const CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: Colors.white,
                  ),
                )
                    : Container(
                  key: ValueKey("timerBox"),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    border: Border.all(
                      color: seconds > 0 ? Colors.blue : Colors.red,
                      width: 5,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: Text(
                      seconds > 0
                          ? _formatTime(seconds)
                          : S.of(context).Archives,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 18,
                        color: seconds > 0 ? Colors.blue : Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Text('ini uid penerima ${widget.reciverUserID}'),
          //pesan
          Padding(
            padding: const EdgeInsets.only(top: 20,right: 20,bottom: 50,left: 20),
            child: Container(
              width: double.infinity,
              height: 100,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(widget.image),
                        fit: BoxFit.cover, // Memastikan gambar memenuhi lingkaran
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(widget.nama,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16)),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              widget.tipeotak,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.orange,
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                            decoration: BoxDecoration(
                                color: BlueColor,
                                borderRadius: BorderRadius.circular(10)),
                            height: 30.sp,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                   widget.Tema,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Colors.white,fontSize: 13),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    widget.waktu,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Colors.white,fontSize: 13),
                                  ),
                                ],
                              ),
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          gapH20,
          if (_remainingSeconds == 0)
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                color: Colors.red[50],
                padding: EdgeInsets.all(10),
                child: Text(
                  S.of(context).Session_Closed_Message,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style:
                  TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          Expanded(child: _buildMassageList()),
          //ngirim
          ValueListenableBuilder<int>(
            valueListenable: _remainingSeconds,
            builder: (context, seconds, child) {
              return seconds > 0
                  ? _buildMassageInput()
                  : Center(
                child: TextButton(
                  onPressed: () {
                    Nav.to(RatingChat(consultanId: widget.consultantID,consultationId: widget.consultationID,));
                  },
                  child: Text(S.of(context).Give_Rating),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // build massage list
  Widget _buildMassageList() {
    return Consumer<ChatService>(
      builder: (context, chatService, child) {
        return StreamBuilder(
          stream: chatService.getMessages(widget.reciverUserID, _firebaseAuth.currentUser!.uid),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: Text('Belum ada pesan'));
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text('Belum ada pesan'));
            }
            return ListView(
              children: snapshot.data!.docs
                  .map((document) => _buildMessageItem(document))
                  .toList(),
            );
          },
        );
      },
    );
  }


  // build massage item
  // build massage item
  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;

    if (data == null) {
      return const SizedBox(); // Jika data null, tampilkan widget kosong
    }

    var isMe = data['senderId'] == _firebaseAuth.currentUser!.uid;
    var alignment = isMe ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          // Text(data['senderEmail'] ?? 'Unknown',
          //     style: const TextStyle(fontWeight: FontWeight.bold)),
          // const SizedBox(height: 5),

          // Cek apakah pesan berupa teks atau gambar
          if (data['type'] == 'image' && (data['message']?.isNotEmpty ?? false))
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                data['message'] ?? '',
                width: 250,
                height: 250,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.broken_image, size: 100);
                },
              ),
            )
          else
            ChatBubble(
              message: data['massage'] ?? '',
              bubbleColor: isMe ? Colors.black12 : primaryColor,
              alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
              crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              textColor: isMe ? Colors.black : Colors.white,
            ),
        ],
      ),
    );
  }
  // build massage input
  Widget _buildMassageInput() {
    return Container(
      color: primaryColor,
      child: Padding(
        padding: const EdgeInsets.only(
            left: 8, right: 8, top: 20, bottom: 20),
        child: Row(
          children: [
            // IconButton(
            //   icon: Icon(
            //     Icons.camera_alt,
            //     color: BlueColor,
            //   ),
            //     onPressed: () => pickImage(ImageSource.camera)
            // ),
            // IconButton(
            //   icon: Icon(
            //     Icons.attach_file,
            //     color: BlueColor,
            //   ),
            //   onPressed: () => pickImage(ImageSource.gallery),
            // ),
            Expanded(
              child: SizedBox(
                height: 50,
                child: TextField(
                  controller: _massageController,
                  onChanged: (text) {
                    if (!_isTyping && text.isNotEmpty) {
                      setState(() {
                        _isTyping = true; // Set menjadi true hanya sekali saat mulai mengetik
                      });
                    }
                  },
                  decoration: InputDecoration(
                    filled: true,
                    hintText: S.of(context).Write_Here,
                    hintStyle: TextStyle(color: Colors.grey),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: BlueColor,
                        )),
                  ),
                ),
              ),
            ),
            IconButton(
              icon: Icon( Icons.send,
                color: BlueColor,
              ),
              onPressed: sendMessage
            ),
          ],
        ),
      ),
    );
    // return Padding(
    //   padding: const EdgeInsets.all(8.0),
    //   child: Row(
    //     children: [
    //       Expanded(
    //           child: TextField(
    //         controller: _massageController,
    //         obscureText: false,
    //         decoration: InputDecoration(hintText: "ketik teks"),
    //       )),
    //       IconButton(
    //           onPressed: sendMessage,
    //           icon: Icon(
    //             Icons.arrow_upward,
    //             size: 40,
    //           ))
    //     ],
    //   ),
    // );
  }
}

class ChatBubble extends StatelessWidget {
  final String message;
  final Color bubbleColor;
  final Color textColor;
  final Alignment alignment;
  final CrossAxisAlignment crossAxisAlignment;

  const ChatBubble({
    super.key,
    required this.message,
    required this.bubbleColor,
    required this.textColor,
    required this.alignment,
    required this.crossAxisAlignment,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Column(
        crossAxisAlignment: crossAxisAlignment,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              color: bubbleColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              message,
              style: TextStyle(color: textColor, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

class TimerWidget extends StatefulWidget {
  final int initialSeconds;
  TimerWidget({required this.initialSeconds});

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  late int _remainingSeconds;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.initialSeconds;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _remainingSeconds > 0 ? "Waktu: $_remainingSeconds" : "Sesi Berakhir",
      style: TextStyle(fontSize: 18, color: Colors.red),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

