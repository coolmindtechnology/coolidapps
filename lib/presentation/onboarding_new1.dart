// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'dart:async';

import 'package:coolappflutter/data/apps/app_assets.dart';
import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:coolappflutter/data/apps/app_strings.dart';
import 'package:coolappflutter/data/locals/preference_handler.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/onboarding_change_language.dart';
import 'package:coolappflutter/presentation/pages/auth/login_screen.dart';
import 'package:coolappflutter/presentation/pages/auth/register_screen.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'onboarding_new2.dart';
import 'pages/user/change_language.dart';
import 'utils/nav_utils.dart';

class Onboardingnew1 extends StatefulWidget {
  const Onboardingnew1({super.key, required this.changeLanguage});
  final String changeLanguage;

  @override
  State<Onboardingnew1> createState() => _Onboardingnew1State();
}

class _Onboardingnew1State extends State<Onboardingnew1> {
  @override
  void initState() {
    if (widget.changeLanguage == "1") {
      setState(() {});

      Timer(const Duration(microseconds: 10), () {
        setState(() {});
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4CCBF4),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              children: [
                gapH32,
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OnboardingChangeLanguage(
                                  onChanged: () {},
                                )));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(AppAsset.icGlobe),
                      ),
                    ],
                  ),
                ),
                gapH80,
                Image.asset(
                  AppAsset.imgNewLogo,
                  scale: 1.1,
                ),
                gapH32,
                Text(
                  S.of(context).have_you_ever_used_coolApps,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.bold),
                ),
                gapH70,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      height: 55,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Colors.white,
                      textColor: primaryColor,
                      child: Text(
                        S.of(context).yes_i_have,
                        style: const TextStyle(fontSize: 17),
                      ),
                      onPressed: () {
                        Nav.to(const LoginScreen());
                      }),
                ),
                gapH10,
                TextButton(
                    onPressed: () async {
                      dynamic cekOboarding =
                          await PreferenceHandler.retrieveCekOnboarding();
                      if (cekOboarding.toString() != "1") {
                        await Nav.to(const OnboardingNew2());
                      } else {
                        // Nav.to(const RegisterScreen());
                        Nav.to(const OnboardingNew2());
                      }
                    },
                    child: Text(
                      S.of(context).no_this_is_the_first_time,
                      style: const TextStyle(color: Colors.white, fontSize: 17),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
