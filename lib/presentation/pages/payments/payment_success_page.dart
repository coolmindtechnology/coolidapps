import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/main/nav_home.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:flutter/material.dart';

class PaymentSuccessPage extends StatefulWidget {
  const PaymentSuccessPage({super.key});

  @override
  State<PaymentSuccessPage> createState() => _PaymentSuccessPageState();
}

class _PaymentSuccessPageState extends State<PaymentSuccessPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      Nav.toAll(const NavMenuScreen());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
              child: Image.asset(
                "assets/icons/success.png",
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              S.of(context).payment_success,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: greenColor),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(S.of(context).close_page_auto)
          ],
        ),
      ),
    );
  }
}
