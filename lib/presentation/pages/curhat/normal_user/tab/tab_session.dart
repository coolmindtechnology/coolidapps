import 'package:coolappflutter/data/provider/provider_consultation.dart';
import 'package:coolappflutter/data/provider/provider_curhat.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/Normal_User/non_konsultasi.dart';

import 'package:coolappflutter/presentation/pages/curhat/normal_user/card_curhat_consultant.dart';
import 'package:coolappflutter/presentation/pages/curhat/normal_user/detail_session.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/normal_user/chat/firebase_chat/chat.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/normal_user/profile_card.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';

import 'package:coolappflutter/presentation/utils/nav_utils.dart';

import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:provider/provider.dart';

import '../../../Konsultasi/Normal_User/detil_consultant.dart';

class TabSesiCurhat extends StatefulWidget {
  const TabSesiCurhat({super.key});

  @override
  State<TabSesiCurhat> createState() => _TabSesiCurhatState();
}

class _TabSesiCurhatState extends State<TabSesiCurhat> {
  @override
  void initState() {
    super.initState();
    Provider.of<CurhatProvider>(context, listen: false)
        .getListCurhat(context, parameter: "active");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<CurhatProvider>(
        builder: (context, provider, child) {
          if (provider.isLoadingCurhat) {
            return const Center(child: CircularProgressIndicator());
          }

          final curhats = provider.curhatdata; // Menggunakan daftar curhat
          if (curhats == null || curhats.isEmpty) {
            return const Center(child: NoneKonsul());
          }

          return ListView.builder(
            itemCount: curhats.length,
            itemBuilder: (context, index) {
              final curhat = curhats[index];

              return ProfileCard(
                imagePath: curhat.consultantImage ?? '-',
                name: curhat.consultantName ?? '-',
                title: curhat.consultantTypeBrain ?? '-',
                bloodType: curhat.consultantBloodType ?? '-',
                location: curhat.consultantAddress ?? '-',
                time: "${curhat.timeSelected}",
                timeRemaining:
                '${curhat.remainingMinutes ?? '-'} ${S.of(context).Minutes_Left}',
                timeColor: BlueColor,
                status: S.of(context).Session_Begins_In,
                warnastatus: Colors.lightBlueAccent.shade100,
                onTap: () {
                  int remainingMinutes = 0;

                  if (curhat.remainingMinutes is int) {
                    remainingMinutes = curhat.remainingMinutes as int;
                  } else if (curhat.remainingMinutes is String) {
                    remainingMinutes =
                        int.tryParse(curhat.remainingMinutes as String) ?? 0;
                  }

                  if (remainingMinutes == 0) {
                    // Jika sesi sudah bisa dimulai, pindah ke halaman DetailSession
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailConsultant(
                          idUser: curhat.id.toString(),
                          imagePath: curhat.consultantImage ?? '-',
                          name: curhat.consultantName ?? '-',
                          title: curhat.consultantTypeBrain ?? '-',
                          bloodType: curhat.consultantBloodType ?? '-',
                          location: curhat.consultantAddress ?? '-',
                          time: "${curhat.timeSelected}",
                          timeRemaining:
                          '${curhat.remainingMinutes ?? '-'} ${S.of(context).Minutes_Left}',
                          timeColor: BlueColor,
                          status: curhat.status.toString(),
                          warnastatus: Colors.lightBlueAccent.shade100,
                          getTopik: curhat.theme.toString(),
                          statusSession: curhat.sessionStatus.toString(),
                          deskripsi: curhat.explanation.toString(),
                          idConsultation: curhat.id.toString(),
                          idConsultant: curhat.consultantId.toString(),
                          idreciver: curhat.firebaseConf?.consultantIds.toString() ?? '-',
                        ),
                      ),
                    );
                  } else {
                    // Jika sesi belum bisa dimulai, tampilkan alert dialog
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Sesi Belum Dimulai"),
                        content: Text(
                          "Sesi akan dimulai dalam ${curhat.remainingMinutes.toString()} menit. Silakan tunggu!",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("OK"),
                          ),
                        ],
                      ),
                    );
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}

























// import 'package:coolappflutter/data/provider/provider_consultation.dart';
// import 'package:coolappflutter/generated/l10n.dart';
//
// import 'package:coolappflutter/presentation/pages/curhat/normal_user/card_curhat_consultant.dart';
// import 'package:coolappflutter/presentation/pages/curhat/normal_user/detail_session.dart';
// import 'package:coolappflutter/presentation/pages/konsultasi/normal_user/chat/firebase_chat/chat.dart';
// import 'package:coolappflutter/presentation/pages/konsultasi/normal_user/profile_card.dart';
// import 'package:coolappflutter/presentation/theme/color_utils.dart';
//
// import 'package:coolappflutter/presentation/utils/nav_utils.dart';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
// import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
// import 'package:provider/provider.dart';
//
// import '../../../Konsultasi/Normal_User/detil_consultant.dart';
//
// class TabSesiCurhat extends StatefulWidget {
//   const TabSesiCurhat({super.key});
//
//   @override
//   State<TabSesiCurhat> createState() => _TabSesiCurhatState();
// }
//
// class _TabSesiCurhatState extends State<TabSesiCurhat> {
//   @override
//   void initState() {
//     Provider.of<ProviderConsultation>(context, listen: false)
//         .getListConsultations(context, "active");
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(body:
//         Consumer<ProviderConsultation>(builder: (context, provider, child) {
//       if (provider.isLoading) {
//         return Center(child: CircularProgressIndicator());
//       }
//
//       final consultations = provider.consultations;
//       if (consultations.isEmpty) {
//         return Center(child: Text('No consultations available'));
//       }
//
//       return StreamBuilder<List<types.User>>(
//           stream: FirebaseChatCore.instance.users(),
//           initialData: const [],
//           builder: (context, snapshot) {
//             if (!snapshot.hasData || snapshot.data!.isEmpty) {
//               return Container(
//                 alignment: Alignment.center,
//                 margin: const EdgeInsets.only(
//                   bottom: 200,
//                 ),
//                 child: const Text('No users'),
//               );
//             }
//
//             return ListView.builder(
//               itemCount: snapshot.data!.length,
//               itemBuilder: (context, index) {
//                 final user = snapshot.data![index];
//                 final consultation = consultations[index];
//                 final sessionStart =
//                     consultation.sessionStart?.substring(0, 5) ?? '-';
//                 final sessionEnd =
//                     consultation.sessionEnd?.substring(0, 5) ?? '-';
//                 // final profile = profileData[index];
//                 return ProfileCard(
//                   imagePath: consultation.consultantImage ?? '-',
//                   name: consultation.consultantName ?? '-',
//                   title: consultation.consultantTypeBrain ?? '-',
//                   bloodType: consultation.consultantBloodType ?? '-',
//                   location: consultation.consultantAddress ?? '-',
//                   time: "${consultation.timeSelected}",
//                   timeRemaining:
//                       '${consultation.remainingMinutes ?? '-'} ${S.of(context).Minutes_Left}',
//                   timeColor: BlueColor,
//                   status: S.of(context).Session_Begins_In,
//                   warnastatus: Colors.lightBlueAccent.shade100,
//                   onTap: () {
//                     int remainingMinutes = 0;
//
//                     if (consultation.remainingMinutes is int) {
//                       remainingMinutes = consultation.remainingMinutes as int;
//                     } else if (consultation.remainingMinutes is String) {
//                       remainingMinutes = int.tryParse(consultation.remainingMinutes as String) ?? 0;
//                     }
//                     if (remainingMinutes == 0) {
//                       // Jika sesi sudah bisa dimulai, pindah ke halaman DetailConsultant
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => DetailConsultant(
//                             user: user,
//                             idUser: consultation.id.toString(),
//                             imagePath: consultation.consultantImage ?? '-',
//                             name: consultation.consultantName ?? '-',
//                             title: consultation.consultantTypeBrain ?? '-',
//                             bloodType: consultation.consultantBloodType ?? '-',
//                             location: consultation.consultantAddress ?? '-',
//                             time: "${consultation.timeSelected}",
//                             timeRemaining:
//                             '${consultation.remainingMinutes ?? '-'} ${S.of(context).Minutes_Left}',
//                             timeColor: BlueColor,
//                             status: consultation.status.toString(),
//                             warnastatus: Colors.lightBlueAccent.shade100,
//                             getTopik: consultation.theme.toString(),
//                             statusSession: consultation.sessionStatus.toString(),
//                             deskripsi: consultation.explanation.toString(),
//                             idConsultation: consultation.id.toString(),
//                             idConsultant: consultation.consultantId.toString(),
//                             idreciver: consultation.firebaseConf!.consultantIds.toString(),
//                           ),
//                         ),
//                       );
//                     } else {
//                       // Jika sesi belum bisa dimulai, tampilkan alert dialog
//                       showDialog(
//                         context: context,
//                         builder: (context) => AlertDialog(
//                           title: Text("Sesi Belum Dimulai"),
//                           content: Text(
//                             "Sesi akan dimulai dalam ${consultation.remainingMinutes.toString()} menit. Silakan tunggu!",
//                           ),
//                           actions: [
//                             TextButton(
//                               onPressed: () {
//                                 Navigator.pop(context);
//                               },
//                               child: Text("OK"),
//                             ),
//                           ],
//                         ),
//                       );
//                     }
//                   },
//                   // Aksi jika ada
//                 );
//               },
//             );
//           });
//     }));
//   }
// }
