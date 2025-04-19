import 'package:coolappflutter/data/apps/app_assets.dart';
import 'package:coolappflutter/data/provider/provider_consultant.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/Normal_User/pop-upwarning.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/Normal_User/profile_card.dart';
import 'package:coolappflutter/presentation/pages/curhat/card_curhat.dart';
import 'package:coolappflutter/presentation/pages/curhat/normal_user/chat/chatbox_curhat.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/konsultant/konsultant_dashboard.dart';
import 'package:coolappflutter/presentation/pages/payments/payment_page.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/widgets/Container/Container_Promo.dart';
import 'package:coolappflutter/presentation/widgets/Container/container_status.dart';
import 'package:coolappflutter/presentation/widgets/GlobalButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailWaitingPage extends StatefulWidget {
  const DetailWaitingPage(
      {super.key,
        this.profilePicture,
        this.participantName,
        this.typeConsultation,
        this.type,
        this.bloodType,
        this.consultationTime,
        this.remainingMinutes,
        this.theme,
        this.explanation,
        this.id_consultation});
  final participantName;
  final typeConsultation;
  final bloodType;
  final theme;
  final explanation;
  final consultationTime;
  final type;
  final remainingMinutes;
  final id_consultation;
  final profilePicture;

  @override
  State<DetailWaitingPage> createState() => _DetailWaitingPageState();
}

class _DetailWaitingPageState extends State<DetailWaitingPage> {
  bool isConfirmed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              S.of(context).Session_Details,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.0),
            SizedBox(
              height: 10,
            ),
            ProfileCard(
              imagePath: widget.profilePicture, // Gambar profil
              name: widget.participantName ?? '', // Nama peserta
              title: widget.typeConsultation ?? '', // Jenis konsultasi
              bloodType: widget.bloodType ?? 'Unknown', // Golongan darah
              location: widget.theme ?? 'No theme', // Tema konsultasi
              time: widget.consultationTime ?? '', // Waktu konsultasi
              timeRemaining:
              '${widget.remainingMinutes ?? "0"} ${S.of(context).Minutes_Left}',
              timeColor: BlueColor,
              warnastatus: Colors.lightBlueAccent.shade100,
            ),
            RequestContainer(
              dataRequest: widget.type ?? '',
            ),
            SizedBox(height: 16.0),
            CardCurhat(
              type: widget.type ?? 'konsultasi',
              CurhatTimeSelected: widget.consultationTime ?? "00.00",
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              enabled: false,
              maxLines: 5,
              decoration: InputDecoration(
                  hintText: widget.explanation ?? S.of(context).clientReason,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey.shade300))),
            ),
            SizedBox(
              height: 30,
            ),
            Spacer(),
            SizedBox(
              height: 10,
            ),
            GlobalButton(
              color: primaryColor,
              onPressed: () {
                Nav.toAll(KonsultantDashboard());
              },
              text: S.of(context).back,
              textStyle: TextStyle(color: Colors.white),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
