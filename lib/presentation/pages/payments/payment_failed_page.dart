import 'package:cool_app/generated/l10n.dart';
import 'package:cool_app/presentation/pages/main/nav_home.dart';
import 'package:cool_app/presentation/utils/nav_utils.dart';
import 'package:flutter/material.dart';

class PaymentFailedPage extends StatefulWidget {
  const PaymentFailedPage({super.key});

  @override
  State<PaymentFailedPage> createState() => _PaymentFailedPageState();
}

class _PaymentFailedPageState extends State<PaymentFailedPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      Nav.replace(const NavMenuScreen());
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
            const SizedBox(
              height: 100,
              child: Icon(
                Icons.cancel,
                color: Colors.red,
                size: 110,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              S.of(context).payment_failed,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.red,
              ),
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
