import 'package:coolappflutter/data/apps/app_assets.dart';
import 'package:coolappflutter/generated/l10n.dart';

import 'package:coolappflutter/presentation/pages/Konsultasi/Normal_User/profile_consultant.dart';

import 'package:coolappflutter/presentation/pages/curhat/card_curhat.dart';
import 'package:coolappflutter/presentation/pages/curhat/normal_user/summary_curhat.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/widgets/GlobalButton.dart';
import 'package:coolappflutter/presentation/widgets/costum_floatingbutton.dart';
import 'package:flutter/material.dart';

import '../../konsultasi/normal_user/profile_card.dart';

class FormCurhat extends StatefulWidget {
  const FormCurhat({super.key});

  @override
  State<FormCurhat> createState() => _FormCurhatState();
}

class _FormCurhatState extends State<FormCurhat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).Your_Explanation,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: BlueColor,
              ),
            ),
            SizedBox(height: 8.0),
            ProfileCard(
                onTap: () {
                  // Nav.to(ProfileConsultant());
                },
                imagePath: AppAsset.imgProfile1,
                name: 'vivian Entira',
                title: 'Creative',
                bloodType: 'B',
                location: 'Cirebon, jawa barat',
                time: '09,00 - 0.9.30 ',
                timeRemaining: '345 Sesi Selesai',
                timeColor: BlueColor,
                status: 'Pencapaian ',
                warnastatus: Colors.white),
            SizedBox(height: 16.0),
            CardCurhat(
              CurhatTimeSelected: '09.00 - 09.30',
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              maxLines: 5,
              decoration: InputDecoration(
                  hintText: S.of(context).What_Is_Your_Problem,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey.shade300))),
            ),
            Spacer(),
            GlobalButton(
                onPressed: () {
                  Nav.to(SummaryCurhat());
                },
                color: primaryColor,
                text: S.of(context).next)
          ],
        ),
      ),
      floatingActionButton: const CustomFAB(),
    );
  }
}
