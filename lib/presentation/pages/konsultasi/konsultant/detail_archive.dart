import 'package:coolappflutter/data/apps/app_assets.dart';
import 'package:coolappflutter/data/provider/provider_consultant.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/Normal_User/pop-upwarning.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/Normal_User/profile_card.dart';
import 'package:coolappflutter/presentation/pages/curhat/card_curhat.dart';
import 'package:coolappflutter/presentation/pages/curhat/normal_user/chat/chatbox_curhat.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/konsultant/chat/chat_archive.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/konsultant/konsultant_dashboard.dart';
import 'package:coolappflutter/presentation/pages/payments/payment_page.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/widgets/Container/Container_Promo.dart';
import 'package:coolappflutter/presentation/widgets/Container/container_status.dart';
import 'package:coolappflutter/presentation/widgets/GlobalButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailArchivePage extends StatefulWidget {
  const DetailArchivePage(
      {super.key,
        this.profilePicture,
        this.participantName,
        this.typeConsultation,
        this.type,
        this.bloodType,
        this.rate,
        this.consultationTime,
        this.remainingMinutes,
        this.theme,
        this.explanation,
        this.comisson,
        this.id_consultation});
  final participantName;
  final typeConsultation;
  final bloodType;
  final rate;
  final comisson;
  final theme;
  final explanation;
  final consultationTime;
  final type;
  final remainingMinutes;
  final id_consultation;
  final profilePicture;

  @override
  State<DetailArchivePage> createState() => _DetailArchivePageState();
}

class _DetailArchivePageState extends State<DetailArchivePage> {
  bool isConfirmed = false;
  int _selectedRating = 0;
  bool _showTextField = false;

  @override
  void initState() {
    super.initState();
    _selectedRating = widget.rate ?? 0; // Pastikan nilai default jika null
  }
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
        child: SingleChildScrollView(
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
              SizedBox(height: 16.0),
              CardCurhat(
                type: widget.type ?? 'konsultasi',
                CurhatTimeSelected: widget.consultationTime ?? "00.00",
              ),
              SizedBox(
                height: 20,
              ),
              RequestContainer(
                dataRequest: widget.type ?? '',
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _showTextField = !_showTextField; // Toggle antara true/false
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.of(context).clientExplanation,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    _showTextField
                        ? Icon(CupertinoIcons.chevron_down) : Icon(CupertinoIcons.forward)
                  ],
                ),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 300), // Durasi animasi
                curve: Curves.easeInOut, // Efek animasi lebih halus
                height: _showTextField ? 100 : 0, // Tinggi berubah saat ditampilkan
                child: _showTextField
                    ? TextField(
                  enabled: false,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: widget.explanation ?? S.of(context).clientExplanation,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                )
                    : SizedBox(), // Menampilkan kosong saat tidak dibuka
              ),

              SizedBox(height: 20),
              Text(
                S.of(context).clientRating,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(5, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Icon(
                    Icons.star,
                    color: index < _selectedRating ? Colors.yellow : Colors.grey,
                    size: 40,
                    ),
                  );
                }),
              ),
              SizedBox(height: 10),
              Text(S.of(context).clientComment,style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),),
              SizedBox(
                height: 10,
              ),
              TextField(
                enabled: false,
                maxLines: 5,
                decoration: InputDecoration(
                    hintText: S.of(context).clientComment,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey.shade300))),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                color: Colors.lightBlueAccent.shade100,
                height: 60,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(S.of(context).earnedCommission),
                          Text('Rp. ${widget?.comisson ?? '0'}'),
                        ],
                      ),
                      Divider(
                        color: BlueColor,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              MaterialButton(
                minWidth: double.infinity,
                onPressed: () {
                  Nav.to(ChatArchivebyConsultant());
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(color: Colors.red, width: 2), // Garis tepi merah
                ),
                color: Colors.white, // Warna latar putih
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                child: Text(
                  S.of(context).viewArchive,
                  style: TextStyle(
                    color: Colors.red, // Warna teks merah
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
