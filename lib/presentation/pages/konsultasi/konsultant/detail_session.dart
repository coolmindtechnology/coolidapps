import 'package:coolappflutter/data/apps/app_assets.dart';
import 'package:coolappflutter/data/apps/app_sizes.dart';
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

class DetailSessionPage extends StatefulWidget {
  const DetailSessionPage(
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
  State<DetailSessionPage> createState() => _DetailSessionPageState();
}

class _DetailSessionPageState extends State<DetailSessionPage> {
  bool isConfirmed = false;
  TextEditingController alasan = TextEditingController();
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
              S.of(context).Session_Details,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: BlueColor,
              ),
            ),
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
            Row(
              children: [
                SizedBox(
                  width: 180,
                  child: GlobalButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            backgroundColor: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize
                                    .min, // Menjaga dialog sesuai dengan ukuran konten
                                children: [
                                  Center(
                                    child: Text(
                                      S.of(context).rejectRequest,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Darkred,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10), // Jarak antara teks
                                  Text(
                                    S.of(context).provideYourReason,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  gapH10,
                                  TextField(
                                    controller: alasan,
                                    maxLines: 10,
                                    decoration: InputDecoration(
                                      hintText: S.of(context).exampleReason,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide.none),
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                          15), // Jarak antara TextField dan tombol
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceEvenly, // Menyebarkan tombol secara merata
                                    children: [
                                      Expanded(
                                        child: GlobalButton(
                                          onPressed: () {
                                            Navigator.pop(
                                                context); // Menutup dialog
                                          },
                                          color: Colors.white,
                                          text: S.of(context).cancel,
                                          textStyle:
                                              TextStyle(color: primaryColor),
                                        ),
                                      ),
                                      SizedBox(
                                          width:
                                              10), // Menambahkan jarak antar tombol
                                      Expanded(child:
                                          Consumer<ConsultantProvider>(
                                              builder: (context, provider, _) {
                                        return GlobalButton(
                                          onPressed: () async {
                                            await provider.RejectByConsultant(
                                                context,
                                                widget.id_consultation,
                                                alasan.text);
                                          },
                                          color: Darkred,
                                          text: S.of(context).reject,
                                          textStyle:
                                              TextStyle(color: Colors.white),
                                        );
                                      })),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    color: Colors.white,
                    text: S.of(context).Rejected,
                    textStyle: TextStyle(color: Colors.red),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Consumer<ConsultantProvider>(
                      builder: (context, provider, _) {
                    return SizedBox(
                      width: 170,
                      child: GlobalButton(
                          onPressed: () async {
                            await provider.approveByConsultant(
                              context,
                              widget.id_consultation,
                              widget.type,
                            );
                          },
                          color: primaryColor,
                          text: S.of(context).next),
                    );
                  }),
                )
              ],
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
