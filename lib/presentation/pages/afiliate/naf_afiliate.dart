import 'package:coolappflutter/presentation/pages/transakction/transaksi_affiliate.dart';
import 'package:coolappflutter/presentation/pages/afiliate/home_affiliate.dart';
import 'package:coolappflutter/presentation/pages/afiliate/setting_affiliate.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:flutter/material.dart';

class NafAffiliate extends StatefulWidget {
  const NafAffiliate({super.key});

  @override
  State<NafAffiliate> createState() => _NafAffiliateState();
}

class _NafAffiliateState extends State<NafAffiliate> {
  int currentIndex = 0;

  /// Affiliate
  int _initialIndexTabAffiliate = 0;
  void Function(int)? changeTabAffiliate;

  klikTab(int val) {
    setState(() {
      currentIndex = val;
    });
  }

  klikTabAffiliate(int initialIndex) async {
    _initialIndexTabAffiliate = initialIndex;
    setState(() {
      currentIndex = 1;
    });
    // await Future.delayed(Duration(milliseconds: 300));
    changeTabAffiliate!(initialIndex);
  }

  int initialTabAffiliate() => _initialIndexTabAffiliate;

  var menuTab = [
    "assets/icons/home.png",
    "assets/icons/swap.png",
    "assets/icons/setting.png",
  ];

  List viewMenu = [];

  @override
  void initState() {
    super.initState();
    viewMenu = [
      HomeAffiliate(klickTabAffiliate: klikTabAffiliate),
      TransaksiAffiliatePage(
        initialTab: initialTabAffiliate,
        tabChanger: (void Function(int) changeTabAffiliate) {
          this.changeTabAffiliate = changeTabAffiliate;
        },
      ),
      const SettingAffiliate()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: viewMenu[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            klikTab(value);
          },
          currentIndex: currentIndex,
          unselectedItemColor: greyColor,
          selectedItemColor: primaryColor,
          items: menuTab.map((e) {
            return BottomNavigationBarItem(
                icon: ImageIcon(AssetImage(e)), label: "");
          }).toList()),
    );
  }
}
