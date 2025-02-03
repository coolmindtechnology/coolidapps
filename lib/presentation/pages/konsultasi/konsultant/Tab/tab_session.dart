import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:coolappflutter/data/provider/provider_consultant.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/Normal_User/detil_consultant.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/Normal_User/pop-upwarning.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/Normal_User/profile_card.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/Normal_User/non_konsultasi.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/konsultant/chat/chatbox.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/konsultant/detail_session.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/konsultant/warning_pop_up.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/widgets/Container/container_status.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabSesiKonsultant extends StatefulWidget {
  const TabSesiKonsultant({super.key});

  @override
  State<TabSesiKonsultant> createState() => _TabSesiKonsultantState();
}

class _TabSesiKonsultantState extends State<TabSesiKonsultant> {
  @override
  void initState() {
    super.initState();
    // Memanggil provider untuk mendapatkan semua peserta
    final provider = Provider.of<ConsultantProvider>(context, listen: false);
    provider.getParticipant(context, parameter: "active");
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
              Column(
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
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: SizedBox(
                                height: 380,
                                child: WarningStartSession()
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
