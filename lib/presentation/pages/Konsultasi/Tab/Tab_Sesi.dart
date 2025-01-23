import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/Detil_Consultant.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/Profile_Card.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/non_konsultasi.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:flutter/material.dart';

class TabSesi extends StatefulWidget {
  const TabSesi({super.key});

  @override
  State<TabSesi> createState() => _TabSesiState();
}

class _TabSesiState extends State<TabSesi> {
  final List<Map<String, dynamic>> profileData = [
    {
      "imagePath": 'images/konsultasi/profile3.png',
      "name": 'Alice Smith',
      "title": 'Innovator',
      "bloodType": 'A',
      "location": 'Surabaya, Jawa Timur',
      "time": '11:00 - 11:30',
      "timeRemaining": '11',
    },
    {
      "imagePath": 'images/konsultasi/profile1.png',
      "name": 'Vivian Entira',
      "title": 'Creative',
      "bloodType": 'B',
      "location": 'Cirebon, Jawa Barat',
      "time": '09:00 - 09:30',
      "timeRemaining": '10',
      "timeColor": Colors.green,
      "status": 'status',
    },
    {
      "imagePath": 'images/konsultasi/profile2.png',
      "name": 'John Doe',
      "title": 'Strategist',
      "bloodType": 'O',
      "location": 'Jakarta, Indonesia',
      "time": '10:00 - 10:30',
      "timeRemaining": '10',
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
            timeRemaining: profile['timeRemaining'] + ' '+ S.of(context).Minutes_Left,
            timeColor: BlueColor,
            status: S.of(context).Session_Begins_In,
            warnastatus: Colors.lightBlueAccent.shade100,
            onTap: () {
              Nav.to(DetailConsultant(

              ));
            }, // Aksi jika ada
          );
        },
      ),
    );
  }
}
