//rev
import 'dart:async';

import 'package:coolappflutter/data/data_global.dart';
import 'package:coolappflutter/data/provider/provider_user.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/chat/home_chat.dart';
import 'package:coolappflutter/presentation/pages/main/home_konsultant.dart';
import 'package:coolappflutter/presentation/pages/main/home_screen.dart';
import 'package:coolappflutter/presentation/pages/notification/notification_screen.dart';

import 'package:coolappflutter/presentation/pages/user/screen_settings.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/utils/notification_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavMenuScreen extends StatefulWidget {
  const NavMenuScreen({super.key});

  @override
  State<NavMenuScreen> createState() => _NavMenuScreenState();
}

class _NavMenuScreenState extends State<NavMenuScreen> {
  int currentIndex = 0;

  // Menggunakan lazy loading untuk HomeChat
  HomeChat? homeChatPage;
  bool hasClickedHomeChat =
      false; // Variabel untuk menghitung klik pada HomeChat

  // void klikTab(int val) {
  //   setState(() {
  //     currentIndex = val;

  //     if (val == 2) {
  //       // Jika HomeChat di-klik
  //       if (!hasClickedHomeChat) {
  //         // Pertama kali di-klik, set status
  //         hasClickedHomeChat = true;
  //         homeChatPage = HomeChat(klickTab: klikTab); // Inisialisasi HomeChat
  //       } else {
  //         // Jika sudah di-klik sebelumnya, panggil pengecekanIsProfiling
  //         pengecekanIsProfiling();
  //       }
  //     } else {
  //       // Reset status jika berpindah tab lain
  //       hasClickedHomeChat = false;
  //     }
  //   });
  // }
  klikTab(int val) {
    setState(() {
      currentIndex = val;
      // Hanya inisialisasi HomeChat jika belum ada, namun selalu trigger state
      if (val == 2) {
        homeChatPage =
            HomeChat(klickTab: klikTab); // Trigger ulang saat buka HomeChat
        pengecekanIsProfiling();
      }
    });
  }

  void pengecekanIsProfiling() async {
    await context.read<ProviderUser>().getUser(context);
    if (context.read<ProviderUser>().dataUser?.isProfiling != '1') {
      NotificationUtils.showDialogError(
        context,
        () {
          setState(() {
            currentIndex = 0; // Kembali ke tab Home
            hasClickedHomeChat = false; // Reset status
          }); // Kembali ke tab Home
          Nav.back(); // Kembali ke halaman sebelumnya
        },
        widget: Text(
          S.of(context).complete_profile_before_joining,
          textAlign: TextAlign.center,
        ),
        textButton: "Oke",
      );
    }
  }

  var menuTab = [
    {"icon": "images/menu/menu_home.png", "title": "Home"},
    {"icon": "images/menu/menu_notification.png", "title": "Notification"},
    {"icon": "images/menu/menu_chat.png", "title": "Chat"},
    {"icon": "images/menu/menu_setting.png", "title": "Setting"}
  ];

  List<Widget> viewMenu = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<ProviderUser>().getUser(context);
      // Periksa nilai is_affiliate untuk menentukan halaman Home
      final homePage = (dataGlobal.dataUser?.isAffiliate == 1)
          ? HomeKonsultant(klickTab: klikTab)
          : HomeScreen(klickTab: klikTab);

      // Perbarui viewMenu dengan halaman Home yang sesuai
      setState(() {
        viewMenu = [
          homePage, // Halaman Home dinamis berdasarkan is_affiliate
          NotificationScreen(),
          Container(), // Placeholder untuk tab Chat
          ScreenSettings(
            onLanguageChanged: () {
              Timer(const Duration(seconds: 3), () {
                debugPrint("cek screeen setting states");
                setState(() {
                  Provider.of<ProviderUser>(context, listen: false)
                      .getUser(context);
                });
              });
              setState(() {});
            },
          ),
        ];
      });
    });
    viewMenu = [
      dataGlobal.dataUser?.isAffiliate == 1
          ? HomeKonsultant(klickTab: klikTab)
          : HomeScreen(klickTab: klikTab),
      const NotificationScreen(),
      Container(), // Placeholder untuk tab Chat
      ScreenSettings(
        onLanguageChanged: () {
          Timer(const Duration(seconds: 3), () {
            debugPrint("cek screeen setting states");
            setState(() {
              Provider.of<ProviderUser>(context, listen: false)
                  .getUser(context);
            });
          });
          setState(() {});
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: [
          viewMenu[0],
          viewMenu[1],
          homeChatPage ?? Container(), // Muat HomeChat jika dipilih
          viewMenu[3],
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        onTap: (value) {
          klikTab(value);
        },
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        elevation: 30,
        showUnselectedLabels: true,
        unselectedLabelStyle: const TextStyle(color: Colors.black, fontSize: 8),
        unselectedItemColor: Colors.grey,
        selectedItemColor: primaryColor,
        items: menuTab.map((e) {
          return BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(e['icon']!)),
            label: e['title'] == "Home"
                ? S.of(context).home
                : e['title'] == "Notification"
                    ? S.of(context).notification
                    : e['title'] == "Chat"
                        ? S.of(context).chat
                        : e['title'] == "Setting"
                            ? S.of(context).setting
                            : "",
          );
        }).toList(),
      ),
    );
  }
}

// import 'package:coolappflutter/data/provider/provider_profiling.dart';
// import 'package:coolappflutter/presentation/pages/chat/home_chat.dart';
// import 'package:coolappflutter/presentation/pages/main/home_screen.dart';
// import 'package:coolappflutter/presentation/pages/notification/notification_screen.dart';
// import 'package:coolappflutter/presentation/pages/transakction/transaksi_affiliate.dart';
// import 'package:coolappflutter/presentation/pages/user/screen_settings.dart';
// import 'package:coolappflutter/presentation/theme/color_utils.dart';
// import 'package:coolappflutter/presentation/utils/nav_utils.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class NavMenuScreen extends StatefulWidget {
//   const NavMenuScreen({super.key});

//   @override
//   State<NavMenuScreen> createState() => _NavMenuScreenState();
// }

// class _NavMenuScreenState extends State<NavMenuScreen> {
//   int currentIndex = 0;

//   klikTab(int val) {
//     setState(() {
//       currentIndex = val;
//     });
//   }

//   var menuTab = [
//     {"icon": "images/menu/menu_home.png", "title": "Home"},
//     {"icon": "images/menu/menu_notification.png", "title": "Notification"},
//     {"icon": "images/menu/menu_chat.png", "title": "Chat"},
//     {"icon": "images/menu/menu_setting.png", "title": "Setting"}
//   ];

//   List viewMenu = [];

//   @override
//   void initState() {
//     super.initState();
//     viewMenu = [
//       HomeScreen(klickTab: klikTab),
//       const NotificationScreen(),
//       HomeChat(klickTab: klikTab),
//       ScreenSettings(
//         onLanguageChanged: () {
//           setState(() {});
//         },
//       ),
//     ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       // floatingActionButton: FloatingActionButton(
//       //     backgroundColor: primaryColor,
//       //     onPressed: () async {},
//       //     child: Image.asset(
//       //       'images/thinking.png',
//       //       color: Colors.white,
//       //       scale: 5,
//       //     )),
//       body: viewMenu[currentIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: Colors.white,
//         onTap: (value) {
//           klikTab(value);
//         },
//         currentIndex: currentIndex,
//         type: BottomNavigationBarType.fixed,
//         elevation: 30,
//         // selectedFontSize: 15,
//         showUnselectedLabels: true,
//         unselectedLabelStyle: const TextStyle(color: Colors.black, fontSize: 8),
//         unselectedItemColor: Colors.grey,
//         // selectedIconTheme:
//         //     const IconThemeData(color: Color(0xFFFC5F2E), size: 20),
//         selectedItemColor: primaryColor,
//         items: menuTab.map((e) {
//           return BottomNavigationBarItem(
//             icon: ImageIcon(AssetImage(e['icon']!)), // Menggunakan nilai 'icon'
//             label: e['title'], // Menggunakan nilai 'title'
//           );
//         }).toList(),
//       ),
//     );
//   }
// }
