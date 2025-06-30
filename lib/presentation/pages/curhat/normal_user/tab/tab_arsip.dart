import 'package:coolappflutter/data/provider/provider_curhat.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/Normal_User/non_konsultasi.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/Normal_User/profile_consultant.dart';
import 'package:coolappflutter/presentation/pages/curhat/card_status.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';

import 'package:coolappflutter/presentation/utils/nav_utils.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Konsultasi/Normal_User/Arsip_Consultant.dart';
import '../../../konsultasi/normal_user/profile_card.dart';

class TabArsipCurhat extends StatefulWidget {
  const TabArsipCurhat({super.key});

  @override
  State<TabArsipCurhat> createState() => _TabArsipCurhatState();
}

class _TabArsipCurhatState extends State<TabArsipCurhat> {
  @override
  void initState() {
    Provider.of<CurhatProvider>(context, listen: false)
        .getListCurhat(context, parameter: "archive");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
    Consumer<CurhatProvider>(builder: (context, provider, child) {
      if (provider.isLoadingCurhat) {
        return Center(child: CircularProgressIndicator());
      }

      final curhats = provider.curhatdata;
      if (curhats!.isEmpty) {
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
              '${curhat.sessionEnd ?? '-'}',
              timeColor: Colors.blue,
              status: S.of(context).Completed_On,
              warnastatus: Colors.lightBlueAccent.shade100,
              onTap: () {
                Nav.to(ArsipConsultant(
                  idDocument : curhat.idDocument,
                  rating : curhat.rating,
                  type: curhat.typeSession,
                  price: curhat.price?.toString() ?? "Free",
                  idUser: curhat.id.toString(),
                  imagePath: curhat.consultantImage ?? '-',
                  name: curhat.consultantName ?? '-',
                  title: curhat.consultantTypeBrain ?? '-',
                  bloodType:
                  curhat.consultantBloodType ?? '-',
                  location: curhat.consultantAddress ?? '-',
                  time: "${curhat.timeSelected}",
                  timeRemaining: curhat.sessionEnd.toString(),
                  timeColor: BlueColor,
                  status: curhat.status.toString(),
                  warnastatus: Colors.lightBlueAccent.shade100,
                  getTopik: curhat.theme.toString(),
                  statusSession:
                  curhat.sessionStatus.toString(),
                  deskripsi:
                  curhat.explanation.toString(),
                  idConsultation: curhat.id.toString(),
                  idConsultant: curhat.consultantId.toString(),
                  idreciver: curhat.firebaseConf!.consultantIds.toString(),

                ));
              },
            );
          });
    }));
  }
}
