import 'package:coolappflutter/generated/l10n.dart';

import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/widgets/GlobalButton.dart';
import 'package:flutter/material.dart';

import 'card_consultant.dart';
import 'profile_card.dart';

class NotifikasiConsultant extends StatefulWidget {
  const NotifikasiConsultant({super.key});

  @override
  State<NotifikasiConsultant> createState() => _NotifikasiConsultantState();
}

class _NotifikasiConsultantState extends State<NotifikasiConsultant> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).Notification_Settings,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).Request_Accepted,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Image.asset('images/konsultasi/Ellipse 20.png'),
                Text('CoolTeam'),
                Icon(Icons.do_not_disturb_on_total_silence_outlined),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            ProfileCard(
                imagePath: 'images/konsultasi/profile1.png',
                name: 'vivian Entira',
                title: 'Creative',
                bloodType: 'B',
                location: 'Cirebon, jawa barat',
                time: '09,00 - 0.9.30 ',
                timeRemaining: '',
                timeColor: BlueColor,
                status: '',
                warnastatus: Colors.white),
            SizedBox(
              height: 10,
            ),
            CardConsultant(
              topic: S.of(context).Selected_topic,
              topicSelected: S.of(context).PERSONALITY,
              consultationTime: S.of(context).Consultation_time,
              consultationTimeSelected: '09.00 - 09.30',
            ),
            SizedBox(
              height: 10,
            ),
            Divider(),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(S.of(context).Consultant_Name),
                Text('fikri'),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(S.of(context).Session_Details),
                Text('09:00- 10:00'),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(S.of(context).Selected_topic),
                Text('fikri'),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(S.of(context).Price),
                Text('Free'),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            GlobalButton(
                onPressed: () {}, color: primaryColor, text: S.of(context).pay)
          ],
        ),
      ),
    );
  }
}
