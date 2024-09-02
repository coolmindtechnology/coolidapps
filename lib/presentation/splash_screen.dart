// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:cool_app/data/data_global.dart';
import 'package:cool_app/data/locals/shared_pref.dart';
import 'package:cool_app/data/provider/provider_boarding.dart';
import 'package:cool_app/data/provider/provider_book.dart';
import 'package:cool_app/generated/l10n.dart';
import 'package:cool_app/presentation/on_boarding2.dart';
import 'package:cool_app/presentation/pages/auth/register_screen.dart';
import 'package:cool_app/presentation/pages/main/pre_home_screen.dart';
import 'package:cool_app/presentation/theme/color_utils.dart';
import 'package:cool_app/presentation/utils/get_country.dart';
import 'package:cool_app/presentation/utils/nav_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'on_boarding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key, this.codeReferral}) : super(key: key);

  final String? codeReferral;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    log("codeReferral: ${widget.codeReferral}");

    _audioPlayer = AudioPlayer();

    _playSegmentFromAsset(
        "audio/1717485918_Cool Compas - Master_2.wav", 10, 14);
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

  // Initializes the language options by getting the SharedPreferences instance and checking if the "lang_dialog_showed" flag is not true. If the flag is false, it replaces the current screen with the ObBoarding screen.
  Future<void> initLanguageOption() async {
    final prefs = await SharedPreferences.getInstance();
    final isShowed = prefs.getBool("lang_dialog_showed") ?? false;

    if (!isShowed) {
      if (widget.codeReferral != '/') {
        await prefs.setBool("lang_dialog_showed", true);
      } else {
        await Nav.replace(ObBoarding(codeReferral: widget.codeReferral));
      }
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

    final userToken = await Prefs().getToken();
    if (widget.codeReferral != '/') {
      await Prefs().clearSession();
      Nav.toAll(RegisterScreen(codeReferral: widget.codeReferral));
    } else if (userToken != null) {
      dataGlobal.setToken(userToken);

      await context.read<ProviderBook>().getPreHome(context);
      Nav.toAll(const PreHomeScreen());
    } else {
      Nav.toAll(const ObBoarding2());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderBoarding>(
      builder: (context, value, child) {
        return Scaffold(
          backgroundColor: primaryColor,
          body: Center(
            child: Image.asset(
              "images/logo_coolapp_new.png",
              height: 60,
            ),
          ),
          bottomNavigationBar: SizedBox(
            height: 54,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  value.version,
                  style: TextStyle(color: whiteColor, fontSize: 16),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
