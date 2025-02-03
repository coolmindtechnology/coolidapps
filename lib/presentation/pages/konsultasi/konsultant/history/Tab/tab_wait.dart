import 'package:coolappflutter/data/provider/provider_consultant.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/Normal_User/non_konsultasi.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/konsultant/detail_session.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/konsultant/detail_waiting.dart';
import 'package:provider/provider.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/Normal_User/detil_consultant.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/Normal_User/profile_card.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/widgets/Container/container_status.dart';
import 'package:flutter/material.dart';

class TabHisotryWaiting extends StatefulWidget {
  final String type; // Tambahkan parameter type

  const TabHisotryWaiting({super.key, required this.type});

  @override
  State<TabHisotryWaiting> createState() => _TabHisotryWaitingState();
}

class _TabHisotryWaitingState extends State<TabHisotryWaiting> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ConsultantProvider>(context);

    // Filter peserta berdasarkan parameter type yang diberikan
    final filteredParticipants = provider.listParticipant
        .where((participant) => participant.type == widget.type)
        .toList();

    return Scaffold(
      body: provider.isLoadingParticipant
          ? const Center(child: CircularProgressIndicator())
          : filteredParticipants.isEmpty
          ? Center(child: NoneKonsul()) // Jika tidak ada data yang sesuai
          : ListView.builder(
        itemCount: filteredParticipants.length,
        itemBuilder: (context, index) {
          final participant = filteredParticipants[index];
          return Column(
            children: [
              ProfileCard(
                imagePath: participant.profilePicture,
                name: participant.participantName ?? '',
                title: participant.personalityType ?? '',
                bloodType: participant.bloodType ?? 'Unknown',
                location: participant.theme ?? 'No theme',
                time: participant.consultationTime ?? '',
                timeRemaining:
                '${participant.remainingMinutes ?? "0"} ${S.of(context).Minutes_Left}',
                timeColor: BlueColor,
                warnastatus: Colors.lightBlueAccent.shade100,
                onTap: () {
                  Nav.to(DetailWaitingPage(
                    consultationTime: participant.consultationTime,
                    bloodType: participant.bloodType,
                    id_consultation: participant.consultationId,
                    participantName: participant.participantName,
                    remainingMinutes: participant.remainingMinutes,
                    theme: participant.theme,
                    type: participant.type,
                    typeConsultation: participant.typeConsultation,
                    profilePicture: participant.profilePicture,
                    explanation: participant.participantExplanation,
                  ));
                },
              ),
              RequestContainer(
                dataRequest: participant.type ?? '',
              ),
              const Divider(),
            ],
          );
        },
      ),
    );
  }
}
