import 'package:coolappflutter/generated/l10n.dart';

import 'package:flutter/material.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';

import '../../../konsultasi/normal_user/profile_card.dart';

class TabArsipCurhat extends StatefulWidget {
  const TabArsipCurhat({super.key});

  @override
  State<TabArsipCurhat> createState() => _TabArsipCurhatState();
}

class _TabArsipCurhatState extends State<TabArsipCurhat> {
  // Array data untuk ProfileCard
  final List<Map<String, dynamic>> profileData = [
    {
      "imagePath": 'images/konsultasi/profile1.png',
      "name": 'Vivian Entira',
      "title": 'Creative',
      "bloodType": 'B',
      "location": 'Cirebon, Jawa Barat',
      "time": '09:00 - 09:30',
      "timeRemaining": '20 August 2024 / 10:00 - 10:30',
    },
    {
      "imagePath": 'images/konsultasi/profile2.png',
      "name": 'John Doe',
      "title": 'Strategist',
      "bloodType": 'O',
      "location": 'Jakarta, Indonesia',
      "time": '10:00 - 10:30',
      "timeRemaining": '22 August 2024 / 12:00 - 12:30',
    },
    {
      "imagePath": 'images/konsultasi/profile3.png',
      "name": 'Alice Smith',
      "title": 'Innovator',
      "bloodType": 'A',
      "location": 'Surabaya, Jawa Timur',
      "time": '11:00 - 11:30',
      "timeRemaining": '22 August 2024 / 12:00 - 12:30',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: profileData.length,
        itemBuilder: (context, index) {
          final profile = profileData[index];
          return ProfileCard(
            imagePath: profile['imagePath'],
            name: profile['name'],
            title: profile['title'],
            bloodType: profile['bloodType'],
            location: profile['location'],
            time: profile['time'],
            timeRemaining: profile['timeRemaining'],
            timeColor: BlueColor,
            status: S.of(context).Completed_On,
            warnastatus: Colors.white,
            onTap: () {}, // Aksi jika ada
          );
        },
      ),
    );
  }
}
