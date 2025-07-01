import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/Normal_User/profile_consultant.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/normal_user/chat/firebase_chat/rating_chat.dart';

import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/widgets/GlobalButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'card_consultant.dart';
import 'chat/chat_archive.dart';
import 'profile_card.dart';
import 'rating.dart';

class ArsipConsultant extends StatefulWidget {
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
  final types.User? user;
  final String? idConsultant;
  final String? idConsultation;
  final String? idreciver;
  final dynamic? price;
  final String? type;
  final String? idDocument;
  final dynamic? rating;
  const ArsipConsultant({super.key,
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
    required this.price,
    required this.rating,
    required this.idDocument,
    this.user, required this.idConsultant,required this.idConsultation,required this.idreciver, this.type,});

  @override
  State<ArsipConsultant> createState() => _ArsipConsultantState();
}

class _ArsipConsultantState extends State<ArsipConsultant> {
  bool isConfirmed = false;
  int _selectedRating = 0;

  @override
  void initState() {
    super.initState();
    _selectedRating = (widget.rating ?? 0).toInt();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          S.of(context).Session_Archived,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.lightBlue.shade100,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.of(context).Status,
                      style: TextStyle(
                          color: BlueColor, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      S.of(context).Archives,
                      style: TextStyle(
                          color: BlueColor, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Nav.to(ProfileConsultant(id : widget.idConsultant.toString()));
              },
              child: ProfileCard(
                imagePath: widget.imagePath,
                name: widget.name,
                title: widget.title,
                bloodType: widget.bloodType,
                location: widget.location,
                time: widget.time,
                timeRemaining: '',
                timeColor: widget.timeColor,
                status: '',
                warnastatus: Colors.white,
              ),
            ),
            SizedBox(height: 16.0),
            CardConsultant(
              topic: S.of(context).Selected_topic,
              topicSelected: widget.getTopik,
              consultationTime: S.of(context).Consultation_time,
              consultationTimeSelected: widget.time,
            ),
            SizedBox(
              height: 20,
            ),
            Text(S.of(context).Your_Explanation),
            gapH10,
            TextField(
              enabled: false,
              maxLines: 5,
              decoration: InputDecoration(
                  hintText: widget.deskripsi,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey.shade300))),
            ),
            SizedBox(
              height: 10,
            ),
            widget.rating == 0
                ? InkWell(
              onTap: () {
                Nav.to(RatingChat(consultanId: widget.idConsultant.toString(),consultationId: widget.idConsultation.toString(),));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).Give_Rating,
                  ),
                  Icon(CupertinoIcons.forward)
                ],
              ),
            )
                : Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(5, (index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.star,
                    color: index < widget.rating ? Colors.yellow : Colors.grey,
                    size: 40,
                  ),
                );
              }),
            ),
            SizedBox(
              height: 30,
            ),
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
                        Text(
                          (widget.price == 0 || widget.price == '0' || widget.price == 0.0)
                              ? S.of(context).free
                              : widget.price.toString(),
                        )
                      ],
                    ),
                    Divider(
                      color: BlueColor,
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            SizedBox(
              height: 10,
            ),
            GlobalButton(
                onPressed: () {
                  Nav.to(ChatArchive(
                    idDocument: widget.idDocument,
                    rating : widget.rating,
                    type: widget.type,
                    price: widget.price?.toString() ?? "Free",
                    idUser: widget.idUser.toString(),
                    imagePath: widget.imagePath ?? '-',
                    name: widget.name ?? '-',
                    title: widget.title ?? '-',
                    bloodType: widget.bloodType ?? '-',
                    location: widget.location ?? '-',
                    time: widget.time,
                    timeRemaining: widget.timeRemaining,
                    timeColor: BlueColor,
                    status: widget.status,
                    warnastatus: Colors.lightBlueAccent.shade100,
                    getTopik: widget.getTopik,
                    statusSession:
                    widget.statusSession.toString(),
                    deskripsi:
                    widget.deskripsi,
                    idConsultation: widget.idConsultation,
                    idConsultant: widget.idConsultant,
                    idreciver: widget.idreciver,

                  ));
                },
                color: Colors.red,
                text: S.of(context).View_Archive)
          ],
        ),
      ),
    );
  }
}
