import 'dart:async';

import 'package:android_intent_plus/android_intent.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:coolappflutter/data/provider/provider_boarding.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/auth/login_screen.dart';
import 'package:coolappflutter/presentation/pages/auth/register_screen.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ObBoarding2 extends StatefulWidget {
  final String? codeReferral;
  const ObBoarding2({super.key, this.codeReferral});

  @override
  State<ObBoarding2> createState() => _ObBoarding2State();
}

class _ObBoarding2State extends State<ObBoarding2> {
  bool isDeepLinkActivated = false;
  @override
  void initState() {
    context.read<ProviderBoarding>().getSOnBoarding(context);
    Timer(const Duration(seconds: 2), () {
      checkDeepLinkStatus();
    });
    // handleDeepLink();
    super.initState();
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
      body: Consumer<ProviderBoarding>(builder: (context, state, __) {
        return Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: CachedNetworkImageProvider(state.urlImageOnBoarding ?? ""),
              fit: BoxFit.fill,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: state.isLoading == true
                        ? Container()
                        : CachedNetworkImage(
                            imageUrl: state.urlLogoOnBoarding ?? "",
                            height: 60,
                            placeholder: (context, url) => Center(
                              child: CircularProgressIndicator(
                                color: whiteColor,
                              ),
                            ),
                            errorWidget: (context, url, error) => Image.asset(
                                "assets/icons/material-symbols-light_error-outline.png"),
                          ),
                  ),
                  const SizedBox(
                    height: 150,
                  ),
                  Column(
                    children: [
                      Center(
                        child: Text(
                          state.dataOnBoarding?.greeting?.onBoardingGreeting ??
                              "",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Center(
                        child: Text(
                          state.dataOnBoarding?.title?.onBoardingTitle ?? "",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: 36,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MaterialButton(
                              minWidth: MediaQuery.of(context).size.width,
                              height: 55,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              color: Colors.white,
                              textColor: primaryColor,
                              child: Text(
                                S.of(context).sign_in,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                Nav.to(const LoginScreen());
                              }),
                          const SizedBox(
                            height: 15,
                          ),
                          MaterialButton(
                              minWidth: MediaQuery.of(context).size.width,
                              height: 55,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: const BorderSide(
                                      width: 1, color: Colors.white)),
                              textColor: Colors.white,
                              child: Text(
                                S.of(context).register,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                Nav.to(const RegisterScreen());
                              })
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  // void openAppSettingss() async {
  //   debugPrint("open settt");
  //   const AndroidIntent intent = AndroidIntent(
  //     action: 'android.settings.APPLICATION_DETAILS_SETTINGS',
  //     data: 'package:coolappflutter', // Ganti dengan package name aplikasi kamu
  //     flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
  //   );
  //   await intent.launch();
  // }
}
