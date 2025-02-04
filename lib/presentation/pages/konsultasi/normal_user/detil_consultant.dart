import 'package:coolappflutter/presentation/pages/konsultasi/normal_user/chat/firebase_chat/rooms.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/normal_user/pop-upwarning.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/widgets/GlobalButton.dart';
import 'card_consultant.dart';

import 'profile_card.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/normal_user/chat/firebase_chat/chat.dart';

class DetailConsultant extends StatefulWidget {
  final String imagePath;
  final String name;
  final String title;
  final String bloodType;
  final String location;
  final String time;
  final String timeRemaining;
  final Color timeColor;
  final String status;
  final Color warnastatus;
  final String getTopik;
  final String statusSession;
  final String deskripsi;
  final String idUser;
  final dynamic user;

  const DetailConsultant({
    super.key,
    required this.imagePath,
    required this.name,
    required this.title,
    required this.bloodType,
    required this.location,
    required this.time,
    required this.timeRemaining,
    required this.timeColor,
    required this.status,
    required this.warnastatus,
    required this.getTopik,
    required this.statusSession,
    required this.deskripsi,
    required this.idUser,
    this.user,
  });

  @override
  State<DetailConsultant> createState() => _DetailConsultantState();
}

class _DetailConsultantState extends State<DetailConsultant> {
  bool isConfirmed = false;
  TextEditingController deskripsiText = TextEditingController();
  @override
  void initState() {
    deskripsiText.text = widget.deskripsi.toString();
    super.initState();
  }

  void _handlePressed(types.User otherUser, BuildContext context) async {
    final navigator = Navigator.of(context);
    final room = await FirebaseChatCore.instance.createRoom(otherUser);
    debugPrint("cek id users ${room.id}");

    navigator.pop();
    await navigator.push(
      MaterialPageRoute(
        builder: (context) => ChatPage(
          idUser: widget.idUser,
          room: room,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          S.of(context).Session_Details,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).Review_Your_Session,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: BlueColor,
              ),
            ),
            SizedBox(height: 8.0),
            Container(
              width: double.infinity,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.lightBlue.shade100,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.of(context).Status,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: BlueColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      widget.statusSession,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: BlueColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            ProfileCard(
              imagePath: widget.imagePath,
              name: widget.name,
              title: widget.title,
              bloodType: widget.bloodType,
              location: widget.location,
              time: widget.time,
              timeRemaining: widget.timeRemaining,
              timeColor: widget.timeColor,
              status: widget.status,
              warnastatus: widget.warnastatus,
            ),
            SizedBox(height: 16.0),
            CardConsultant(
              topic: S.of(context).Selected_topic,
              topicSelected: widget.getTopik,
              consultationTime: S.of(context).Consultation_time,
              consultationTimeSelected: widget.time,
            ),
            SizedBox(height: 20),
            TextField(
              enabled: false,
              maxLines: 5,
              controller: deskripsiText,
              decoration: InputDecoration(
                // hintText: widget.deskripsi,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
            ),
            SizedBox(height: 30),
            Container(
              color: Colors.lightBlueAccent.shade100,
              height: 60,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(S.of(context).Price),
                        Text(S.of(context).FREE),
                      ],
                    ),
                    Divider(color: BlueColor),
                  ],
                ),
              ),
            ),
            Spacer(),
            SizedBox(height: 10),
            if (widget.statusSession.toString() != "waiting")
              GlobalButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      // debugPrint(widget.status);

                      if (widget.statusSession.toString() == "waiting") {
                        Navigator.pop(context);
                      } else {
                        Future.delayed(Duration(seconds: 3), () {
                          _handlePressed(widget.user, context);
                          // Nav.to(RoomsPage(idUser: widget.idUser));
                          // ChatPage(status: true),
                        });
                      }

                      return Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: SizedBox(height: 350, child: WarningPopup()),
                      );
                    },
                  );
                },
                color: primaryColor,
                text: widget.statusSession.toString() == "waiting"
                    ? S.of(context).back
                    : S.of(context).next,
              )
          ],
        ),
      ),
    );
  }
}
