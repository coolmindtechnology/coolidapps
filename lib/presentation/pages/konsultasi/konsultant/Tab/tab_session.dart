import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:coolappflutter/data/provider/provider_consultant.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/Normal_User/detil_consultant.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/Normal_User/pop-upwarning.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/Normal_User/profile_card.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/Normal_User/non_konsultasi.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/konsultant/chat/New_Chat.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/konsultant/chat/chat_consultant.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/konsultant/chat/chatbox.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/konsultant/chat/rooms_konsultant.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/konsultant/detail_session.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/konsultant/warning_pop_up.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/normal_user/chat/firebase_chat/chat.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/widgets/Container/container_status.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

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

  void _handlePressed(
      types.User otherUser, BuildContext context, String id) async {
    final navigator = Navigator.of(context);

    // Cek apakah pengguna ada di Firestore
    var userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(otherUser.id)
        .get();

    if (!userDoc.exists) {
      debugPrint("❌ User ${otherUser.id} belum terdaftar di Firestore!");
      return;
    }

    try {
      final room = await FirebaseChatCore.instance.createRoom(otherUser);
      debugPrint("✅ Room berhasil dibuat! Room ID: ${room.id}");

      navigator.pop();
      await navigator.push(
        MaterialPageRoute(
          builder: (context) => ChatPageConsultant(
            idUser: id,
            room: room,
          ),
        ),
      );
    } catch (e) {
      debugPrint("❌ Gagal membuat room: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ConsultantProvider>(context);
    return Scaffold(
      body: StreamBuilder<List<types.User>>(
          stream: FirebaseChatCore.instance.users(),
          initialData: const [],
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(
                  bottom: 200,
                ),
                child: const Text('No users'),
              );
            }

            return provider.isLoadingParticipant
                ? const Center(
              child: CircularProgressIndicator(),
            )
                : provider.listParticipant.isEmpty
                ? Center(child: NoneKonsul())
                : ListView.builder(
              itemCount: provider.listParticipant.length,
              itemBuilder: (context, index) {
                final user = snapshot.data![index];
                final participant = provider.listParticipant[index];
                return Column(
                  children: [
                    Column(
                      children: [
                        ProfileCard(
                          imagePath: participant
                              .profilePicture, // Gambar profil
                          name: participant.participantName ??
                              '', // Nama peserta
                          title: participant.type ??
                              '', // Jenis konsultasi
                          bloodType: participant.bloodType ??
                              'Unknown', // Golongan darah
                          location: participant.theme ??
                              'No theme', // Tema konsultasi
                          time: participant.consultationTime ??
                              '', // Waktu konsultasi
                          timeRemaining:
                          '${participant.remainingMinutes ?? "0"} ${S.of(context).Minutes_Left}',
                          timeColor: BlueColor,
                          warnastatus:
                          Colors.lightBlueAccent.shade100,
                          onTap: () {
                            int remainingMinutes = 0;

                            if (participant.remainingMinutes is int) {
                              remainingMinutes = participant.remainingMinutes as int;
                            } else if (participant.remainingMinutes is String) {
                              remainingMinutes = int.tryParse(participant.remainingMinutes as String) ?? 0;
                            }

                            if (remainingMinutes == 0) {
                            Nav.to(NewChatPage(
                              consultationID:  participant.consultationId.toString(),
                              status: true,
                              reciverUserID: participant
                                  .firebaseConf?.participantIds
                                  .toString() ??
                                  'data kosong',
                              nama: participant.participantName
                                  .toString(),
                              image: participant.profilePicture
                                  .toString(),
                              Tema: participant.theme.toString(),
                              waktu: participant.consultationTime
                                  .toString(),
                              tipeotak: participant.personalityType.toString(),
                            ));
                            } else {
                              // Jika sesi belum bisa dimulai, tampilkan alert dialog
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text("Sesi Belum Dimulai"),
                                  content: Text(
                                    "Sesi akan dimulai dalam ${participant.remainingMinutes.toString()} menit. Silakan tunggu!",
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

                            // Nav.to(RoomsPageKonsultan(idUser: ""));
                            // _handlePressed(
                            //     user,
                            //     context,
                            //     provider.listParticipant[index]
                            //         .consultationId
                            //         .toString());
                            // showDialog(
                            //   context: context,
                            //   builder: (BuildContext context) {
                            //     return Dialog(
                            //       shape: RoundedRectangleBorder(
                            //         borderRadius:
                            //             BorderRadius.circular(15.0),
                            //       ),
                            //       child: SizedBox(
                            //           height: 380,
                            //           child: WarningStartSession(
                            //             idUser: provider
                            //                 .listParticipant[index]
                            //                 .consultationId
                            //                 .toString(),
                            //           )),
                            //     );
                            //   },
                            // );
                          }, // Aksi jika ada
                        ),
                        RequestContainer(
                          dataRequest: participant.type ?? '',
                        ),
                        gapH10,
                        RequestContainer(
                          typeKeperluan:
                          S.of(context).Session_Begins_In,
                          dataRequest:
                          participant.remainingMinutes ?? "00.00",
                        ),
                      ],
                    ),
                  ],
                );
              },
            );
          }),
    );
  }
}