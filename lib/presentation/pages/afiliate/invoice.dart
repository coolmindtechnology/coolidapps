import 'package:coolappflutter/data/apps/app_assets.dart';
import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/afiliate/on_board/onboard_last.dart';
import 'package:coolappflutter/presentation/pages/afiliate/terma_kondisi.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/widgets/GlobalButton.dart';
import 'package:flutter/material.dart';

class Invoice extends StatefulWidget {
  const Invoice({super.key});

  @override
  State<Invoice> createState() => _InvoiceState();
}

class _InvoiceState extends State<Invoice> {
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
              stops: [0.3, 0.6],
              begin: Alignment.topCenter,
              end: Alignment.center,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 30,top: 50,left: 20,right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(S.of(context).invoice,style: TextStyle(fontSize: 23,fontWeight: FontWeight.w600),),
                gapH10,
                Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15,left: 15,top: 8,bottom: 8),
                    child: Center(
                      child:  Text('Rp.2.000.000',style: TextStyle(fontSize: 23,fontWeight: FontWeight.w600,color: primaryColor),),
                    )
                  ),
                ),
                gapH20,
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15,left: 15,top: 15,bottom: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(S.of(context).id,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),),
                            gapW10,
                            Text('#ORD00001',style: TextStyle(color: Colors.grey,fontSize: 16),)
                          ],
                        ),
                        gapH10,
                        Row(
                          children: [
                            Text(S.of(context).customer,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),),
                            gapW10,
                            Text('Thomas Friend',style: TextStyle(color: Colors.grey,fontSize: 16),)
                          ],
                        ),
                        gapH10,
                        Row(
                          children: [
                            Text(S.of(context).date,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),),
                            gapW10,
                            Text('12 Des 2025',style: TextStyle(color: Colors.grey,fontSize: 16),)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                gapH32,
                Text(S.of(context).attention,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                gapH20,
                Text(S.of(context).affiliateProgram,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),),
                Text(S.of(context).welcomeAffiliateProgram,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),),
                gapH20,
                Text(S.of(context).affiliateAgreement,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),),
                Text('1. ' + S.of(context).depositInfo,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),),
                Text('2. ' + S.of(context).commissionInfo,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),),
                Text('3. ' + S.of(context).rightsResponsibilities,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),),
                Text('4. ' + S.of(context).cancellationChanges,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),),

                Spacer(),
                GlobalButton(onPressed: () {
                  Nav.to(OnboardLast());
                }, color: primaryColor, text: S.of(context).next),

              ],
            ),
          )
      ),
    );
  }
}
