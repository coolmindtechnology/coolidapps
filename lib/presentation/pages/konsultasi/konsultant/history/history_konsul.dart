import 'package:coolappflutter/data/apps/app_assets.dart';
import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:coolappflutter/data/provider/provider_consultant.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/Normal_User/Histori_Consultant.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/konsultant/Tab/tab_arsip.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/konsultant/Tab/tab_request.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/konsultant/Tab/tab_session.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/konsultant/Tab/tab_wait.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/konsultant/history/Tab/tab_arsip.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/konsultant/history/Tab/tab_request.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/konsultant/history/Tab/tab_session.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/konsultant/history/Tab/tab_wait.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/konsultant/history/hisotry_komisen.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/konsultant/history/history_curhat.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/konsultant/history/history_konsul.dart';
import 'package:coolappflutter/presentation/pages/main/nav_home.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/widgets/Container/container_slider_home.dart';
import 'package:coolappflutter/presentation/widgets/costum_floatingbutton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class HisotryKonsultasi extends StatefulWidget {
  const HisotryKonsultasi({super.key});

  @override
  State<HisotryKonsultasi> createState() => _HisotryKonsultasiState();
}

class _HisotryKonsultasiState extends State<HisotryKonsultasi> {
  int _selectedIndex = 0;

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();

    // Panggil fungsi getHomeConsultant
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<ConsultantProvider>(context, listen: false);
      provider.getHomeConsultant(context);
    });
  }

  final List<Widget> _tabs = [
    TabHistorySession(type: "consultation",),
    TabHistoryRequest(type: "consultation",),
    TabHisotryWaiting(type: "consultation",),
    TabHistoryArsip(type: "consultation",),
  ];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ConsultantProvider>(context);
    final homeConsultantData = provider.homeConsultantData;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              S.of(context).Consultation_History,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w600,fontSize: 20),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildTab(index: 0, text: S.of(context).Active_session),
                  _buildTab(index: 1, text: S.of(context).Requests),
                  _buildTab(index: 2, text: S.of(context).Awaiting_Payment),
                  _buildTab(index: 3, text: S.of(context).Archives),
                ],
              ),
            ),
            Expanded(
              child: _tabs[_selectedIndex],
            ),
          ],
        ),
      ),
      floatingActionButton: const CustomFAB(),
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
