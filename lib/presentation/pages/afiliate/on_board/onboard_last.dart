import 'package:coolappflutter/data/apps/app_assets.dart';
import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/main/nav_home.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/widgets/GlobalButton.dart';
import 'package:flutter/material.dart';

class OnboardLast extends StatefulWidget {
  const OnboardLast({super.key});

  @override
  State<OnboardLast> createState() => _OnboardLastState();
}

class _OnboardLastState extends State<OnboardLast> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            gapH50,
            Image.asset(AppAsset.imgNewCoolLogo,fit: BoxFit.cover,width: 200,),
            gapH100,
            Image.asset(AppAsset.imgWelcomeAff,fit: BoxFit.cover,width: 270,),
            gapH50,
            Text(S.of(context).welcome_affiliator,style: TextStyle(fontSize: 27,color: Colors.white,fontWeight: FontWeight.w600),),
            gapH20,
            Text(S.of(context).congratulations_affiliator,style: TextStyle(fontSize: 19,color: Colors.white,fontWeight: FontWeight.w500),textAlign: TextAlign.center,),
            Spacer(),
            GlobalButton(onPressed: () {
              Nav.to(NavMenuScreen());
            }, color: Colors.white, text: S.of(context).next,textStyle: TextStyle(fontWeight: FontWeight.w500,color: primaryColor),),
          ]
        ),
      ),
    );
  }
}
