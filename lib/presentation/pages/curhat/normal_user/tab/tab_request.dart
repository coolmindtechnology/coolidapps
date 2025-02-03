import 'package:coolappflutter/presentation/pages/Konsultasi/Normal_User/profile_consultant.dart';
import 'package:coolappflutter/presentation/pages/curhat/card_status.dart';

import 'package:coolappflutter/presentation/utils/nav_utils.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../konsultasi/normal_user/profile_card.dart';

class TabRequestCurhat extends StatefulWidget {
  const TabRequestCurhat({super.key});

  @override
  State<TabRequestCurhat> createState() => _TabRequestCurhatState();
}

class _TabRequestCurhatState extends State<TabRequestCurhat> {
  final List<Map<String, dynamic>> profileData = [
    {
      "imagePath": 'images/konsultasi/profile2.png',
      "name": 'John Doe',
      "title": 'Strategist',
      "bloodType": 'O',
      "location": 'Cirebon, jawabarat',
      "time": '10:00 - 10:30',
      "timeRemaining": 'Dimulai dalam',
      "request": 'Diterima',
    },
    {
      "imagePath": 'images/konsultasi/profile1.png',
      "name": 'Vivian Entira',
      "title": 'Creative',
      "bloodType": 'B',
      "location": 'Manado, Sulawesi Utara ',
      "time": '09:00 - 09:30',
      "timeRemaining": '20 August 2024 / 10:00 - 10:30',
      "request": 'Menunggu',
    },
    {
      "imagePath": 'images/konsultasi/profile3.png',
      "name": 'Alice Smith',
      "title": 'Innovator',
      "bloodType": 'A',
      "location": 'Batam , Kepulauan Riau',
      "time": '11:00 - 11:30',
      "request": 'Ditolak'
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
              ProfileCard(
                imagePath: profile['imagePath'],
                name: profile['name'],
                title: profile['title'],
                bloodType: profile['bloodType'],
                location: profile['location'],
                time: profile['time'],
                timeRemaining: profile['status'],
                timeColor: Colors.green,
                warnastatus: Colors.lightGreen.shade100,
                onTap: () {
                  Nav.to(ProfileConsultant());
                }, // Aksi jika ada
              ),
              StatusContainer(
                dataRequest: profile['request'],
              )
            ],
          );
        },
      ),
    );
  }
}
