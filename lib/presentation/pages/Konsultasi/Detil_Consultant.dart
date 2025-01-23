import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/CardConsultant.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/Chat/ChatBox.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/Konsultasi_Page.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/Pop-UpWarning.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/Profile_Card.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/Sessions_time.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/widgets/GlobalButton.dart';
import 'package:flutter/material.dart';

class DetailConsultant extends StatefulWidget {
  const DetailConsultant({super.key});

  @override
  State<DetailConsultant> createState() => _DetailConsultantState();
}

class _DetailConsultantState extends State<DetailConsultant> {
  bool isConfirmed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          'Detail',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Periksa kembali sesi anda',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: BlueColor,
              ),
            ),
            const SizedBox(height: 8.0),
            Container(
              width: double.infinity,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.lightBlue.shade100,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.of(context).Status,
                      style: TextStyle(
                          color: BlueColor, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      S.of(context).Accepted,
                      style: TextStyle(
                          color: BlueColor, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
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
                  hintText: 'Kenapa Anda Butuh Consultant ?',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey.shade300))),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              color: Colors.lightBlueAccent.shade100,
              height: 60,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Harga'),
                        Text('FREE'),
                      ],
                    ),
                    Divider(
                      color: BlueColor,
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
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
                        Nav.toAll(const ChatPage(
                          status: true,
                        )); // Ganti ke rute tujuan
                      });

                      return Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: SizedBox(height: 350, child: WarningPopup()),
                      );
                    },
                  );
                },
                color: primaryColor,
                text: S.of(context).next)
          ],
        ),
      ),
    );
  }
}
