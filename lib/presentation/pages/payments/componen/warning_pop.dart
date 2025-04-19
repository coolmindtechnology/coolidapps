import 'package:coolappflutter/data/apps/app_assets.dart';
import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/afiliate/bank_confirm.dart';
import 'package:coolappflutter/presentation/pages/transakction/withdraw.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/widgets/GlobalButton.dart';
import 'package:flutter/material.dart';

class WarningAffPop extends StatefulWidget {
  const WarningAffPop({super.key});

  @override
  State<WarningAffPop> createState() => _WarningAffPopState();
}

class _WarningAffPopState extends State<WarningAffPop> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Lakukan Penarikan?',style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.w600),),
            gapH10,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('jumblah tarikan :',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),textAlign: TextAlign.center,),
                Text('2.500 Point',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),textAlign: TextAlign.center,),
              ],
            ),
            gapH20,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Saldo dibutuhkan :',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.red),textAlign: TextAlign.center,),
                Text('Rp125.000',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.red),textAlign: TextAlign.center,),
              ],
            ),
            gapH20,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Saldo didapatkan :',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.green),textAlign: TextAlign.center,),
                Text('Rp250.000',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.green),textAlign: TextAlign.center,),
              ],
            ),
            gapH20,

            GlobalButton(onPressed: () {
              Nav.to(const Withdraw());
            }, color: primaryColor, text: S.of(context).yes_continue),
            GlobalButton(onPressed: () {
              Navigator.pop(context);
            }, color: Colors.white, text: S.of(context).no,textStyle: TextStyle(fontWeight: FontWeight.w500,color: primaryColor),)
          ],
        ),
      ),
    );
  }
}
