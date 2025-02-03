import 'package:coolappflutter/data/provider/provider_consultation.dart';
import 'package:coolappflutter/generated/l10n.dart';

import 'package:coolappflutter/presentation/pages/Konsultasi/Normal_User/new_konsultasi.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/Normal_User/Tab/tab_arsip.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/Normal_User/Tab/tab_request.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/Normal_User/Tab/tab_sesi.dart';
import 'package:coolappflutter/presentation/pages/main/promo_page.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/widgets/Container/container_slider_home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../konsultasi/normal_user/histori_consultant.dart';

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
    Provider.of<ProviderConsultation>(context, listen: false)
        .getListConsultations(context, "active");
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
        return Dialog(
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
    TabSesi(), // Halaman Tab 1
    TabRequest(), // Halaman Tab 2
    TabArsip(), // Halaman Tab 3
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderConsultation>(
        builder: (BuildContext context, valueConsultation, Widget? child) {
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
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    Nav.to(NewKonsultasi());
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
                          SizedBox(
                            width: 10,
                          ),
                          Text(S.of(context).New_consultation_session,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600)),
                          Spacer(),
                          Icon(
                            CupertinoIcons.chevron_forward,
                            color: Colors.white,
                          ),
                        ],
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
                        Nav.to(HistoryConsultant());
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
          ));
    });
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
