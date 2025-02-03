import 'package:coolappflutter/data/provider/provider_consultation.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/normal_user/detil_consultant.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';

import 'package:flutter/material.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:provider/provider.dart';

import '../profile_card.dart';

class TabArsip extends StatefulWidget {
  const TabArsip({super.key});

  @override
  State<TabArsip> createState() => _TabArsipState();
}

class _TabArsipState extends State<TabArsip> {
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
  void initState() {
    Provider.of<ProviderConsultation>(context, listen: false)
        .getListConsultations(context, "archive");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ProviderConsultation>(builder: (context, provider, child) {
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
              timeRemaining:
                  '${consultation.remainingMinutes ?? '-'} ${S.of(context).Minutes_Left}',
              timeColor: BlueColor,
              status: S.of(context).Completed_On,
              warnastatus: Colors.lightBlueAccent.shade100,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailConsultant(
                            imagePath: consultation.consultantImage ?? '-',
                            name: consultation.consultantName ?? '-',
                            title: consultation.consultantTypeBrain ?? '-',
                            bloodType: consultation.consultantBloodType ?? '-',
                            location: consultation.consultantAddress ?? '-',
                            time: "${consultation.timeSelected}",
                            timeRemaining:
                                '${consultation.remainingMinutes ?? '-'} ${S.of(context).Minutes_Left}',
                            timeColor: BlueColor,
                            status: consultation.status.toString(),
                            warnastatus: Colors.lightBlueAccent.shade100,
                            getTopik: consultation.theme.toString(),
                            statusSession:
                                consultation.sessionStatus.toString(),
                            deskripsi: consultation.explanation.toString())));
              }, // Aksi jika ada
            );
          },
        );
      }),
    );
  }
}
