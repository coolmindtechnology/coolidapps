import 'package:cool_app/generated/l10n.dart';
import 'package:cool_app/presentation/pages/payments/payment_page.dart';
import 'package:cool_app/presentation/theme/color_utils.dart';
import 'package:cool_app/presentation/utils/nav_utils.dart';
import 'package:cool_app/presentation/widgets/button_primary.dart';
import 'package:flutter/material.dart';

class DialogConfirmPage extends StatefulWidget {
  const DialogConfirmPage({super.key});

  @override
  State<DialogConfirmPage> createState() => _DialogConfirmPageState();
}

class _DialogConfirmPageState extends State<DialogConfirmPage> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: whiteColor,
      surfaceTintColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16))),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            S.of(context).pay_to_see_more,
            style: const TextStyle(color: Color(0xFF4F4F4F), fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 24,
          ),
          SizedBox(
            height: 48,
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: ButtonPrimary(
                      S.of(context).no,
                      textSize: 16,
                      onPress: () {
                        Nav.back();
                      },
                      negativeColor: true,
                      border: 1,
                      radius: 8,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: ButtonPrimary(
                      S.of(context).yes_continue,
                      textSize: 16,
                      onPress: () {
                        Nav.to(const PaymentPage());
                      },
                      // expand: true,
                      radius: 8,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
