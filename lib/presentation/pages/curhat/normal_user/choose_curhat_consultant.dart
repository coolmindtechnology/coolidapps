import 'package:coolappflutter/generated/l10n.dart';

import 'package:coolappflutter/presentation/pages/curhat/card_curhat.dart';
import 'package:coolappflutter/presentation/pages/curhat/normal_user/choose_session.dart';
import 'package:coolappflutter/presentation/pages/curhat/normal_user/form_curhat.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/widgets/GlobalButton.dart';
import 'package:coolappflutter/presentation/widgets/costum_floatingbutton.dart';
import 'package:flutter/material.dart';

import '../../konsultasi/normal_user/profile_card.dart';

class ChooseCurhatConsultant extends StatefulWidget {
  const ChooseCurhatConsultant({super.key});

  @override
  State<ChooseCurhatConsultant> createState() => _ChooseCurhatConsultantState();
}

class _ChooseCurhatConsultantState extends State<ChooseCurhatConsultant> {
  // Menyimpan indeks item yang dipilih
  int? _selectedIndex;

  final List<Map<String, dynamic>> profileData = [
    {
      "imagePath": 'images/konsultasi/profile2.png',
      "name": 'John Doe',
      "title": 'Strategist',
      "bloodType": 'O',
      "location": 'Jakarta, Indonesia',
      "time": '10:00 - 10:30',
      "timeRemaining": '345 Sesi Selesai',
    },
    {
      "imagePath": 'images/konsultasi/profile1.png',
      "name": 'Vivian Entira',
      "title": 'Creative',
      "bloodType": 'B',
      "location": 'Cirebon, Jawa Barat',
      "time": '09:00 - 09:30',
      "timeRemaining": '345 Sesi Selesai',
    },
    {
      "imagePath": 'images/konsultasi/profile3.png',
      "name": 'Alice Smith',
      "title": 'Innovator',
      "bloodType": 'A',
      "location": 'Surabaya, Jawa Timur',
      "time": '11:00 - 11:30',
      "timeRemaining": '345 Sesi Selesai',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).Pick_Consultant,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: BlueColor,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              S.of(context).Choose_your_consultant,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(fontSize: 14.0, color: Colors.black54),
            ),
            SizedBox(height: 16.0),
            CardCurhat(
              CurhatTimeSelected: '09.00 - 09.30',
              onTap: () {
                Nav.to(ChooseSession());
              },
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 400,
              child: ListView.builder(
                itemCount: profileData.length,
                itemBuilder: (context, index) {
                  final profile = profileData[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = index; // Set indeks yang dipilih
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: _selectedIndex == index
                              ? BlueColor // Warna biru untuk item yang dipilih
                              : Colors.transparent,
                          width: 3, // Ketebalan border
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ProfileCard(
                        imagePath: profile['imagePath'],
                        name: profile['name'],
                        title: profile['title'],
                        bloodType: profile['bloodType'],
                        location: profile['location'],
                        time: profile['time'],
                        timeRemaining: profile['timeRemaining'],
                        timeColor: BlueColor,
                        status: S.of(context).Achievement,
                        warnastatus: Colors.white,
                        onTap: profile['onTap'], // Aksi jika ada
                      ),
                    ),
                  );
                },
              ),
            ),
            Spacer(),
            GlobalButton(
              onPressed: () {
                Nav.to(FormCurhat());
              },
              color: primaryColor,
              text: S.of(context).next,
            ),
          ],
        ),
      ),
      floatingActionButton: const CustomFAB(),
    );
  }
}
