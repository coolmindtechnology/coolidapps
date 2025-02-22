import 'package:coolappflutter/data/apps/app_assets.dart';
import 'package:coolappflutter/generated/l10n.dart';

import 'package:coolappflutter/presentation/pages/curhat/normal_user/choose_session.dart';
import 'package:coolappflutter/presentation/pages/curhat/normal_user/histori_curhat.dart';
import 'package:coolappflutter/presentation/pages/curhat/normal_user/tab/tab_arsip.dart';
import 'package:coolappflutter/presentation/pages/curhat/normal_user/tab/tab_request.dart';
import 'package:coolappflutter/presentation/pages/curhat/normal_user/tab/tab_session.dart';
import 'package:coolappflutter/presentation/pages/curhat/session_time_curhat.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/normal_user/sessions_time.dart';

import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/widgets/Container/container_slider_home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CurhatDashboard extends StatefulWidget {
  const CurhatDashboard({super.key});

  @override
  State<CurhatDashboard> createState() => _CurhatDashboardState();
}

class _CurhatDashboardState extends State<CurhatDashboard> {
  int _selectedIndex = 0;

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _tabs = [
    TabSesiCurhat(), // Halaman Tab 1
    TabRequestCurhat(), // Halaman Tab 2
    TabArsipCurhat(), // Halaman Tab 3
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Row(
          children: [
            Text(
              S.of(context).Curhat,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.only(
                  right: 10), // Memberikan jarak dari kanan
              child: Image.asset(
                AppAsset.icMark,
                height: 40,
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ContainerSliderHome(
              text: S.of(context).COOLAPP_Now_With_Confiding_Space,
              imageUrl: AppAsset.imgCurhatDashboad,
              textColor: Colors.white,
              containerColor: primaryColor,
              textSize: 15,
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Nav.to(SessionTimeCurhat(
                  getTopik: '',
                  getId: '',
                ));
              },
              child: Container(
                width: 400,
                decoration: BoxDecoration(
                  color: BlueColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Icon(
                      CupertinoIcons.person_2_fill,
                      color: YellowColor,
                      size: 40,
                    ),
                    title: Text(S.of(context).New_Confiding_Session,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600)),
                    subtitle: Text(S.of(context).Dont_Be_Shy,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400)),
                    trailing: Icon(
                      CupertinoIcons.chevron_forward,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildTab(
                  index: 0,
                  text: S.of(context).Active_session,
                ),
                _buildTab(index: 1, text: S.of(context).Requests),
                _buildTab(index: 2, text: S.of(context).Archives),
                Spacer(),
                TextButton(
                  onPressed: () {
                    Nav.to(Archive_Curhat());
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: BlueColor,
                  ),
                  child: Text(S.of(context).see_all),
                )
              ],
            ),
            Expanded(
              child: _tabs[_selectedIndex],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab({required int index, required String text}) {
    final bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onTabSelected(index),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 2, vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : BlueColor,
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.white,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          text,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(
              color: isSelected ? Colors.blue : Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 10),
        ),
      ),
    );
  }
}
