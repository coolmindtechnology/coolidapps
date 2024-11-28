// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:android_intent_plus/android_intent.dart';
import 'package:coolappflutter/data/locals/shared_pref.dart';
import 'package:coolappflutter/data/provider/provider_boarding.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/on_boarding2.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ObBoarding extends StatefulWidget {
  // final void Function() onChanged;
  const ObBoarding({super.key, this.codeReferral});
  final String? codeReferral;

  @override
  State<ObBoarding> createState() => _ObBoardingState();
}

class _ObBoardingState extends State<ObBoarding> {
  bool isDeepLinkActivated = false;
  @override
  void initState() {
    Timer(const Duration(seconds: 2), () {
      checkDeepLinkStatus();
    });
    super.initState();
  }

  String isSelected = "";
  void selectBahasa(String? val) {
    setState(() {
      isSelected = val ?? "";
    });
  }

  Future<void> checkDeepLinkStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Membaca status deep linking, jika 1 berarti sudah diaktifkan
    setState(() {
      isDeepLinkActivated = prefs.getInt('deepLinkStatus') == 1;
    });

    if (!isDeepLinkActivated) {
      // Tampilkan popup jika deep linking belum diaktifkan
      showSettingsDialog();
    } else {
      // Lakukan tindakan jika deep linking sudah diaktifkan
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text('Deep linking sudah diaktifkan!')),
      // );
    }
  }

  Future<void> setDeepLinkActivated() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Menyimpan nilai 1 yang berarti deep linking sudah diaktifkan
    await prefs.setInt('deepLinkStatus', 1);
  }

  void showSettingsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Pengaturan Diperlukan"),
          content: const Text(
              "Untuk mengakses fitur deeplink, silakan izinkan akses Set as default lalu berikan izin pada supported web addresses."),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                setDeepLinkActivated();
                openAppSettingss();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void openAppSettingss() {
    const AndroidIntent intent = AndroidIntent(
      action: 'android.settings.APPLICATION_DETAILS_SETTINGS',
      data: 'package:mycool.tech.com', // Sesuaikan dengan package aplikasi kamu
    );
    intent.launch().catchError((error) {
      print("Error membuka pengaturan aplikasi: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 60,
          ),
          Center(
            child: Image.asset(
              "images/logo_coolapp_new.png",
              height: 60,
              width: 194,
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          Text(
            S.of(context).choose_language,
            style: TextStyle(
                color: whiteColor, fontSize: 20, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: 2,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    debugPrint("cek bahasa $index");
                    setState(() {
                      selectBahasa(
                        index == 0 ? "Indonesia" : "English",
                      );
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 2, color: Colors.white)),
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          index == 0
                              ? "${"🇮🇩"} Indonesia"
                              : "${"🇺🇸"} English",
                          style: const TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          height: 24,
                          width: 24,
                          child: Radio(
                            fillColor: MaterialStateColor.resolveWith(
                                (states) => Colors.white),
                            focusColor: Colors.white,
                            value: index == 0 ? "Indonesia" : "English",
                            groupValue: isSelected,
                            onChanged: (String? value) {
                              debugPrint("cek bahasa $index");
                              selectBahasa(value);
                            },
                            activeColor: Colors.white,
                            hoverColor: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Padding(padding: EdgeInsets.only(bottom: 16));
              },
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: MaterialButton(
                minWidth: MediaQuery.of(context).size.width,
                height: 55,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: Colors.white,
                textColor: primaryColor,
                child: Text(
                  S.of(context).next,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();

                  if (isSelected == "Indonesia") {
                    Prefs().setLocale('id_ID', () {
                      setState(() {
                        S.load(const Locale('id_ID'));
                      });
                    });
                  } else if (isSelected == "English") {
                    Prefs().setLocale('en_US', () {
                      setState(() {
                        S.load(const Locale('en_US'));
                      });
                    });
                  } else if (isSelected == "English") {
                    Prefs().setLocale('en_US', () {
                      setState(() {
                        S.load(const Locale('en_US'));
                      });
                    });
                  }
                  await prefs.setBool("lang_dialog_showed", true);

                  context
                      .read<ProviderBoarding>()
                      .getSOnBoarding(context)
                      .then((value) {
                    Nav.replace(const ObBoarding2());
                  });
                }),
          ),
        ],
      ),
    );
  }
}


//tes 3 bahasa
// import 'package:coolappflutter/data/locals/shared_pref.dart';
// import 'package:coolappflutter/data/provider/provider_boarding.dart';
// import 'package:coolappflutter/generated/l10n.dart';
// import 'package:coolappflutter/presentation/on_boarding2.dart';
// import 'package:coolappflutter/presentation/theme/color_utils.dart';
// import 'package:coolappflutter/presentation/utils/nav_utils.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ObBoarding extends StatefulWidget {
//   const ObBoarding({super.key, this.codeReferral});
//   final String? codeReferral;

//   @override
//   State<ObBoarding> createState() => _ObBoardingState();
// }

// class _ObBoardingState extends State<ObBoarding> {
//   String isSelected = "";

//   void selectBahasa(String? val) {
//     setState(() {
//       isSelected = val ?? "";
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: primaryColor,
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const SizedBox(height: 60),
//           Center(
//             child: Image.asset(
//               "images/logo_coolapp_new.png",
//               height: 60,
//               width: 194,
//             ),
//           ),
//           const SizedBox(height: 60),
//           Text(
//             S.of(context).choose_language,
//             style: TextStyle(
//               color: whiteColor,
//               fontSize: 20,
//               fontWeight: FontWeight.w500,
//             ),
//             textAlign: TextAlign.center,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: ListView.separated(
//               shrinkWrap: true,
//               itemCount: 3, // Ubah jumlah item menjadi 3
//               itemBuilder: (context, index) {
//                 String language;
//                 switch (index) {
//                   case 0:
//                     language = "Indonesia";
//                     break;
//                   case 1:
//                     language = "English";
//                     break;
//                   case 2:
//                     language = "Malaysia";
//                     break;
//                   default:
//                     language = "English";
//                 }
//                 return GestureDetector(
//                   onTap: () {
//                     debugPrint("cek bahasa $index");
//                     selectBahasa(language);
//                   },
//                   child: Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       border: Border.all(width: 2, color: Colors.white),
//                     ),
//                     padding: const EdgeInsets.symmetric(
//                         vertical: 16, horizontal: 20),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           index == 0
//                               ? "${"🇮🇩"} Indonesia"
//                               : index == 1
//                                   ? "${"🇺🇸"} English"
//                                   : "${"🇲🇾"} Malaysia", // Menambahkan Malaysia
//                           style: const TextStyle(color: Colors.white),
//                         ),
//                         SizedBox(
//                           height: 24,
//                           width: 24,
//                           child: Radio(
//                             fillColor: MaterialStateColor.resolveWith(
//                                 (states) => Colors.white),
//                             value: language,
//                             groupValue: isSelected,
//                             onChanged: (String? value) {
//                               debugPrint("cek bahasa $index");
//                               selectBahasa(value);
//                             },
//                             activeColor: Colors.white,
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 );
//               },
//               separatorBuilder: (BuildContext context, int index) {
//                 return const Padding(padding: EdgeInsets.only(bottom: 16));
//               },
//             ),
//           ),
//           const SizedBox(height: 25),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: MaterialButton(
//               minWidth: MediaQuery.of(context).size.width,
//               height: 55,
//               elevation: 0,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10)),
//               color: Colors.white,
//               textColor: primaryColor,
//               child: Text(
//                 S.of(context).next,
//                 style: const TextStyle(fontWeight: FontWeight.bold),
//               ),
//               onPressed: () async {
//                 SharedPreferences prefs = await SharedPreferences.getInstance();

//                 if (isSelected == "Indonesia") {
//                   await prefs.setString('lang_code', 'id_ID');
//                   S.load(const Locale('id_ID'));
//                 } else if (isSelected == "English") {
//                   await prefs.setString('lang_code', 'en_US');
//                   S.load(const Locale('en_US'));
//                 } else if (isSelected == "Malaysia") {
//                   await prefs.setString('lang_code',
//                       'ms_MY'); // Menambahkan pengaturan bahasa Malaysia
//                   S.load(const Locale('ms_MY'));
//                 }

//                 await prefs.setBool("lang_dialog_showed", true);

//                 context
//                     .read<ProviderBoarding>()
//                     .getSOnBoarding(context)
//                     .then((value) {
//                   Nav.replace(const ObBoarding2());
//                 });
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

