import 'package:coolappflutter/data/apps/app_assets.dart';

import 'package:coolappflutter/presentation/pages/curhat/card_curhat.dart';
import 'package:coolappflutter/presentation/pages/curhat/normal_user/chat/chat_curhat_archive.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/widgets/GlobalButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';
import '../../Konsultasi/Normal_User/profile_consultant.dart';
import '../../konsultasi/normal_user/profile_card.dart';
import 'rating_curhat.dart';

class ArsipCurhat extends StatefulWidget {
  const ArsipCurhat({super.key});

  @override
  State<ArsipCurhat> createState() => _ArsipCurhatState();
}

class _ArsipCurhatState extends State<ArsipCurhat> {
  bool isConfirmed = false;
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
            ProfileCard(
                onTap: () {
                  Nav.to(ProfileConsultant());
                },
                imagePath: AppAsset.imgProfile1,
                name: 'vivian Entira',
                title: 'Creative',
                bloodType: 'B',
                location: 'Cirebon, jawa barat',
                time: '09,00 - 0.9.30 ',
                timeRemaining: '345 Sesi Selesai',
                timeColor: BlueColor,
                status: 'Pencapaian ',
                warnastatus: Colors.white),
            SizedBox(height: 16.0),
            CardCurhat(
              CurhatTimeSelected: '09.00 - 09.30',
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(S.of(context).Your_Explanation),
                Icon(CupertinoIcons.forward)
              ],
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Nav.to(RatingCurhat());
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
                        Text('IDR 200.000'),
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
                  Nav.to(ChatCurhatArchive());
                },
                color: Colors.red,
                text: S.of(context).View_Archive)
          ],
        ),
      ),
    );
  }
}
