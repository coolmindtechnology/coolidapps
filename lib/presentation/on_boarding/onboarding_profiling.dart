import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/on_boarding/onboarding_birthday.dart';
import 'package:coolappflutter/presentation/pages/main/nav_home.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/widgets/GlobalButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/apps/app_sizes.dart';
import '../../data/provider/provider_user.dart';

class OnboardingProfiling extends StatefulWidget {
  const OnboardingProfiling({super.key});

  @override
  State<OnboardingProfiling> createState() => _OnboardingProfilingState();
}

class _OnboardingProfilingState extends State<OnboardingProfiling> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final providerUser = Provider.of<ProviderUser>(context, listen: false);
      providerUser.getUser(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryColor, Colors.white], // Gradasi biru ke putih
              begin: Alignment.topCenter,
              end: Alignment.center,
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 50,right: 20,left: 20,bottom: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40,left: 10,right: 10,top: 120),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'images/OnBoardingProfiling.png', // Ganti dengan path gambar kamu
                      ),
                    ),
                  ),
                  Text(
                    S.of(context).mulai,
                    style: TextStyle(
                      fontSize:  18,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ), textAlign: TextAlign.center,
                  ),
                  gapH20,
                   Text(
                     S.of(context).ajakan,
                    style: TextStyle(
                      fontSize: 15,
                    ),textAlign: TextAlign.center,
                  ),
                  Spacer(),
                  GlobalButton(
                    onPressed: () async {
                      await Nav.toAll(NavMenuScreen());
                    },
                    color: Colors.white,
                    text: S.of(context).nantiSaja,
                    textStyle: TextStyle(color: primaryColor),
                  ),
                  gapH10,
                  GlobalButton(
                    onPressed: () async {
                      await Nav.toAll(OnboardingBirthday());
                    },
                    color: primaryColor,
                    text: S.of(context).lakukanSekarang,
                  ),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
