import 'package:coolappflutter/data/provider/provider_curhat.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/Normal_User/profile_consultant.dart';
import 'package:coolappflutter/presentation/pages/curhat/card_status.dart';

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
                Nav.to(ProfileConsultant());
              },
            );
          });
    }));
  }
}
