import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/widgets/GlobalButton.dart';
import 'package:flutter/material.dart';

class AfterDeletePage extends StatelessWidget {
  const AfterDeletePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: primaryColor,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, bottom: 30, top: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'images/logo_coolapp_new.png',
                height: 60,
              ),
              const SizedBox(
                height: 30,
              ),
              Image.asset('images/ThankYou.png'),
              const SizedBox(
                height: 20,
              ),
              Text(
                S.of(context).Goodbye,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                S.of(context).Short_Time,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              Spacer(),
              GlobalButton(
                  onPressed: () {},
                  color: Colors.white,
                  text: S.of(context).register,
                  textStyle: TextStyle(color: primaryColor),),
              const SizedBox(height: 15,),
              GlobalButton(
                onPressed: () {},
                color: primaryColor,
                text: "Login",
                textStyle: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
