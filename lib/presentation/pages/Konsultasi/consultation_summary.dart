import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/CardConsultant.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/Detil_Consultant.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/Konsultasi_Page.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/Profile_Card.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/Sessions_time.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';

import 'package:coolappflutter/presentation/widgets/GlobalButton.dart';
import 'package:flutter/material.dart';

import 'components/Container_Promo.dart';

class SummaryConsultant extends StatefulWidget {
  const SummaryConsultant({super.key});

  @override
  State<SummaryConsultant> createState() => _SummaryConsultantState();
}

class _SummaryConsultantState extends State<SummaryConsultant> {
  bool isConfirmed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          S.of(context).Session_Summary,
          style: const TextStyle(color: Colors.white),
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
            ),
            const SizedBox(height: 8.0),
            ProfileCard(
                imagePath: 'images/konsultasi/profile1.png',
                name: 'vivian Entira',
                title: 'Creative',
                bloodType: 'B',
                location: 'Cirebon, jawa barat',
                time: '09,00 - 0.9.30 ',
                timeRemaining: '345 Sesi Selesai',
                timeColor: BlueColor,
                status: 'Pencapaian ',
                warnastatus: Colors.white),
            const SizedBox(height: 16.0),
            CardConsultant(
              topic: S.of(context).Selected_topic,
              topicSelected: S.of(context).PERSONALITY,
              consultationTime: S.of(context).Consultation_time,
              consultationTimeSelected: '09.00 - 09.30',
            ),
            const SizedBox(
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
            const SizedBox(
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
                        Text(S.of(context).FREE),
                      ],
                    ),
                    Divider(
                      color: BlueColor,
                    ),
                    Text(
                      S.of(context).Payment_After_Approval,
                      style: const TextStyle(color: Colors.red),
                    )
                  ],
                ),
              ),
            ),
            const Spacer(),
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
                    style: const TextStyle(fontSize: 14.0, color: Colors.black),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            GlobalButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    // Timer untuk navigasi otomatis setelah 3 detik
                    Future.delayed(const Duration(seconds: 3), () {
                      Nav.toAll(const KonsultasiPage()); // Ganti ke rute tujuan
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
