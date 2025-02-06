import 'package:coolappflutter/generated/l10n.dart';

import 'package:coolappflutter/presentation/pages/Konsultasi/Normal_User/konsultasi_page.dart';

import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';

import 'package:coolappflutter/presentation/widgets/GlobalButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../data/provider/provider_consultation.dart';
import '../../../widgets/Container/container_promo.dart';
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
  bool isConfirmed = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderConsultation>(builder: (context, provider, _) {
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
                          Text(S.of(context).FREE),
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
                GlobalButton(
                  onPressed: () {
                    provider.createConsultation(
                        context,
                        widget.consultId,
                        widget.themeId,
                        widget.partisipant,
                        widget.typeSession,
                        widget.time);
                    if (provider.isLoading == false)
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          // Timer untuk navigasi otomatis setelah 3 detik
                          Future.delayed(Duration(seconds: 3), () {
                            Nav.toAll(KonsultasiPage()); // Ganti ke rute tujuan
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
    });
  }
}
