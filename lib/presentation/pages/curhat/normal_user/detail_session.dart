import 'package:coolappflutter/data/apps/app_assets.dart';
import 'package:coolappflutter/generated/l10n.dart';

import 'package:coolappflutter/presentation/pages/Konsultasi/Normal_User/profile_consultant.dart';

import 'package:coolappflutter/presentation/pages/curhat/normal_user/chat/chatbox_curhat.dart';
import 'package:coolappflutter/presentation/pages/payments/payment_page.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';

import 'package:coolappflutter/presentation/widgets/GlobalButton.dart';
import 'package:coolappflutter/presentation/widgets/costum_floatingbutton.dart';
import 'package:flutter/material.dart';

import '../../konsultasi/normal_user/pop-upwarning.dart';
import '../../konsultasi/normal_user/profile_card.dart';
import '../card_curhat.dart';

class DetailSessionCurhat extends StatefulWidget {
  const DetailSessionCurhat({super.key});

  @override
  State<DetailSessionCurhat> createState() => _DetailSessionCurhatState();
}

class _DetailSessionCurhatState extends State<DetailSessionCurhat> {
  bool isConfirmed = false;
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
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.of(context).Status,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: BlueColor, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      S.of(context).Accepted,
                      overflow: TextOverflow.ellipsis,
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
            TextField(
              maxLines: 5,
              decoration: InputDecoration(
                  hintText: S.of(context).Why_Need_Consultant,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey.shade300))),
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
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      // Timer untuk navigasi otomatis setelah 3 detik
                      Future.delayed(Duration(seconds: 3), () {
                        Nav.toAll(ChatCurhatPage(
                          status: true,
                        )); // Ganti ke rute tujuan
                      });

                      return Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: SizedBox(height: 380, child: WarningPopup()),
                      );
                    },
                  );
                },
                color: primaryColor,
                text: S.of(context).next),
            SizedBox(
              height: 10,
            ),
            GlobalButton(
                onPressed: () {
                  Nav.to(PaymentPage());
                },
                color: primaryColor,
                text: S.of(context).Pay_Now)
          ],
        ),
      ),
      floatingActionButton: const CustomFAB(),
    );
  }
}
