import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/CardConsultant.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/Profile_Card.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/Sessions_time.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/consultation_summary.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/widgets/GlobalButton.dart';
import 'package:flutter/material.dart';

class FormConsultant extends StatefulWidget {
  const FormConsultant({super.key});

  @override
  State<FormConsultant> createState() => _FormConsultantState();
}

class _FormConsultantState extends State<FormConsultant> {
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
            SizedBox(height: 16.0),
            CardConsultant(
              topic:  S.of(context).Selected_topic,
              topicSelected:  S.of(context).PERSONALITY,
              consultationTime: S.of(context).Consultation_time,
              consultationTimeSelected: '09.00 - 09.30',
            ),
            SizedBox(height: 20,),
            TextField(
              maxLines: 5,
              decoration: InputDecoration(
                hintText:  S.of(context).Why_Need_Consultant,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey.shade300)
                )
              ),
            ),
            Spacer(),
            GlobalButton(onPressed: () {
            Nav.to(SummaryConsultant());
            }, color: primaryColor, text: S.of(context).next)
          ],
        ),
      ),
    );
  }
}
