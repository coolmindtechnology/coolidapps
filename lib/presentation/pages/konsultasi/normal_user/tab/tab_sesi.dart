import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/konsultant/chat/New_Chat.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/normal_user/chat/New_UserChat.dart';

import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../data/provider/provider_consultation.dart';
import '../detil_consultant.dart';
import '../profile_card.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

class TabSesi extends StatefulWidget {
  const TabSesi({super.key});

  @override
  State<TabSesi> createState() => _TabSesiState();
}

class _TabSesiState extends State<TabSesi> {
  @override
  void initState() {
    Provider.of<ProviderConsultation>(context, listen: false)
        .getListConsultations(context, "active","consultation");
    super.initState();
  }

  // final List<Map<String, dynamic>> profileData = [
  //   {
  //     "imagePath": 'images/konsultasi/profile3.png',
  //     "name": 'Alice Smith',
  //     "title": 'Innovator',
  //     "bloodType": 'A',
  //     "location": 'Surabaya, Jawa Timur',
  //     "time": '11:00 - 11:30',
  //     "timeRemaining": '11',
  //   },
  //   {
  //     "imagePath": 'images/konsultasi/profile1.png',
  //     "name": 'Vivian Entira',
  //     "title": 'Creative',
  //     "bloodType": 'B',
  //     "location": 'Cirebon, Jawa Barat',
  //     "time": '09:00 - 09:30',
  //     "timeRemaining": '10',
  //     "timeColor": Colors.green,
  //     "status": 'status',
  //   },
  //   {
  //     "imagePath": 'images/konsultasi/profile2.png',
  //     "name": 'John Doe',
  //     "title": 'Strategist',
  //     "bloodType": 'O',
  //     "location": 'Jakarta, Indonesia',
  //     "time": '10:00 - 10:30',
  //     "timeRemaining": '10',
  //   },
  // ];
  // void _handlePressed(
  //     types.User otherUser,
  //     BuildContext context,
  //     String id,
  //     dynamic user,
  //     String idConsultant,
  //     String imagePath,
  //     String name,
  //     String title,
  //     String bloodType,
  //     String location,
  //     String time,
  //     String timeRemaining,
  //     Color timeColor,
  //     String status,
  //     Color warnastatus,
  //     String getTopik,
  //     String statusSession,
  //     String deskripsi) async {
  //   final navigator = Navigator.of(context);
  //   final room = await FirebaseChatCore.instance.createRoom(otherUser);
  //   debugPrint("cek id users ${room.id}");
  //
  //   // navigator.pop();
  //   await navigator.push(
  //     MaterialPageRoute(
  //       builder: (context) => DetailConsultant(
  //         user: user,
  //         idUser: id,
  //         imagePath: imagePath,
  //         name: name,
  //         title: title,
  //         bloodType: bloodType,
  //         location: location,
  //         time: time,
  //         timeRemaining: timeRemaining,
  //         timeColor: timeColor,
  //         status: status,
  //         warnastatus: warnastatus,
  //         getTopik: getTopik,
  //         statusSession: statusSession,
  //         deskripsi: deskripsi,
  //         idConsultant: idConsultant,
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
    Consumer<ProviderConsultation>(builder: (context, provider, child) {
      if (provider.isLoading) {
        return Center(child: CircularProgressIndicator());
      }

      final consultations = provider.consultations;
      if (consultations.isEmpty) {
        return Center(child: Text('No consultations available'));
      }

      return StreamBuilder<List<types.User>>(
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

            return ListView.builder(
              itemCount: provider.consultations.length,
              itemBuilder: (context, index) {
                if (index >= snapshot.data!.length) {
                  return SizedBox(); // Hindari error jika data tidak cukup
                }
                final user = snapshot.data![index];
                if (index >= provider.consultations.length) return SizedBox();
                final consultation = consultations[index];
                final sessionStart =
                    consultation.sessionStart?.substring(0, 5) ?? '-';
                final sessionEnd =
                    consultation.sessionEnd?.substring(0, 5) ?? '-';
                // final profile = profileData[index];
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
                      // Jika sesi sudah bisa dimulai, pindah ke halaman DetailConsultant
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailConsultant(
                            user: user,
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
                            idreciver: consultation.firebaseConf!.consultantIds.toString(),
                          ),
                        ),
                      );
                    } else {
                      // Jika sesi belum bisa dimulai, tampilkan alert dialog
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
                  }, // Aksi jika ada
                );
              },
            );
          });
    }));
  }
}