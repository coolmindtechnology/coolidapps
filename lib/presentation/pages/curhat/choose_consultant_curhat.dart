import 'package:coolappflutter/data/provider/provider_consultation.dart';
import 'package:coolappflutter/generated/l10n.dart';

import 'package:coolappflutter/presentation/pages/Konsultasi/Normal_User/form_konsultasi.dart';
import 'package:coolappflutter/presentation/pages/curhat/form_isian_curhat.dart';
import 'package:coolappflutter/presentation/pages/curhat/session_time_curhat.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/normal_user/card_consultant.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/normal_user/profile_card.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/normal_user/profile_consultant.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/normal_user/sessions_time.dart';

import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/widgets/GlobalButton.dart';
import 'package:coolappflutter/presentation/widgets/costum_floatingbutton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChooseConsultantCurhat extends StatefulWidget {
  const ChooseConsultantCurhat(
      {super.key,
      required this.getTime,
      required this.getTopik,
      required this.getIdTheme});
  final String getTime;
  final String getTopik;
  final String getIdTheme;

  @override
  State<ChooseConsultantCurhat> createState() => _ChooseConsultantCurhatState();
}

class _ChooseConsultantCurhatState extends State<ChooseConsultantCurhat> {
  // Menyimpan indeks item yang dipilih
  int? _selectedIndex;
  int? selectId;

  final List<Map<String, dynamic>> profileData = [
    {
      "imagePath": 'images/konsultasi/profile2.png',
      "name": 'John Doe',
      "title": 'Strategist',
      "bloodType": 'O',
      "location": 'Jakarta, Indonesia',
      "time": '10:00 - 10:30',
      "timeRemaining": '345 Sesi Selesai',
    },
    {
      "imagePath": 'images/konsultasi/profile1.png',
      "name": 'Vivian Entira',
      "title": 'Creative',
      "bloodType": 'B',
      "location": 'Cirebon, Jawa Barat',
      "time": '09:00 - 09:30',
      "timeRemaining": '345 Sesi Selesai',
    },
    {
      "imagePath": 'images/konsultasi/profile3.png',
      "name": 'Alice Smith',
      "title": 'Innovator',
      "bloodType": 'A',
      "location": 'Surabaya, Jawa Timur',
      "time": '11:00 - 11:30',
      "timeRemaining": '345 Sesi Selesai',
    }
  ];
  @override
  void initState() {
    Provider.of<ProviderConsultation>(context, listen: false)
        .getListConsultanPerson(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderConsultation>(builder: (context, provider, _) {
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
                S.of(context).Pick_Consultant,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: BlueColor,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                S.of(context).choose,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(fontSize: 14.0, color: Colors.black54),
              ),
              SizedBox(height: 16.0),
              CardConsultant(
                topic: S.of(context).choose,
                topicSelected: widget.getTopik,
                consultationTime: S.of(context).Consultation_time,
                consultationTimeSelected: widget.getTime,
                onTap: () {
                  Nav.to(SessionTimeCurhat(
                    getTopik: widget.getTopik,
                    getId: widget.getIdTheme,
                  ));
                },
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 400,
                child: ListView.builder(
                  itemCount: provider.consultantsPerson.length,
                  itemBuilder: (context, index) {
                    final profile = provider.consultantsPerson.length;
                    return GestureDetector(
                      onTap: () {
                        // Nav.toAll(ProfileConsultant());
                        setState(() {
                          _selectedIndex = index; // Set indeks yang dipilih
                        });
                        selectId = index;
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: _selectedIndex == index
                                ? BlueColor // Warna biru untuk item yang dipilih
                                : Colors.transparent,
                            width: 3, // Ketebalan border
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            ProfileCard(
                              imagePath:
                                  provider.consultantsPerson[index].image,
                              name: provider.consultantsPerson[index].name,
                              title:
                                  provider.consultantsPerson[index].typeBrain,
                              bloodType:
                                  provider.consultantsPerson[index].typeBlood,
                              location:
                                  provider.consultantsPerson[index].address,
                              time: widget.getTime,
                              timeRemaining: provider
                                  .consultantsPerson[index].sessionSuccess
                                  .toString(),
                              timeColor: BlueColor,
                              status: S.of(context).Achievement,
                              warnastatus: Colors.white,
                              onTap: () {
                                // Nav.toAll(ProfileConsultant());
                                setState(() {
                                  _selectedIndex =
                                      index; // Set indeks yang dipilih
                                });
                                selectId = index;
                              }, // Aksi jika ada
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Spacer(),
              GlobalButton(
                onPressed: () {
                  Nav.to(FormIsianCurhat(
                    id: provider.consultantsPerson[selectId!].id,
                    getTime: widget.getTime,
                    getTopik: widget.getTopik,
                    getSesi: provider
                        .consultantsPerson[selectId!].sessionSuccess
                        .toString(),
                    getThemeId: widget.getIdTheme,
                  ));
                  // id :provider.consultantsPerson[index].id )
                },
                color: primaryColor,
                text: S.of(context).next,
              ),
            ],
          ),
        ),
        floatingActionButton: const CustomFAB(),
      );
    });
  }
}
