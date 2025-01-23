import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/Rating.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:permission_handler/permission_handler.dart';

import 'dart:async';

class ChatArchive extends StatefulWidget {
  const ChatArchive({super.key});

  @override
  _ChatArchiveState createState() => _ChatArchiveState();
}

class _ChatArchiveState extends State<ChatArchive> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).PARENTING,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
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
                  child: Text(
                    S.of(context).Archives,
                    style: const TextStyle(
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
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              height: 100,
              child: Row(
                children: [
                  ClipOval(
                    child: Image.asset(
                      'images/konsultasi/profile1.png',
                      height: 90,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    children: [
                      const Row(
                        children: [
                          Text('Viviana Entira',
                              style: TextStyle(fontWeight: FontWeight.w600)),
                          SizedBox(
                            width: 40,
                          ),
                          Text(
                            'Creative',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.orange,
                              fontSize: 15,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                          decoration: BoxDecoration(
                              color: BlueColor,
                              borderRadius: BorderRadius.circular(10)),
                          height: 40,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(
                                  S.of(context).PARENTING,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                const Text(
                                  '09.00 - 09.30',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          )),
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
              padding: const EdgeInsets.all(10),
              child: Text(
                S.of(context).Session_Closed_Message,
                style: const TextStyle(
                    color: Colors.red, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  bool isUser = messages[index]['sender'] == 'user';
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
                      child: Text(messages[index]['text']!),
                    ),
                  );
                },
              ),
            ),
          ),
          Center(
            child: TextButton(
              onPressed: () {
                Nav.to(const Rating());
              },
              child: Text(S.of(context).Add_Session),
            ),
          ),
        ],
      ),
    );
  }
}
