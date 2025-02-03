import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:coolappflutter/data/provider/provider_consultant.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/Normal_User/non_konsultasi.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/Normal_User/profile_card.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/konsultant/detail_archive.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/widgets/Container/container_status.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:provider/provider.dart';

class TabHistoryArsip extends StatefulWidget {
  final String type; // Tambahkan parameter type

  const TabHistoryArsip({super.key, required this.type});

  @override
  _TabHistoryArsipState createState() => _TabHistoryArsipState();
}

class _TabHistoryArsipState extends State<TabHistoryArsip> {
  @override
  void initState() {
    super.initState();
    // Memanggil provider untuk mendapatkan semua peserta dengan parameter "archive"
    final provider = Provider.of<ConsultantProvider>(context, listen: false);
    provider.getParticipant(context, parameter: "archive");
  }

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
                  Nav.to(DetailArchivePage(
                    comisson: participant.amount,
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
                    rate: participant.rate,
                  ));
                },
              ),
              RequestContainer(
                dataRequest: participant.type ?? '',
              ),
              gapH10,
              RequestContainer(
                typeKeperluan: S.of(context).Completed_On,
                dataRequest: participant.consultationTime ?? "00.00",
              ),
              const Divider(),
            ],
          );
        },
      ),
    );
  }
}
