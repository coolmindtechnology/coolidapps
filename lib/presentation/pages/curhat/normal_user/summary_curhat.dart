import 'package:coolappflutter/data/apps/app_assets.dart';
import 'package:coolappflutter/generated/l10n.dart';

import 'package:coolappflutter/presentation/pages/curhat/card_curhat.dart';
import 'package:coolappflutter/presentation/pages/curhat/normal_user/curhart_dashboard.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';

import 'package:coolappflutter/presentation/widgets/GlobalButton.dart';
import 'package:flutter/material.dart';

import '../../../widgets/Container/container_promo.dart';
import '../../konsultasi/normal_user/profile_card.dart';
import '../../konsultasi/normal_user/profile_consultant.dart';

class SummaryCurhat extends StatefulWidget {
  const SummaryCurhat({super.key});

  @override
  State<SummaryCurhat> createState() => _SummaryCurhatState();
}

class _SummaryCurhatState extends State<SummaryCurhat> {
  bool isConfirmed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          S.of(context).Session_Summary,
          style: TextStyle(color: Colors.white),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).Review_Your_Session,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: BlueColor,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 8.0),
            ProfileCard(
                onTap: () {
                  // Nav.to(ProfileConsultant(
                  //   id: ,
                  // ));
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
                  hintText: S.of(context).Why_Need_Consultant,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey.shade300))),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              color: Colors.lightBlueAccent.shade100,
              height: 100,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(S.of(context).Price),
                        Text('IDR 200.000'),
                      ],
                    ),
                    Divider(
                      color: BlueColor,
                    ),
                    Text(
                      S.of(context).Payment_After_Approval,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(color: Colors.red),
                    )
                  ],
                ),
              ),
            ),
            Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Checkbox(
                  value: isConfirmed,
                  onChanged: (bool? value) {
                    setState(() {
                      isConfirmed = value ?? false;
                    });
                  },
                ),
                Expanded(
                  child: Text(
                    S.of(context).Information_Confirmed,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(fontSize: 14.0, color: Colors.black),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            GlobalButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    // Timer untuk navigasi otomatis setelah 3 detik
                    Future.delayed(Duration(seconds: 3), () {
                      Nav.toAll(CurhatDashboard()); // Ganti ke rute tujuan
                    });

                    return Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: SizedBox(
                        height: 350,
                        child: ContainerPromo(
                          title: S.of(context).Awaiting_Confirmation,
                          imageUrl: 'konsultasi/Time_Circle.jpg',
                          subtitle: S.of(context).Awaiting_Confirmation,
                          subtitle2: S.of(context).Back_to_Consultation,
                        ),
                      ),
                    );
                  },
                );
              },
              color: primaryColor,
              text: S.of(context).next,
            )
          ],
        ),
      ),
    );
  }
}
