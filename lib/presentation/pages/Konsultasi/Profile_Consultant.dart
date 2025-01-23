import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/Profile_Card.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';

import 'package:coolappflutter/presentation/widgets/GlobalButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/Container_Follower.dart';

class ProfileConsultant extends StatefulWidget {
  const ProfileConsultant({super.key});

  @override
  State<ProfileConsultant> createState() => _ProfileConsultantState();
}

class _ProfileConsultantState extends State<ProfileConsultant> {
  final List<Map<String, dynamic>> data = [
    {'title': 'Dipresi', 'jumlah': 10},
    {'title': 'Kesehatan', 'jumlah': 20},
    {'title': 'Karir', 'jumlah': 30},
    {'title': 'Ide', 'jumlah': 40},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            S.of(context).Consultant_Profile,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                primaryColor,
                Colors.white,
              ],
              stops: const [0.1, 0.35],
              begin: Alignment.topCenter,
              end: Alignment.center,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileCard(
                      imagePath: 'images/konsultasi/profile1.png',
                      name: 'vivian Entira',
                      title: 'Creative',
                      bloodType: 'B',
                      location: 'Cirebon, jawa barat',
                      time: '09,00 - 0.9.30 ',
                      timeRemaining: '',
                      timeColor: BlueColor,
                      status: '',
                      warnastatus: Colors.white),
                  ContainerFollower(
                    title1: S.of(context).Post,
                    subtitle1: '5',
                    title2: S.of(context).Follower,
                    subtitle2: '6',
                    title3: S.of(context).following,
                    subtitle3: '6',
                  ),
                  GlobalButton(
                      onPressed: () {},
                      color: primaryColor,
                      text: S.of(context).Follow_on_Coolchat),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    S.of(context).Related_Topics,
                    style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Menentukan jumlah kolom
                        crossAxisSpacing: 10, // Jarak antar kolom
                        mainAxisSpacing: 10, // Jarak antar baris
                      ),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 30,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                primaryColor,
                                Colors.white,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.center,
                            ),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data[index]['title'], // Menampilkan title
                                    style: TextStyle(
                                        color: BlueColor, fontSize: 16),
                                  ),
                                  Text(
                                    '+ ${data[index]['jumlah']} ${S.of(context).Discussing_This}', // Menampilkan jumlah
                                    style: TextStyle(
                                        color: BlueColor, fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
