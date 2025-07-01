import 'package:coolappflutter/generated/l10n.dart';

import 'package:coolappflutter/presentation/pages/curhat/normal_user/arsip_curhat.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/widgets/costum_floatingbutton.dart';
import 'package:flutter/material.dart';

import '../../konsultasi/normal_user/profile_card.dart';

class Archive_Curhat extends StatefulWidget {
  const Archive_Curhat({super.key});

  @override
  State<Archive_Curhat> createState() => _Archive_CurhatState();
}

class _Archive_CurhatState extends State<Archive_Curhat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).Confession_History,
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
                  Nav.to(ArsipCurhat());
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
      floatingActionButton: const CustomFAB(),
    );
  }
}
