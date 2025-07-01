import 'package:coolappflutter/data/apps/app_assets.dart';
import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/afiliate/bank_confirm.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/widgets/GlobalButton.dart';
import 'package:flutter/material.dart';

class NextPop extends StatefulWidget {
  const NextPop({super.key});

  @override
  State<NextPop> createState() => _NextPopState();
}

class _NextPopState extends State<NextPop> {
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
            Text(S.of(context).attention,style: TextStyle(fontSize: 18,color: Colors.red,fontWeight: FontWeight.w600),),
            gapH10,
            Text(S.of(context).affiliator_account_notice,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),textAlign: TextAlign.center,),
            gapH20,
            Text(S.of(context).view_old_profiling,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),textAlign: TextAlign.center,),
            gapH10,
            GlobalButton(onPressed: () {
              Nav.to(BankConfirm());
            }, color: primaryColor, text: S.of(context).I_Understand),
            GlobalButton(onPressed: () {
              Navigator.pop(context);
            }, color: Colors.white, text: S.of(context).use_another_account,textStyle: TextStyle(fontWeight: FontWeight.w500,color: primaryColor),)
          ],
        ),
      ),
    );
  }
}
