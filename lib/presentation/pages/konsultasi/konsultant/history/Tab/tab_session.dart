import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:coolappflutter/data/provider/provider_consultant.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/Normal_User/detil_consultant.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/Normal_User/pop-upwarning.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/Normal_User/profile_card.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/Normal_User/non_konsultasi.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/konsultant/chat/chatbox.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/konsultant/detail_session.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/widgets/Container/container_status.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabHistorySession extends StatefulWidget {
  final String type; // Tambahkan parameter type

  const TabHistorySession({super.key, required this.type});

  @override
  State<TabHistorySession> createState() => _TabHistorySessionState();
}

class _TabHistorySessionState extends State<TabHistorySession> {
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
          ? Center(child: NoneKonsul()) // Jika tidak ada peserta
          : ListView.builder(
        itemCount: filteredParticipants.length,
        itemBuilder: (context, index) {
          final participant = filteredParticipants[index];
          return Column(
            children: [
              Column(
                children: [
                  ProfileCard(
                    imagePath: participant.profilePicture, // Gambar profil
                    name: participant.participantName ?? '', // Nama peserta
                    title: participant.personalityType ?? '', // Jenis konsultasi
                    bloodType: participant.bloodType ?? 'Unknown', // Golongan darah
                    location: participant.theme ?? 'No theme', // Tema konsultasi
                    time: participant.consultationTime ?? '', // Waktu konsultasi
                    timeRemaining:
                    '${participant.remainingMinutes ?? "0"} ${S.of(context).Minutes_Left}',
                    timeColor: BlueColor,
                    warnastatus: Colors.lightBlueAccent.shade100,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext dialogContext) {
                          // Navigasi setelah pop-up ditutup
                          Future.delayed(Duration(seconds: 3), () {
                            if (mounted) {
                              Navigator.of(dialogContext).pop();
                              Nav.toAll(ChatPageByConsultant(status: true));
                            }
                          });

                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: SizedBox(
                                height: 380,
                                child: WarningPopup()
                            ),
                          );
                        },
                      );
                    }, // Aksi jika ada
                  ),
                  RequestContainer(
                    dataRequest: participant.type ?? '',
                  ),
                  gapH10,
                  RequestContainer(
                    typeKeperluan: S.of(context).Session_Begins_In,
                    dataRequest: participant.remainingMinutes ?? "00.00",
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
