import 'package:cool_app/generated/l10n.dart';
import 'package:cool_app/presentation/theme/color_utils.dart';
import 'package:cool_app/presentation/utils/nav_utils.dart';
import 'package:cool_app/presentation/widgets/button_primary.dart';
import 'package:flutter/material.dart';

class PaymentSuccess extends StatefulWidget {
  const PaymentSuccess({super.key});

  @override
  State<PaymentSuccess> createState() => _PaymentSuccessState();
}

class _PaymentSuccessState extends State<PaymentSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).payment_status,
          style: TextStyle(color: whiteColor),
        ),
        surfaceTintColor: Colors.transparent,
        iconTheme: IconThemeData(color: whiteColor),
        actionsIconTheme: IconThemeData(color: whiteColor),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 32,
            ),
            Image.asset(
              "assets/icons/success.png",
              height: 50,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              S.of(context).payment_successfull,
              style: const TextStyle(fontSize: 16, color: Color(0xFF27AE60)),
            ),
            const SizedBox(
              height: 32,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300)),
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  itemSuccess(
                      title: S.of(context).date,
                      subtitle: "Senin, 12 Des 2024"),
                  const SizedBox(
                    height: 8,
                  ),
                  itemSuccess(
                      title: S.of(context).order_id, subtitle: "101234567"),
                  const SizedBox(
                    height: 8,
                  ),
                  itemSuccess(
                      title: S.of(context).items, subtitle: "Paket Premium"),
                  const SizedBox(
                    height: 8,
                  ),
                  itemSuccess(
                      title: S.of(context).payment, subtitle: "Virtual Akun"),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.of(context).total,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const Text(
                        "Rp120,000",
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            SizedBox(
              height: 56,
              child: ButtonPrimary(
                S.of(context).close,
                onPress: () {
                  Nav.back();
                },
                expand: true,
                radius: 10,
              ),
            )
          ],
        ),
      ),
    );
  }

  Row itemSuccess({String? title, String? subtitle}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "$title",
          style: TextStyle(color: greyColor),
        ),
        Text(
          "$subtitle",
          style: TextStyle(color: greyColor),
        )
      ],
    );
  }
}
