import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/Arsip_Consultant.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/Profile_Card.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:flutter/material.dart';

class HistoryConsultant extends StatefulWidget {
  const HistoryConsultant({super.key});

  @override
  State<HistoryConsultant> createState() => _HistoryConsultantState();
}

class _HistoryConsultantState extends State<HistoryConsultant> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).Consultation_History ,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ProfileCard(
              onTap: () {
                Nav.to(ArsipConsultant());
              },
                imagePath: 'images/konsultasi/profile1.png',
                name: 'vivian Entira',
                title: 'Creative',
                bloodType: 'B',
                location: 'Cirebon, jawa barat',
                time: '09,00 - 0.9.30 ',
                timeRemaining: '20 August 2024 / 10:00 - 10:30',
                timeColor: BlueColor,
                status: 'Selesai Pada',
                warnastatus: Colors.lightBlueAccent.shade100),
            ProfileCard(
                imagePath: 'images/konsultasi/profile1.png',
                name: 'vivian Entira',
                title: 'Creative',
                bloodType: 'B',
                location: 'Cirebon, jawa barat',
                time: '09,00 - 0.9.30 ',
                timeRemaining: '20 August 2024 / 10:00 - 10:30',
                timeColor: BlueColor,
                status: 'Selesai Pada',
                warnastatus: Colors.lightBlueAccent.shade100),
          ],
        ),
      ),
    );
  }
}
