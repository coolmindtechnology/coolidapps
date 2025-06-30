import 'dart:async';

import 'package:coolappflutter/data/provider/provider_consultant.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/widgets/GlobalButton.dart';
import 'package:coolappflutter/presentation/widgets/costum_floatingbutton.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../../data/apps/app_sizes.dart';
import '../../../../data/locals/preference_handler.dart';
import '../../../../data/locals/shared_pref.dart';
import '../../main/home_screen.dart';
import 'card_consultant.dart';
import 'profile_card.dart';

class SummaryConsultant extends StatefulWidget {
  const SummaryConsultant(
      {super.key,
      required this.consultId,
      required this.themeId,
      required this.partisipant,
      required this.typeSession,
      required this.time,
      required this.imagePath,
      required this.name,
      required this.title,
      required this.bloodType,
      required this.location,
      required this.getSesi});
  final String consultId;
  final String themeId;
  final String partisipant;
  final String typeSession;
  final String time;
  final String imagePath;
  final String name;
  final String title;
  final String bloodType;
  final String location;
  final String getSesi;

  @override
  State<SummaryConsultant> createState() => _SummaryConsultantState();
}

class _SummaryConsultantState extends State<SummaryConsultant> {

  @override
  void initState() {
    super.initState();
    cekSession();
    // Pecah "08:00 - 08:30" menjadi dua bagian
    final timeParts = widget.time.split(' - ');
    final timeStart = timeParts[0]; // "08:00"
    final timeEnd = timeParts[1];   // "08:30"

    // Ambil hari ini dalam bahasa Inggris
    final now = DateTime.now();
    final day = DateFormat('EEEE').format(now); // Hasil: "Monday", "Tuesday", dst.

    // Debug (opsional)
    print("Start: $timeStart, End: $timeEnd, Day: $day");

    // Panggil getPrice dengan parameter yang sesuai
    context.read<ConsultantProvider>().getPrice(
      context,
      timeStart: timeStart,
      timeEnd: timeEnd,
      day: day,
      type: widget.typeSession,
    );
  }

  Future<void> cekSession() async {
    dynamic ceklanguage = await PreferenceHandler.retrieveISelectLanguage();
    if (ceklanguage == null) {
      Prefs().setLocale('en_US', () {
        S.load(Locale('en_US'));
      });
    } else {
      Prefs().setLocale('$ceklanguage', () {
        S.load(Locale('$ceklanguage'));
      });
    }

    // Tambahkan logika ini DI SINI
    getTimeParts();
  }

  void getTimeParts() {
    final timeParts = widget.time.split(' - ');
    final timeStart = timeParts[0];
    final timeEnd = timeParts[1];

    final now = DateTime.now();
    final day = DateFormat('EEEE').format(now);

    print("Start: $timeStart, End: $timeEnd, Day: $day");

    context.read<ConsultantProvider>().getPrice(
      context,
      timeStart: timeStart,
      timeEnd: timeEnd,
      day: day,
      type: widget.typeSession,
    );
  }


  bool isConfirmed = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<ConsultantProvider>(builder: (context, provider, _) {
      bool loading = provider.isLoadingPrice;
      return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text(
            S.of(context).Session_Summary,
            style: TextStyle(color: Colors.white),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        body: loading ? Column(
          children: [
            shimmerContainer(height: 150, width: double.infinity),
            gapH10,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(child: shimmerButton()),
                gapW10,
                Expanded(child: shimmerButton()),
              ],
            ),
            gapH20,
            shimmerButton(),
            gapH20,
            shimmerButton(),
            gapH32,
            shimmerButton(),
          ],
        ) :Padding(
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
                  imagePath: widget.imagePath,
                  name: widget.name,
                  title: widget.title,
                  bloodType: widget.bloodType,
                  location: widget.location,
                  time: widget.time,
                  timeRemaining: '${widget.getSesi} Sesi Selesai',
                  timeColor: BlueColor,
                  status: 'Pencapaian ',
                  warnastatus: Colors.white),
              SizedBox(height: 16.0),
              CardConsultant(
                topic: S.of(context).Selected_topic,
                topicSelected: widget.partisipant,
                consultationTime: S.of(context).Consultation_time,
                consultationTimeSelected: widget.time,
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                enabled: false,
                maxLines: 5,
                decoration: InputDecoration(
                    hintText: widget.partisipant,
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
                          Text(
                            (provider.priceData?.data?.price == 0)
                                ? S.of(context).FREE
                                : "Rp ${provider.priceData?.data?.price}",
                          ),
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
              if (isConfirmed)
                provider.isCreatingConsultation ? Center(child: CircularProgressIndicator(color: primaryColor,)) : GlobalButton(
                  onPressed: () {
                    provider.createConsultation(context,
                        consultantId: widget.consultId,
                        themeId: widget.themeId,
                        participantExplanation: widget.partisipant,
                        time: widget.time,
                        typeSession: widget.typeSession);
                  },
                  color: primaryColor,
                  text: S.of(context).next,
                )
            ],
          ),
        ),
        floatingActionButton: const CustomFAB(),
      );
    });
  }
}
