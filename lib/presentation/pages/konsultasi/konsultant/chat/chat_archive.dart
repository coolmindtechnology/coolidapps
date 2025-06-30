import 'package:coolappflutter/data/data_global.dart';
import 'package:coolappflutter/data/provider/provider_consultant.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/Normal_User/rating.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'dart:async';

import 'package:provider/provider.dart';

class ChatArchivebyConsultant extends StatefulWidget {
  const ChatArchivebyConsultant(
      {super.key,
        this.profilePicture,
        this.braintype,
        this.participantName,
        this.typeConsultation,
        this.type,
        this.bloodType,
        this.rate,
        this.consultationTime,
        this.remainingMinutes,
        this.theme,
        this.explanation,
        this.comisson,
        this.id_consultation,
        this.idDocument

      });
  final participantName;
  final braintype;
  final typeConsultation;
  final bloodType;
  final rate;
  final comisson;
  final theme;
  final explanation;
  final consultationTime;
  final type;
  final remainingMinutes;
  final id_consultation;
  final profilePicture;
  final idDocument;

  @override
  _ChatArchivebyConsultantState createState() => _ChatArchivebyConsultantState();
}

class _ChatArchivebyConsultantState extends State<ChatArchivebyConsultant> {
  List<Map<String, String>> messages = [
    {
      "text":
      "Sejelek apapun masa lalumu, itu telah berlalu. Sekarang, fokus untuk kebahagiaan dirimu di masa depan.",
      "sender": "bot"
    },
    {"text": "Bagaimana bisa itu ya?", "sender": "user"},
    {
      "text":
      "Ketika kamu merasa kehilangan harapan, ingat bahwa Tuhan telah menciptakan rencana terindah untuk hidup kita.",
      "sender": "bot"
    },
    {"text": "Makasih ya", "sender": "user"},
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ConsultantProvider>(context, listen: false)
          .getChatArchived(context, widget.idDocument);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ConsultantProvider>(builder: (context, value, child) {
      String sender = dataGlobal.dataUser!.email;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.theme,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.red,
                    width: 5,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: Text(S.of(context).Archives,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: Color(0xFFBBE9FA),
            height: 100,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  ClipOval(
                    child: Image.network(
                      widget.profilePicture,
                      height: 90,
                      width: 90,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(widget.participantName,
                              style: TextStyle(fontWeight: FontWeight.w600)),
                          SizedBox(
                            width: 40,
                          ),
                          Text(
                            widget.braintype,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.orange,
                              fontSize: 15,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.consultationTime,
                        style: TextStyle(color: BlueColor),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                color: Colors.red[50],
                padding: EdgeInsets.all(10),
                child: Text(
                  S.of(context).Session_Closed_Message , style:
                  TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          SizedBox(
            height: 50,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: value.isLoadingChatArchived
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                itemCount: value.chatArchivedData?.data.length ?? 0,
                itemBuilder: (context, index) {
                  final message = value.chatArchivedData!.data[index];

                  // ⚡ Bandingkan EMAIL pengirim vs email user login
                  final isUser = message.senderEmail == sender;

                  return Align(
                    alignment:
                    isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: isUser ? Colors.blue[100] : Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(message.messageContent),
                    ),
                  );
                },
              ),
            ),
          )

        ],
      ),
    );
  },);
  }
}
