import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:coolappflutter/data/networks/endpoint/api_endpoint.dart';
import 'package:coolappflutter/data/provider/provider_chat.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/konsultant/konsultant_dashboard.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class NewChatPage extends StatefulWidget {
  final String reciverUserID;
  // final String consultantID;
  final String consultationID;
  final String Tema;
  final String nama;
  final String tipeotak;
  final String waktu;
  final String image;
  final bool status;
  const NewChatPage(
      {super.key,
        required this.reciverUserID,
        required this.Tema,
        required this.nama,
        required this.tipeotak,
        required this.waktu,
        required this.image,
        required this.status,
        // required this.consultantID,
        required this.consultationID,});

  @override
  State<NewChatPage> createState() => _NewChatPageState();
}

class _NewChatPageState extends State<NewChatPage> {
  final TextEditingController _massageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final ValueNotifier<int> _remainingSeconds = ValueNotifier<int>(1800);
  Timer? _timer;
  bool _isTyping = false; // Tambahkan variabel untuk mengecek apakah sudah mulai mengetik

  void sendMessage() async {
    if (_massageController.text.isNotEmpty) {
      await _chatService.sendMassage(
          widget.reciverUserID, _massageController.text);
      _massageController.clear();
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.status) {
      _startTimer();
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingSeconds.value > 0) {
        _remainingSeconds.value--; // <- Update hanya value, tanpa setState()
      } else {
        timer.cancel(); // 🔥 STOP timer sebelum panggil API
        Future.microtask(() {
          _postEndRoom();
          _chatService.endChatSession(widget.reciverUserID); // 🔥 Panggil endChatSession
        });// 🔥 Pastikan API hanya dipanggil sekali
      }
    });
  }
  bool _isPosting = false;

  Future<void> _postEndRoom() async {
    debugPrint('Posting end room...');
    if (_isPosting) return;

    _isPosting = true; // 🔥 Langsung update tanpa setState()

    final dio = Dio();
    var apiUrl = '${ApiEndpoint.baseUrl}/api/consultation/post-end-room';
    final formData = FormData.fromMap({
      'consultation_id': widget.consultationID,
      'is_status': 1,
      'type': 'consultation'
    });

    try {
      final response = await dio.post(apiUrl, data: formData);
      if (response.data['success'] == true) {
        print(response.data['message']);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.data['message'])),
        );
      }
    } catch (e) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('Error: $e')),
      // );
      // debugPrint('Error posting data: $e');
    } finally {
      _isPosting = false; // 🔥 Tidak perlu setState, hanya update variabel biasa
    }
  }




  void pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      await _chatService.sendImage(widget.reciverUserID, image);
    }
  }

  void uploadTestFile() async {
    try {
      final ref = FirebaseStorage.instance.ref().child('test_upload.txt');
      await ref.putString("Hello Firebase Storage");
      print("Upload berhasil!");
    } catch (e) {
      print("Error: $e");
    }
  }
  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return "${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}";
  }

  final Map<String, Color> brainColors = {
    "emotion_in": Colors.green,
    "emotion_out": Colors.green,
    "emotion": Colors.green,
    "action_in": Colors.red,
    "action_out": Colors.red,
    "action": Colors.red,
    "creative_in": Colors.orange,
    "creative_out": Colors.orange,
    "creative": Colors.orange,
    "master": Colors.black,
    "logic_in": Colors.yellow,
    "logic_out": Colors.yellow,
    "logic": Colors.yellow,
  };



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
        leading: ValueListenableBuilder<int>(
          valueListenable: _remainingSeconds,
          builder: (context, seconds, child) {
            return seconds == 0
                ? IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Nav.to(KonsultantDashboard());
              },
            )
                : SizedBox(); // Jika timer belum habis, leading dikosongkan
          },
        ),
        actions: [
          ValueListenableBuilder<int>(
            valueListenable: _remainingSeconds,
            builder: (context, seconds, child) {
              return Container(
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
                    seconds > 0 ? _formatTime(seconds) : S.of(context).Archives,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 18,
                      color: seconds > 0 ? Colors.blue : Colors.red,
                      fontWeight: FontWeight.w600,
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
          Container(
            color: Color(0xFFBBE9FA),
            child: Padding(
              padding: const EdgeInsets.only(top: 10,right: 20,bottom: 10,left: 20),
              child: Container(
                width: double.infinity,
                height: 100,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 70,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color:
                          brainColors[widget.tipeotak] ?? Colors.white, // Warna garis tepi
                          width: 4, // Lebar garis tepi
                        ),
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
                                  color:  brainColors[widget.tipeotak] ?? Colors.white,
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            widget.waktu,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: BlueColor,fontSize: 13),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          gapH40,
          Expanded(child: _buildMassageList()),
          //ngirim
          _buildMassageInput(),
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
          const SizedBox(height: 5),

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
            ChatBubble(massage: data['massage'] ?? ''),
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
            IconButton(
              icon: Icon(
                Icons.camera_alt,
                color: BlueColor,
              ),
              // onPressed: () => pickImage(ImageSource.camera)
              onPressed: () => pickImage(ImageSource.camera)
            ),
            IconButton(
              icon: Icon(
                Icons.attach_file,
                color: BlueColor,
              ),
              onPressed: () => pickImage(ImageSource.gallery),
            ),
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
                onPressed: sendMessage,
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
  final String massage;
  const ChatBubble({super.key, required this.massage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: primaryColor, borderRadius: BorderRadius.circular(10)),
      child: Text(massage, style: TextStyle(color: Colors.white, fontSize: 16)),
    );
  }
}
