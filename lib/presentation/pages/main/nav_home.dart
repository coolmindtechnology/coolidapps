import 'package:cool_app/data/provider/provider_profiling.dart';
import 'package:cool_app/presentation/pages/chat/home_chat.dart';
import 'package:cool_app/presentation/pages/main/home_screen.dart';
import 'package:cool_app/presentation/pages/notification/notification_screen.dart';
import 'package:cool_app/presentation/pages/transakction/transaksi_affiliate.dart';
import 'package:cool_app/presentation/pages/user/screen_settings.dart';
import 'package:cool_app/presentation/theme/color_utils.dart';
import 'package:cool_app/presentation/utils/nav_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavMenuScreen extends StatefulWidget {
  const NavMenuScreen({super.key});

  @override
  State<NavMenuScreen> createState() => _NavMenuScreenState();
}

class _NavMenuScreenState extends State<NavMenuScreen> {
  int currentIndex = 0;

  klikTab(int val) {
    setState(() {
      currentIndex = val;
    });
  }

  var menuTab = [
    "images/menu/menu_home.png",
    "images/menu/menu_notification.png",
    "images/menu/menu_chat.png",
    "images/menu/menu_setting.png",
  ];

  List viewMenu = [];

  @override
  void initState() {
    super.initState();
    viewMenu = [
      HomeScreen(klickTab: klikTab),
      const NotificationScreen(),
      HomeChat(klickTab: klikTab),
      ScreenSettings(
        onLanguageChanged: () {
          setState(() {});
        },
      ),
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
          unselectedItemColor: Colors.grey,
          selectedItemColor: primaryColor,
          items: menuTab.map((e) {
            return BottomNavigationBarItem(
                icon: ImageIcon(AssetImage(e)), label: "");
          }).toList()),
    );
  }
}
