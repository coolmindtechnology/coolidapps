import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/Normal_User/non_konsultasi.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/konsultant/chat/New_Chat.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/normal_user/chat/New_UserChat.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ProviderConsultation>(builder: (context, provider, child) {
        if (provider.isLoadingConsultation) {
          return Center(child: CircularProgressIndicator());
        }

        final consultations = provider.consultations;
        if (consultations.isEmpty) {
          return const Center(child: NoneKonsul());
        }

        return ListView.builder(
          itemCount: provider.consultations.length,
          itemBuilder: (context, index) {
            final consultation = consultations[index];
            final sessionStart = consultation.sessionStart?.substring(0, 5) ?? '-';
            final sessionEnd = consultation.sessionEnd?.substring(0, 5) ?? '-';

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
                int remainingMinutes = 0;
                if (consultation.remainingMinutes is int) {
                  remainingMinutes = consultation.remainingMinutes as int;
                } else if (consultation.remainingMinutes is String) {
                  remainingMinutes = int.tryParse(consultation.remainingMinutes as String) ?? 0;
                }

                if (remainingMinutes == 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailConsultant(
                        user: null,
                        idUser: consultation.id.toString(),
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
                        deskripsi: consultation.explanation.toString(),
                        idConsultation: consultation.id.toString(),
                        idConsultant: consultation.consultantId.toString(),
                        idreciver: consultation.firebaseConf?.consultantIds.toString() ?? '-',
                      ),
                    ),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Sesi Belum Dimulai"),
                      content: Text(
                        "Sesi akan dimulai dalam ${consultation.remainingMinutes.toString()} menit. Silakan tunggu!",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("OK"),
                        ),
                      ],
                    ),
                  );
                }
              },
            );
          },
        );
      }),
    );
  }
}
