import 'package:coolappflutter/data/apps/app_assets.dart';
import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/afiliate/invoice.dart';
import 'package:coolappflutter/presentation/pages/afiliate/terma_kondisi.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/widgets/GlobalButton.dart';
import 'package:flutter/material.dart';

class BankConfirm extends StatefulWidget {
  const BankConfirm({super.key});

  @override
  State<BankConfirm> createState() => _BankConfirmState();
}

class _BankConfirmState extends State<BankConfirm> {
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
                Text(S.of(context).confirmBankAccount,style: TextStyle(fontSize: 23,fontWeight: FontWeight.w600),),
                gapH10,
                Text(S.of(context).doubleCheckBankNumber,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),),
                gapH20,
                Container(
                  width: double.infinity,
                  height: 110,
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15,left: 15,top: 8,bottom: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Fadlan Zholifunnas Soemarta',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),),
                        gapH10,
                        Container(
                          width: double.infinity,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('008318726622'),
                                Text('Dari Bank Central Asia')
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Spacer(),
                GlobalButton(onPressed: () {
                  Navigator.pop(context);
                }, color: Colors.white, text: S.of(context).back,textStyle: TextStyle(fontWeight: FontWeight.w500,color: primaryColor),),
                gapH10,
                GlobalButton(onPressed: () {
                  Nav.to(Invoice());
                }, color: primaryColor, text: S.of(context).yesIamSure),

              ],
            ),
          )
      ),
    );
  }
}
