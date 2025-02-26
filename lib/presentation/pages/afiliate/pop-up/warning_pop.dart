import 'package:coolappflutter/data/apps/app_assets.dart';
import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/widgets/GlobalButton.dart';
import 'package:flutter/material.dart';

class WarningPop extends StatefulWidget {
  const WarningPop({super.key});

  @override
  State<WarningPop> createState() => _WarningPopState();
}

class _WarningPopState extends State<WarningPop> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 270,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(AppAsset.imgTerm,fit: BoxFit.cover,),
            gapH20,
            Text(S.of(context).readTermsConditions,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),textAlign: TextAlign.center,),
            gapH20,
            GlobalButton(onPressed: () {
              Navigator.pop(context);
            }, color: primaryColor, text: S.of(context).I_Understand)
          ],
        ),
      ),
    );
  }
}
