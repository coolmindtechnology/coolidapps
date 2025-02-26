import 'package:coolappflutter/data/apps/app_assets.dart';
import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/afiliate/terma_kondisi.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/widgets/GlobalButton.dart';
import 'package:flutter/material.dart';

class OnboardAff1 extends StatefulWidget {
  const OnboardAff1({super.key});

  @override
  State<OnboardAff1> createState() => _OnboardAff1State();
}

class _OnboardAff1State extends State<OnboardAff1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                primaryColor.withOpacity(0.6),
                Colors.white,
              ],
              stops: [0.1, 0.5],
              begin: Alignment.topCenter,
              end: Alignment.center,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 30,top: 50,left: 20,right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: 110,
                  decoration: BoxDecoration(
                    color: primaryColor,
                  borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(S.of(context).affiliatorCode,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),),
                        gapH10,
                        TextField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                gapH40,
                Image.asset(AppAsset.imgLogoCoolMind,fit: BoxFit.cover,),
                gapH40,
                Text(S.of(context).welcomeAffiliatorProgram,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 22),textAlign: TextAlign.center,),
                gapH20,
                Text('Ayo dapatkan penghasilan melalui CoolApps',style: TextStyle(fontSize: 18,color: Colors.grey),textAlign: TextAlign.center,),
                Spacer(),
                GlobalButton(onPressed: () {
                Nav.to(const TermaAff());
                }, color: primaryColor, text: S.of(context).Next)
              ],
            ),
          )
      ),
    );
  }
}
