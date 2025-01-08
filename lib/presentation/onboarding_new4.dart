import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:coolappflutter/data/apps/app_strings.dart';
import 'package:coolappflutter/presentation/pages/main/pre_home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../data/apps/app_assets.dart';
import 'onboarding_change_language.dart';
import 'theme/color_utils.dart';
import 'utils/nav_utils.dart';

class OnboardingNew4 extends StatefulWidget {
  const OnboardingNew4({super.key});

  @override
  State<OnboardingNew4> createState() => _OnboardingNew4State();
}

class _OnboardingNew4State extends State<OnboardingNew4> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient Background
          Container(
            width: double.infinity,
            height: 236,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF66CDF2), // Warna gradient atas
                  Color(0xFFFFFFFF), // Warna gradient bawah
                ],
              ),
            ),
          ),
          // Content
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 50),
                // Row with 4 Containers and "Lewati" text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // List of small Containers
                      Row(
                        children: List.generate(
                          4,
                          (index) => Container(
                            margin: const EdgeInsets.only(right: 8),
                            width: 52,
                            height: 6,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                      ),
                      // "Lewati" text with arrow
                      GestureDetector(
                        onTap: () {
                          Nav.toAll(const PreHomeScreen());
                        },
                        child: const Row(
                          children: [
                            Text(
                              "Lewati",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 5),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                // Image in Center
                Image.asset(
                  AppAsset.imgBlueBrain,
                  fit: BoxFit.contain,
                  scale: 0.92,
                ),
                gapH32,
                const Padding(
                  padding: EdgeInsets.only(left: 25, right: 25),
                  child: Row(
                    children: [
                      Text(
                        Labels.mulaiAktivasi,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                gapH20,
                const Padding(
                  padding: EdgeInsets.only(left: 25, right: 25),
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(
                        textAlign: TextAlign.left,
                        Labels.raihPotensiMaksimal,
                        style: TextStyle(fontSize: 16),
                      )),
                    ],
                  ),
                ),
                gapH70,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: SizedBox(
                        width: 100,
                        child: MaterialButton(
                            minWidth: MediaQuery.of(context).size.width,
                            height: 50,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            color: primaryColor,
                            textColor: Colors.white,
                            child: const Text(
                              Labels.lanjut,
                              style: TextStyle(fontSize: 17),
                            ),
                            onPressed: () async {
                              // await Nav.to(const OnboardingNew5());
                            }),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
