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

class TabArsipKonsultant extends StatefulWidget {
  const TabArsipKonsultant({super.key});

  @override
  _TabArsipKonsultantState createState() => _TabArsipKonsultantState();
}

class _TabArsipKonsultantState extends State<TabArsipKonsultant> {
  @override
  void initState() {
    super.initState();
    // Memanggil provider untuk mendapatkan semua peserta
    final provider = Provider.of<ConsultantProvider>(context, listen: false);
    provider.getParticipant(context, parameter: "archive");
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
        itemCount: provider.listParticipant.length, // Menampilkan semua peserta
        itemBuilder: (context, index) {
          final participant = provider.listParticipant[index]; // Mengambil peserta
          return Column(
            children: [
              ProfileCard(
                imagePath: participant.profilePicture,
                name: participant.participantName ?? '',
                title: participant.personalityType ?? '',
                bloodType: participant.bloodType ?? 'Unknown', // Golongan darah
                location: participant.theme ?? 'No theme', // Tema konsultasi
                time: participant.consultationTime ?? '', // Waktu konsultasi
                timeRemaining: '${participant.remainingMinutes ?? "0"} ${S.of(context).Minutes_Left}',
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
                }, // Aksi jika ada
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