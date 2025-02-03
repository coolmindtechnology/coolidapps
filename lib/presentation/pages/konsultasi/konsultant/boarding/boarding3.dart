import 'package:coolappflutter/data/apps/app_assets.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/konsultant/boarding/Boarding1.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/konsultant/konsultant_dashboard.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/widgets/GlobalButton.dart';
import 'package:flutter/material.dart';

class BoardingKonsultan3 extends StatelessWidget {
  const BoardingKonsultan3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              primaryColor,
              Colors.white,
            ],
            stops: [0.1, 0.35],
            begin: Alignment.topCenter,
            end: Alignment.center,
          ),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(bottom: 30, top: 40, right: 20, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(AppAsset.icFrame3),
                  InkWell(
                      onTap: () {
                        Nav.to(KonsultantDashboard());
                      },
                      child: Text(
                        S.of(context).Skip +'>',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ))
                ],
              ),
              SizedBox(
                height: 40,
              ),
              SizedBox(
                  width: double.infinity,
                  child: Image.asset(
                    AppAsset.imgBoardingKonsul3,
                    fit: BoxFit.cover,
                  )),
              SizedBox(
                height: 40,
              ),
              Text(
                S.of(context).Consult_Themes,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 23),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                S.of(context).Accept_Themes,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 100,
                    child: GlobalButton(
                      onPressed: () {
                        Nav.to(BoardingKonsultan1());
                      },
                      color: Colors.white,
                      text: S.of(context).back,
                      textStyle: TextStyle(color: primaryColor),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 100,
                    child: GlobalButton(
                      onPressed: () {
                        Nav.replace(KonsultantDashboard());
                      },
                      color: primaryColor,
                      text: S.of(context).Next,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
