import 'package:coolappflutter/data/provider/provider_curhat.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/Normal_User/detil_consultant.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/Normal_User/profile_consultant.dart';
import 'package:coolappflutter/presentation/pages/curhat/card_status.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';

import 'package:coolappflutter/presentation/utils/nav_utils.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Konsultasi/Normal_User/non_konsultasi.dart';
import '../../../konsultasi/normal_user/profile_card.dart';

class TabRequestCurhat extends StatefulWidget {
  const TabRequestCurhat({super.key});

  @override
  State<TabRequestCurhat> createState() => _TabRequestCurhatState();
}

class _TabRequestCurhatState extends State<TabRequestCurhat> {
  @override
  void initState() {
    Provider.of<CurhatProvider>(context, listen: false)
        .getListCurhat(context, parameter: "requested");
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
              timeRemaining: curhat.sessionStatus,
              timeColor: Colors.green,
              status: S.of(context).Status,
              warnastatus: Colors.lightGreen.shade100,
              onTap: () {
                String payed;

                if (curhat.categorySession == "paid" && curhat.status == "Unpaid") {
                  payed = "Unpaid";
                } else if (curhat.categorySession == "free" && curhat.status == "Unpaid") {
                  payed = "Paid";
                }
                else {
                  payed = "Paid";
                }
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailConsultant(
                        type: curhat.typeSession,
                        payed: payed,
                        price: curhat.price,
                        idUser: curhat.id.toString(),
                        imagePath: curhat.consultantImage ?? '-',
                        name: curhat.consultantName ?? '-',
                        title: curhat.consultantTypeBrain ?? '-',
                        bloodType:
                        curhat.consultantBloodType ?? '-',
                        location: curhat.consultantAddress ?? '-',
                        time: "${curhat.timeSelected}",
                        timeRemaining:
                        '${curhat.remainingMinutes ?? '-'} ${S.of(context).Minutes_Left}',
                        timeColor: BlueColor,
                        status: curhat.status.toString(),
                        warnastatus: Colors.lightBlueAccent.shade100,
                        getTopik: 'Curhat',
                        statusSession:
                        curhat.sessionStatus.toString(),
                        deskripsi:
                        curhat.explanation.toString(),
                        idConsultation: curhat.id.toString(),
                        idConsultant: curhat.consultantId.toString(),
                        idreciver: curhat.firebaseConf!.consultantIds.toString(),

                      ),

                    ));
              },
            );
          });
    }));
  }
}
