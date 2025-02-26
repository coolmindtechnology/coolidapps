import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/main/nav_home.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/widgets/GlobalButton.dart';
import 'package:flutter/material.dart';

class PopUpReport extends StatelessWidget {
  const PopUpReport({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 340,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10)
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 30,bottom: 20 ,right: 20,left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('images/Hand_icon.png'),
            SizedBox(height: 20,),
            Text(S.of(context).Thank_You_For_Your_Report,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 17),),
            SizedBox(height: 10,),
            Text(S.of(context).We_Appreciate_Your_Feedback,style: TextStyle(fontSize: 14),textAlign: TextAlign.center,),
            SizedBox(height: 20,),
            GlobalButton(onPressed: () {
             Nav.toAll(NavMenuScreen());
            }, color: primaryColor, text: S.of(context).I_Understand)

          ],
        ),
      ),
    );
  }
}
