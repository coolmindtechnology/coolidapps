import 'package:coolappflutter/generated/l10n.dart';

import 'package:coolappflutter/presentation/pages/curhat/normal_user/card_curhat_consultant.dart';
import 'package:coolappflutter/presentation/pages/curhat/normal_user/detail_session.dart';

import 'package:coolappflutter/presentation/utils/nav_utils.dart';

import 'package:flutter/material.dart';

class TabSesiCurhat extends StatefulWidget {
  const TabSesiCurhat({super.key});

  @override
  State<TabSesiCurhat> createState() => _TabSesiCurhatState();
}

class _TabSesiCurhatState extends State<TabSesiCurhat> {
  final List<Map<String, dynamic>> profileData = [
    {
      "imagePath": 'images/konsultasi/profile3.png',
      "name": 'Alice Smith',
      "title": 'Innovator',
      "timeRemaining": '11',
      "subtitle":
          'Membuka usaha sendiri tidak butuh ijazah dan latar belakang pendidikan management'
    },
    {
      "imagePath": 'images/konsultasi/profile1.png',
      "name": 'Vivian Entira',
      "title": 'Creative',
      "timeRemaining": '10',
      "subtitle":
          'Membuka usaha sendiri tidak butuh ijazah dan latar belakang pendidikan management'
    },
    {
      "imagePath": 'images/konsultasi/profile2.png',
      "name": 'John Doe',
      "title": 'Strategist',
      "timeRemaining": '10',
      "subtitle":
          'Membuka usaha sendiri tidak butuh ijazah dan latar belakang pendidikan management'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: profileData.length,
        itemBuilder: (context, index) {
          final profile = profileData[index];
          return Column(
            children: [
              CurhatConsultantCrad(
                imagePath: profile['imagePath'],
                name: profile['name'],
                title: profile['title'],
                subtitle: profile['subtitle'],
                timeRemaining:
                    profile['timeRemaining'] + ' ' + S.of(context).Minutes_Left,
                onTap: () {
                  Nav.to(DetailSessionCurhat());
                }, // Aksi jika ada
              ),
            ],
          );
        },
      ),
    );
  }
}
