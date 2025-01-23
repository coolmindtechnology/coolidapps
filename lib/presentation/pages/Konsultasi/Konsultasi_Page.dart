import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/Histori_Consultant.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/New_Konsultasi.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/Tab/Tab_Arsip.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/Tab/Tab_Request.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/Tab/Tab_Sesi.dart';
import 'package:coolappflutter/presentation/pages/main/promo_page.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main/components/container_slider_home.dart';

class KonsultasiPage extends StatefulWidget {
  const KonsultasiPage({super.key});

  @override
  State<KonsultasiPage> createState() => _KonsultasiPageState();
}

class _KonsultasiPageState extends State<KonsultasiPage> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // Menampilkan dialog setelah halaman pertama kali dirender
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showPromoDialog();
    });
  }

  // Menampilkan dialog promo
  void _showPromoDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const Dialog(
          child: PromoPopup(), // Popup sesuai dengan widget yang Anda inginkan
        );
      },
    );
  }

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _tabs = [
    const TabSesi(), // Halaman Tab 1
    const TabRequest(), // Halaman Tab 2
    const TabArsip(), // Halaman Tab 3
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Row(
          children: [
            Text(
              S.of(context).Consultation,
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
                'images/konsultasi/mark.png',
                height: 40,
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ContainerSliderHome(
              text: S.of(context).Coolapp_consultation_space,
              imageUrl: 'images/konsultasi/dashboard.png',
              textColor: Colors.white,
              containerColor: Colors.orange,
              textSize: 15,
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Nav.to(const NewKonsultasi());
              },
              child: Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: BlueColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(CupertinoIcons.chat_bubble_2_fill,
                          color: YellowColor),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(S.of(context).New_consultation_session,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600)),
                      const Spacer(),
                      const Icon(
                        CupertinoIcons.chevron_forward,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildTab(index: 0, text: S.of(context).Active_session),
                _buildTab(index: 1, text: S.of(context).Requests),
                _buildTab(index: 2, text: S.of(context).Archives),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    Nav.to(const HistoryConsultant());
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
        margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : BlueColor,
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.white,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          text,
          style: TextStyle(
              color: isSelected ? Colors.blue : Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 10),
        ),
      ),
    );
  }
}
