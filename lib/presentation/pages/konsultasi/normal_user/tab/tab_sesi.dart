import 'package:coolappflutter/generated/l10n.dart';

import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../data/provider/provider_consultation.dart';
import '../detil_consultant.dart';
import '../profile_card.dart';

class TabSesi extends StatefulWidget {
  const TabSesi({super.key});

  @override
  State<TabSesi> createState() => _TabSesiState();
}

class _TabSesiState extends State<TabSesi> {
  @override
  void initState() {
    Provider.of<ProviderConsultation>(context, listen: false)
        .getListConsultations(context, "active");
    super.initState();
  }
  // final List<Map<String, dynamic>> profileData = [
  //   {
  //     "imagePath": 'images/konsultasi/profile3.png',
  //     "name": 'Alice Smith',
  //     "title": 'Innovator',
  //     "bloodType": 'A',
  //     "location": 'Surabaya, Jawa Timur',
  //     "time": '11:00 - 11:30',
  //     "timeRemaining": '11',
  //   },
  //   {
  //     "imagePath": 'images/konsultasi/profile1.png',
  //     "name": 'Vivian Entira',
  //     "title": 'Creative',
  //     "bloodType": 'B',
  //     "location": 'Cirebon, Jawa Barat',
  //     "time": '09:00 - 09:30',
  //     "timeRemaining": '10',
  //     "timeColor": Colors.green,
  //     "status": 'status',
  //   },
  //   {
  //     "imagePath": 'images/konsultasi/profile2.png',
  //     "name": 'John Doe',
  //     "title": 'Strategist',
  //     "bloodType": 'O',
  //     "location": 'Jakarta, Indonesia',
  //     "time": '10:00 - 10:30',
  //     "timeRemaining": '10',
  //   },
  // ];

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
            timeRemaining:
                '${consultation.remainingMinutes ?? '-'} ${S.of(context).Minutes_Left}',
            timeColor: BlueColor,
            status: S.of(context).Session_Begins_In,
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
                          statusSession: consultation.sessionStatus.toString(),
                          deskripsi: consultation.explanation.toString())));
            }, // Aksi jika ada
          );
        },
      );
    }));
  }
}
