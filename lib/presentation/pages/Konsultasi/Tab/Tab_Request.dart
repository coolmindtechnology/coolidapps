import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/Detil_Consultant.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/Profile_Card.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/Profile_Consultant.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabRequest extends StatefulWidget {
  const TabRequest({super.key});

  @override
  State<TabRequest> createState() => _TabRequestState();
}

class _TabRequestState extends State<TabRequest> {

  final List<Map<String, dynamic>> profileData = [
    {
      "imagePath": 'images/konsultasi/profile2.png',
      "name": 'John Doe',
      "title": 'Strategist',
      "bloodType": 'O',
      "location": 'Jakarta, Indonesia',
      "time": '10:00 - 10:30',
      "timeRemaining": 'Dimulai dalam',
    },
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
      "imagePath": 'images/konsultasi/profile3.png',
      "name": 'Alice Smith',
      "title": 'Innovator',
      "bloodType": 'A',
      "location": 'Surabaya, Jawa Timur',
      "time": '11:00 - 11:30',
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
            timeRemaining: S.of(context).Accepted,
            timeColor: Colors.green,
            status: S.of(context).Status,
            warnastatus: Colors.lightGreen.shade100,
            onTap: () {
              Nav.to(ProfileConsultant(

              ));
            }, // Aksi jika ada
          );
        },
      ),

    );
  }
}
