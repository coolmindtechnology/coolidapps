import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:coolappflutter/data/provider/provider_chat.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewChatPage extends StatefulWidget {
  final String reciverUserID;
  final String Tema;
  final String nama;
  final String tipeotak;
  final String waktu;
  final String image;
  const NewChatPage(
      {super.key,
        required this.reciverUserID,
        required this.Tema,
        required this.nama,
        required this.tipeotak,
        required this.waktu,
        required this.image});

  @override
  State<NewChatPage> createState() => _NewChatPageState();
}

class _NewChatPageState extends State<NewChatPage> {
  final TextEditingController _massageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    if (_massageController.text.isNotEmpty) {
      await _chatService.sendMassage(
          widget.reciverUserID, _massageController.text);
      _massageController.clear();
    }
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
        actions: [
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Center(
          //     child: Container(
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(10),
          //         color: Colors.white,
          //         border: Border.all(
          //           color: _remainingSeconds > 0 ? Colors.blue : Colors.red,
          //           width: 5,
          //         ),
          //       ),
          //       child: Padding(
          //         padding: const EdgeInsets.all(2),
          //         child: Text(
          //           _remainingSeconds > 0
          //               ? _formatTime(_remainingSeconds)
          //               : S.of(context).Archives,
          //           overflow: TextOverflow.ellipsis,
          //           style: TextStyle(
          //             fontSize: 18,
          //             color: _remainingSeconds > 0 ? Colors.blue : Colors.red,
          //             fontWeight: FontWeight.w600,
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
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
    return StreamBuilder(
      stream: _chatService.getMassages(
          widget.reciverUserID, _firebaseAuth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error' + snapshot.error.toString());
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('Loaidng');
        }
        return ListView(
          children: snapshot.data!.docs
              .map((document) => _buildMassageItem(document))
              .toList(),
        );
      },
    );
  }

  // build massage item
  Widget _buildMassageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    var aligment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
      alignment: aligment,
      child: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20,bottom: 8,top: 8),
        child: Column(
            crossAxisAlignment:
            (data['senderId'] == _firebaseAuth.currentUser!.uid)
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            mainAxisAlignment:
            (data['senderId'] == _firebaseAuth.currentUser!.uid)
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              // Text(data['senderEmail']),
              // SizedBox(height: 5,),
              ChatBubble(massage: data['massage']),
            ]),
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
              onPressed: () {

              },
            ),
            IconButton(
              icon: Icon(
                Icons.attach_file,
                color: BlueColor,
              ),
              onPressed: () {

              },
            ),
            Expanded(
              child: SizedBox(
                height: 50,
                child: TextField(
                  controller: _massageController,
                  onChanged: (text) {
                    setState(() {});
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
