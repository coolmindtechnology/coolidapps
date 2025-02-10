import 'package:coolappflutter/data/provider/provider_consultation.dart';
import 'package:coolappflutter/generated/l10n.dart';

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

class TabSesiCurhat extends StatefulWidget {
  const TabSesiCurhat({super.key});

  @override
  State<TabSesiCurhat> createState() => _TabSesiCurhatState();
}

class _TabSesiCurhatState extends State<TabSesiCurhat> {
  final List<Map<String, dynamic>> profileData = [
    {
      "imagePath": 'images/konsultasi/profile3.png',
      "name": 'Alice Smith',
      "title": 'Innovator',
      "timeRemaining": '11',
      "subtitle":
          'Membuka usaha sendiri tidak butuh ijazah dan latar belakang pendidikan management'
    },
    {
      "imagePath": 'images/konsultasi/profile1.png',
      "name": 'Vivian Entira',
      "title": 'Creative',
      "timeRemaining": '10',
      "subtitle":
          'Membuka usaha sendiri tidak butuh ijazah dan latar belakang pendidikan management'
    },
    {
      "imagePath": 'images/konsultasi/profile2.png',
      "name": 'John Doe',
      "title": 'Strategist',
      "timeRemaining": '10',
      "subtitle":
          'Membuka usaha sendiri tidak butuh ijazah dan latar belakang pendidikan management'
    },
  ];

  void _handlePressed(
      types.User otherUser, BuildContext context, String id) async {
    final navigator = Navigator.of(context);
    final room = await FirebaseChatCore.instance.createRoom(otherUser);
    debugPrint("cek id users ${room.id}");

    navigator.pop();
    await navigator.push(
      MaterialPageRoute(
        builder: (context) => ChatPage(
          idUser: id,
          room: room,
        ),
      ),
    );
  }

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
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final user = snapshot.data![index];
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
                    _handlePressed(
                      user,
                      context,
                      consultation.id.toString(),
                    );
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => DetailConsultant(
                    //             user: user,
                    //             idUser: consultation.id.toString(),
                    //             imagePath: consultation.consultantImage ?? '-',
                    //             name: consultation.consultantName ?? '-',
                    //             title: consultation.consultantTypeBrain ?? '-',
                    //             bloodType:
                    //                 consultation.consultantBloodType ?? '-',
                    //             location: consultation.consultantAddress ?? '-',
                    //             time: "${consultation.timeSelected}",
                    //             timeRemaining:
                    //                 '${consultation.remainingMinutes ?? '-'} ${S.of(context).Minutes_Left}',
                    //             timeColor: BlueColor,
                    //             status: consultation.status.toString(),
                    //             warnastatus: Colors.lightBlueAccent.shade100,
                    //             getTopik: consultation.theme.toString(),
                    //             statusSession:
                    //                 consultation.sessionStatus.toString(),
                    //             deskripsi:
                    //                 consultation.explanation.toString())));
                  }, // Aksi jika ada
                );
              },
            );
          });
    }));
  }
}

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView.builder(
//         itemCount: profileData.length,
//         itemBuilder: (context, index) {
//           final profile = profileData[index];
//           return Column(
//             children: [
//               CurhatConsultantCrad(
//                 imagePath: profile['imagePath'],
//                 name: profile['name'],
//                 title: profile['title'],
//                 subtitle: profile['subtitle'],
//                 timeRemaining:
//                     profile['timeRemaining'] + ' ' + S.of(context).Minutes_Left,
//                 onTap: () {
//                   Nav.to(DetailSessionCurhat());
//                 }, // Aksi jika ada
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
