import 'package:coolappflutter/data/provider/provider_consultant.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/Normal_User/detil_consultant.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/Normal_User/non_konsultasi.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/Normal_User/profile_card.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/Normal_User/profile_consultant.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/konsultant/detail_session.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/widgets/Container/container_status.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabHistoryRequest extends StatefulWidget {
  final String type; // Tambahkan parameter type

  const TabHistoryRequest({super.key, required this.type});

  @override
  State<TabHistoryRequest> createState() => _TabHistoryRequestState();
}

class _TabHistoryRequestState extends State<TabHistoryRequest> {
  @override
  void initState() {
    super.initState();
    // Memanggil provider untuk mendapatkan semua peserta dengan parameter "requested"
    final provider = Provider.of<ConsultantProvider>(context, listen: false);
    provider.getParticipant(context, parameter: "requested");
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
                imagePath:
                participant.profilePicture, // Gambar profil
                name:
                participant.participantName ?? '', // Nama peserta
                title: participant.personalityType ?? '', // Jenis konsultasi
                bloodType: participant.bloodType ?? 'Unknown', // Golongan darah
                location: participant.theme ?? 'No theme', // Tema konsultasi
                time: participant.consultationTime ?? '', // Waktu konsultasi
                timeRemaining: S.of(context).Accepted,
                timeColor: Colors.green,
                warnastatus: Colors.lightGreen.shade100,
                onTap: () {
                  Nav.to(DetailSessionPage(
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
                }, // Aksi jika ada
              ),
              RequestContainer(
                dataRequest: participant.type ?? '',
              )
            ],
          );
        },
      ),
    );
  }
}
