import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:coolappflutter/data/apps/app_strings.dart';
import 'package:coolappflutter/data/locals/preference_handler.dart';
import 'package:coolappflutter/presentation/onboarding_new3.dart';
import 'package:coolappflutter/presentation/pages/auth/login_screen.dart';
import 'package:coolappflutter/presentation/pages/auth/register_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../data/apps/app_assets.dart';
import '../generated/l10n.dart';
import 'pages/main/pre_home_screen.dart';
import 'theme/color_utils.dart';
import 'utils/nav_utils.dart';

class OnboardingNew2 extends StatefulWidget {
  const OnboardingNew2({super.key});

  @override
  State<OnboardingNew2> createState() => _OnboardingNew2State();
}

class _OnboardingNew2State extends State<OnboardingNew2> {
  int countPage = 1;

  @override
  void initState() {
    super.initState();
  }

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
            controller: ScrollController(),
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
                      Stack(
                        children: [
                          Row(
                            children: List.generate(
                              4,
                              (index) => Container(
                                margin: const EdgeInsets.only(right: 8),
                                width: 52,
                                height: 6,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: List.generate(
                              countPage,
                              (index) => Container(
                                margin: const EdgeInsets.only(right: 8),
                                width: 52,
                                height: 6,
                                decoration: BoxDecoration(
                                  color: const Color(0XFFFBF008),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // "Lewati" text with arrow
                      GestureDetector(
                        onTap: () async {
                          // Nav.toAll(const PreHomeScreen());
                          await PreferenceHandler.storingCekOnboarding("1");
                          Nav.toAll(const RegisterScreen());
                        },
                        child: Row(
                          children: [
                            Text(
                              S.of(context).skip,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 5),
                            const Icon(
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
                if (countPage == 1)
                  viewOnboarding(
                      AppAsset.imgGirlBrain,
                      S.of(context).come_get_to_know_yourself,
                      S.of(context).every_human_being_is_unique),
                if (countPage == 2)
                  viewOnboarding(
                      AppAsset.imgBoyBrain,
                      S.of(context).lets_develop_ourselves,
                      S.of(context).develop_yourself_by_exploring),
                if (countPage == 3)
                  viewOnboarding(
                      AppAsset.imgBlueBrain,
                      S.of(context).start_activating_brain_potential,
                      S.of(context).reach_your_brains_maximum_potential),
                if (countPage == 4)
                  viewOnboarding(
                      AppAsset.imgPhoneBrain,
                      S.of(context).share_stories_together,
                      S
                          .of(context)
                          .share_your_stories_and_your_heart_with_CoolApp_users),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height / 10.sp,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    countPage != 1
                        ? Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: GestureDetector(
                              onTap: () {
                                // await Nav.to(const OnboardingNew3());
                                countPage--;
                                if (countPage == 0) {
                                  countPage = 0;
                                }
                                setState(() {});
                              },
                              child: Text(
                                S.of(context).back,
                                style: TextStyle(
                                    fontSize: 15.sp, color: primaryColor),
                              ),
                            ))
                        : Container(),
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
                            child: Text(
                              S.of(context).lanjut,
                              style: TextStyle(fontSize: 15.sp),
                            ),
                            onPressed: () async {
                              // await Nav.to(const OnboardingNew3());
                              countPage++;
                              if (countPage > 4) {
                                await PreferenceHandler.storingCekOnboarding(
                                    "1");
                                countPage = 0;
                                Nav.toAll(const RegisterScreen());
                              }
                              setState(() {});
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

  Widget viewOnboarding(
      String image, String description1, String description2) {
    return Column(
      children: [
        Image.asset(
          image,
          fit: BoxFit.contain,
          scale: 0.92.sp,
        ),
        gapH32,
        Padding(
          padding: const EdgeInsets.only(left: 25, right: 25),
          child: Row(
            children: [
              Text(
                description1,
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        gapH20,
        Padding(
          padding: const EdgeInsets.only(left: 25, right: 25),
          child: Row(
            children: [
              Expanded(
                  child: Text(
                textAlign: TextAlign.left,
                description2,
                style: TextStyle(fontSize: 14.sp),
              )),
            ],
          ),
        ),
      ],
    );
  }
}
