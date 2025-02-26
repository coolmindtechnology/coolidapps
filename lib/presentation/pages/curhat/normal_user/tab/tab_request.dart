import 'package:coolappflutter/data/provider/provider_consultation.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/Normal_User/profile_consultant.dart';
import 'package:coolappflutter/presentation/pages/curhat/card_status.dart';

import 'package:coolappflutter/presentation/utils/nav_utils.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    return Scaffold(body:
        Consumer<ProviderConsultation>(builder: (context, provider, child) {
      if (provider.isLoading) {
        return Center(child: CircularProgressIndicator());
      }

      final consultations = provider.consultations;
      if (consultations.isEmpty) {
        return Center(child: Text('No consultations available'));
      }

      return ListView.builder(
          itemCount: consultations.length,
          itemBuilder: (context, index) {
            final consultation = consultations[index];
            final sessionStart =
                consultation.sessionStart?.substring(0, 5) ?? '-';
            final sessionEnd = consultation.sessionEnd?.substring(0, 5) ?? '-';
            // final profile = profileData[index];
            return ProfileCard(
              imagePath: consultation.consultantImage ?? '-',
              name: consultation.consultantName ?? '-',
              title: consultation.consultantTypeBrain ?? '-',
              bloodType: consultation.consultantBloodType ?? '-',
              location: consultation.consultantAddress ?? '-',
              time: "${consultation.timeSelected}",
              timeRemaining: consultation.sessionStatus,
              // '${consultation.remainingMinutes ?? '-'} ${S.of(context).Minutes_Left}',
              timeColor: Colors.green,
              status: S.of(context).Status,
              warnastatus: Colors.lightGreen.shade100,
              onTap: () {
                Nav.to(ProfileConsultant());
              }, // Aksi jika ada
            );
          });
    }));
  }
}
