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

class TabWaitKonsultant extends StatefulWidget {
  const TabWaitKonsultant({super.key});

  @override
  State<TabWaitKonsultant> createState() => _TabWaitKonsultantState();
}

class _TabWaitKonsultantState extends State<TabWaitKonsultant> {
  @override
  void initState() {
    super.initState();
    // Memanggil provider untuk mendapatkan semua peserta
    final provider = Provider.of<ConsultantProvider>(context, listen: false);
    provider.getParticipant(context, parameter: "unpaid");
  }
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ConsultantProvider>(context);
    return Scaffold(
      body: provider.isLoadingParticipant
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : provider.listParticipant.isEmpty
          ? Center(child: NoneKonsul())
          : ListView.builder(
        itemCount: provider.listParticipant.length,
        itemBuilder: (context, index) {
          final participant = provider.listParticipant[index];
          return Column(
            children: [
              ProfileCard(
                imagePath: participant.profilePicture, // Gambar profil
                name: participant.participantName ?? '', // Nama peserta
                title: participant.personalityType ?? '', // Jenis konsultasi
                bloodType: participant.bloodType ?? 'Unknown', // Golongan darah
                location: participant.theme ?? 'No theme', // Tema konsultasi
                time: participant.consultationTime ?? '', // Waktu konsultasi
                timeRemaining: '${participant.remainingMinutes ?? "0"} ${S.of(context).Minutes_Left}',
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
                dataRequest: participant.type ?? '', // Jenis permintaan
              ),
              const Divider(),
            ],
          );
        },
      ),
    );
  }
}
