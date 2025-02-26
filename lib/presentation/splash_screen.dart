// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:coolappflutter/data/apps/app_assets.dart';
import 'package:coolappflutter/data/data_global.dart';
import 'package:coolappflutter/data/locals/preference_handler.dart';
import 'package:coolappflutter/data/locals/shared_pref.dart';
import 'package:coolappflutter/data/provider/provider_boarding.dart';
import 'package:coolappflutter/data/provider/provider_book.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/on_boarding2.dart';
import 'package:coolappflutter/presentation/pages/auth/register_screen.dart';
import 'package:coolappflutter/presentation/pages/main/pre_home_screen.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';

import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'on_boarding.dart';
import 'onboarding_new1.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, this.codeReferral});

  final String? codeReferral;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AudioPlayer _audioPlayer;
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  bool logicAnimation = false;
  bool logic1 = false;
  bool logic2 = false;
  bool logic3 = false;
  bool logic4 = false;
  bool logic5 = false;
  bool fullColor = false;
  bool startColor = false;
  bool bottomColor1 = false;
  bool bottomColor2 = false;
  bool bottomColor3 = false;
  bool logoStart = false;
  bool logo1 = false;
  bool logo2 = false;
  bool logo3 = false;
  bool logo4 = false;
  bool logo5 = false;
  bool logo6 = false;
  bool logo7 = false;
  bool logo8 = false;
  bool logoEnd = false;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    scaleAnimation = Tween<double>(begin: 1, end: 3).animate(controller);

    log("codeReferral: ${widget.codeReferral}");

    _audioPlayer = AudioPlayer();

    _playSegmentFromAsset(
        "audio/1717485918_Cool Compas - Master_2.wav", 10, 14);
    // trigerAnimation();
    trigerLogo();
  }

  trigerLogo() {
    logoStart = true;
    if (logoStart == true) {
      setState(() {});
      Timer(const Duration(microseconds: 10000), () {
        logo1 = true;
        logoStart = false;
        if (logo1 == true) {
          setState(() {});
          Timer(const Duration(microseconds: 10000), () {
            logo2 = true;
            logo1 = false;
            logoStart = false;
            if (logo2 == true) {
              setState(() {});
              Timer(const Duration(microseconds: 100000), () {
                logo3 = true;
                logo2 = false;
                logo1 = false;
                logoStart = false;
                if (logo3 = true) {
                  setState(() {});
                  Timer(const Duration(microseconds: 100000), () {
                    logo4 = true;
                    logo3 = false;
                    logo2 = false;
                    logo1 = false;
                    logoStart = false;
                    if (logo4 = true) {
                      setState(() {});
                      Timer(const Duration(microseconds: 100000), () {
                        logo5 = true;
                        logo4 = false;
                        logo3 = false;
                        logo2 = false;
                        logo1 = false;
                        logoStart = false;
                        if (logo5 = true) {
                          setState(() {});
                          Timer(const Duration(microseconds: 100000), () {
                            logo6 = true;
                            logo5 = false;
                            logo4 = false;
                            logo3 = false;
                            logo2 = false;
                            logo1 = false;
                            logoStart = false;
                            if (logo6 = true) {
                              setState(() {});
                              Timer(const Duration(microseconds: 100000), () {
                                setState(() {});
                                logoEnd = true;
                                logo6 = false;
                                logo5 = false;
                                logo4 = false;
                                logo3 = false;
                                logo2 = false;
                                logo1 = false;
                                logoStart = false;
                                Timer(const Duration(microseconds: 100000), () {
                                  trigerAnimation();
                                });
                              });
                            }
                          });
                        }
                      });
                    }
                  });
                }
              });
            }
          });
        }
      });
    }
  }

  trigerAnimation() {
    startColor = true;
    Timer(const Duration(seconds: 1), () {
      logicAnimation = true;
      if (logicAnimation = true) {
        Timer(const Duration(milliseconds: 100), () {
          logic1 = true;
          if (logic1 = true) {
            Timer(const Duration(microseconds: 100), () {
              logic2 = true;
              if (logic2 = true) {
                Timer(const Duration(milliseconds: 100), () {
                  logic3 = true;
                  if (logic3 = true) {
                    Timer(const Duration(milliseconds: 100), () {
                      logic4 = true;
                      if (logic4 == true) {
                        Timer(const Duration(milliseconds: 100), () {
                          logic5 = true;
                          fullColor = true;
                          controller.forward();

                          setState(() {});
                        });
                      }
                      setState(() {});
                    });
                  }
                  setState(() {});
                });
              }

              setState(() {});
            });
          }
          setState(() {});
        });
      }

      // controller.forward();
      setState(() {});
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  /// Checks if the app is valid and performs certain actions after a delay.
  ///
  /// This function first checks if the app is valid by calling the `checkingVersion` method
  /// of the `providerBoarding` object. If the app is valid, it waits for 10 seconds using
  /// `Future.delayed` and then calls the `initLanguageOption` and `cekSession` methods.
  ///
  /// Parameters:
  ///   None
  ///
  /// Return type:
  ///   None
  cekApp() async {
    // bool isValid = true;
    bool isValid =
        await context.read<ProviderBoarding>().checkingVersion(context);
    if (isValid) {
      await Future.delayed(const Duration(milliseconds: 1000), () async {
        await initLanguageOption();
        cekSession();
      });
    }
  }

  void openAppSettings() async {
    debugPrint("open settt");
    const AndroidIntent intent = AndroidIntent(
      action: 'android.settings.APPLICATION_DETAILS_SETTINGS',
      data: 'package:coolappflutter', // Ganti dengan package name aplikasi kamu
    );
    await intent.launch();
  }

  // Initializes the language options by getting the SharedPreferences instance and checking if the "lang_dialog_showed" flag is not true. If the flag is false, it replaces the current screen with the ObBoarding screen.
  Future<void> initLanguageOption() async {
    final prefs = await SharedPreferences.getInstance();
    final isShowed = prefs.getBool("lang_dialog_showed") ?? false;

    if (!isShowed) {
      if (widget.codeReferral != '/') {
        await prefs.setBool("lang_dialog_showed", true);
      }
      // else {
      // await Nav.replace(ObBoarding(codeReferral: widget.codeReferral));
      // }
    }
  }

  Future<void> _playSegmentFromAsset(
      String assetPath, int start, int end) async {
    await _audioPlayer.setSource(AssetSource(assetPath));
    await _audioPlayer.seek(Duration(seconds: start));
    _audioPlayer.resume();

    // Schedule a stop at the end of the segment
    Future.delayed(Duration(seconds: end - start), () async {
      await _audioPlayer.stop();
      cekApp();
    });
  }

  Future<void> cekSession() async {
    final locale = await Prefs().getLocale();
    await S.load(Locale(locale));
    dynamic cekOboarding = await PreferenceHandler.retrieveCekOnboarding();
    final userToken = await Prefs().getToken();
    debugPrint("cek sessions $userToken");
    if (userToken == null && cekOboarding.toString() != "1") {
      Nav.toAll(const Onboardingnew1(
        changeLanguage: '',
      ));
    } else {
      final userToken = await Prefs().getToken();
      debugPrint("cek session $userToken");
      if (widget.codeReferral != '/') {
        // await Prefs().clearSession();
        Nav.toAll(RegisterScreen(codeReferral: widget.codeReferral));
      } else if (userToken != null) {
        debugPrint("cek session $userToken");
        dataGlobal.setToken(userToken);

        await context.read<ProviderBook>().getPreHome(context);
        Nav.toAll(const PreHomeScreen());
        // Nav.toAll(const Onboardingnew1());
      } else {
        debugPrint("cek sessions $userToken");
        Nav.toAll(const Onboardingnew1(
          changeLanguage: '',
        ));
        // Nav.toAll(const ObBoarding2());
      }
    }
  }

//new
  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderBoarding>(
      builder: (context, value, child) {
        return Scaffold(
            backgroundColor: primaryColor,
            body: yellowScreenAnimation(
                controller,
                scaleAnimation,
                startColor,
                logic1,
                logic2,
                logic3,
                logic4,
                logic5,
                fullColor,
                logoStart,
                logo1,
                logo2,
                logo3,
                logo4,
                logo5,
                logo6,
                logo7,
                logo8,
                logoEnd)
            // bottomNavigationBar: SizedBox(
            //   height: 54,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Text(
            //         value.version,
            //         style: TextStyle(color: whiteColor, fontSize: 16),
            //       ),
            //     ],
            //   ),
            // ),
            );
      },
    );
  }
}

Widget logoAnimation(start, l1, l2, l3, l4, l5, l6, l7, l8, end) {
  return Stack(
    children: [
      if (start == true)
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Center(
                child: SizedBox(
                    height: 150,
                    width: 150,
                    child: Image.asset(
                      AppAsset.imgNewLogo,
                    )))),
      if (l1 == true)
        Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Center(
                child: SizedBox(
                    height: 150,
                    width: 150,
                    child: Image.asset(
                      AppAsset.imgNewLogo,
                    )))),
      if (l2 == true)
        Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Center(
                child: SizedBox(
                    height: 150,
                    width: 150,
                    child: Image.asset(
                      AppAsset.imgNewLogo,
                    )))),
      if (l3 == true)
        Positioned(
            bottom: 150,
            left: 0,
            right: 0,
            child: Center(
                child: SizedBox(
                    height: 150,
                    width: 150,
                    child: Image.asset(
                      AppAsset.imgNewLogo,
                    )))),
      if (l4 == true)
        Positioned(
            bottom: 200,
            left: 0,
            right: 0,
            child: Center(
                child: SizedBox(
                    height: 150,
                    width: 150,
                    child: Image.asset(
                      AppAsset.imgNewLogo,
                    )))),
      if (l5 == true)
        Positioned(
            bottom: 250,
            left: 0,
            right: 0,
            child: Center(
                child: SizedBox(
                    height: 150,
                    width: 150,
                    child: Image.asset(
                      AppAsset.imgNewLogo,
                    )))),
      if (l6 == true)
        Positioned(
            bottom: 250,
            left: 0,
            right: 0,
            child: Center(
                child: SizedBox(
                    height: 150,
                    width: 150,
                    child: Image.asset(
                      AppAsset.imgNewLogo,
                    )))),
      if (end == true)
        Positioned(
            child: Center(
                child: SizedBox(
                    height: 150,
                    width: 150,
                    child: Image.asset(
                      AppAsset.imgNewLogo,
                    )))),
    ],
  );
}

Widget yellowScreenAnimation(
    controller,
    scaleAnimation,
    startColor,
    logic1,
    logic2,
    logic3,
    logic4,
    logic5,
    fullColor,
    start,
    l1,
    l2,
    l3,
    l4,
    l5,
    l6,
    l7,
    l8,
    end) {
  return Center(
    child: GestureDetector(
      onTap: () {
        controller.forward();
      },
      child: ScaleTransition(
        scale: scaleAnimation,
        child: Stack(
          children: [
            logoAnimation(start, l1, l2, l3, l4, l5, l6, l7, l8, end),

            if (startColor = true)
              Positioned(
                top: 0,
                bottom: -980,
                right: -180,
                child: Container(
                  height: 300,
                  width: 400,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.yellow),
                ),
              ),
            //1
            if (logic1 == true)
              Positioned(
                top: 0,
                bottom: -980,
                right: -180,
                child: Container(
                  height: 300,
                  width: 400,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.yellow),
                ),
              ),
//2
            if (logic2 == true)
              Positioned(
                top: 0,
                bottom: -880,
                right: -180,
                child: Container(
                  height: 300,
                  width: 400,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.yellow),
                ),
              ),
            //3
            if (logic3 == true)
              Positioned(
                top: 0,
                bottom: -800,
                right: -150,
                child: Container(
                  height: 300,
                  width: 400,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.yellow),
                ),
              ),
            //4
            if (logic4 == true)
              Positioned(
                top: 0,
                bottom: -700,
                right: -100,
                child: Container(
                  height: 300,
                  width: 400,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.yellow),
                ),
              ),
            //5
            if (logic5 == true)
              Positioned(
                top: 0,
                bottom: -400,
                right: -100,
                child: Container(
                  height: 300,
                  width: 600,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.yellow),
                ),
              ),
            if (fullColor == true)
              Positioned(
                top: 0,
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  height: 900,
                  width: 900,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.yellow),
                ),
              ),

            //bottom1
            // if (bottomColor1 == true)
            //   Positioned(
            //     top: -280,
            //     bottom: 0,
            //     right: -120,
            //     left: -180,
            //     child: Container(
            //       height: 300,
            //       width: 400,
            //       decoration: const BoxDecoration(
            //           shape: BoxShape.circle, color: Colors.yellow),
            //     ),
            //   ),
            // if (bottomColor2 == true)
            //   Positioned(
            //     top: -580,
            //     bottom: 0,
            //     right: -10,
            //     left: -130,
            //     child: Container(
            //       height: 300,
            //       width: 400,
            //       decoration: const BoxDecoration(
            //           shape: BoxShape.circle, color: Colors.yellow),
            //     ),
            //   ),
            // if (bottomColor3 == true)
            //   Positioned(
            //     top: -980,
            //     bottom: 0,
            //     left: -180,
            //     child: Container(
            //       height: 300,
            //       width: 400,
            //       decoration: const BoxDecoration(
            //           shape: BoxShape.circle, color: Colors.yellow),
            //     ),
            //   ),
          ],
        ),
      ),
    ),
  );
}

/////old

  // @override
  // Widget build(BuildContext context) {
  //   return Consumer<ProviderBoarding>(
  //     builder: (context, value, child) {
  //       return Scaffold(
  //         backgroundColor: primaryColor,
  //         body: Center(
  //           child: Image.asset(
  //             "images/logo_coolapp_new.png",
  //             height: 60,
  //           ),
  //         ),
  //         bottomNavigationBar: SizedBox(
  //           height: 54,
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Text(
  //                 value.version,
  //                 style: TextStyle(color: whiteColor, fontSize: 16),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
// }
