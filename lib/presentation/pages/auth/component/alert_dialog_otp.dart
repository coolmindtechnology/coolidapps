import 'package:coolappflutter/generated/l10n.dart';
import 'package:flutter/material.dart';

import '../../../theme/color_utils.dart';
import '../../../widgets/button_primary.dart';

class AlertDialogOtp extends StatelessWidget {
  const AlertDialogOtp(
      {super.key, required this.sms, required this.wa, required this.email});
  final Function()? sms;
  final Function()? wa;
  final Function()? email;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            S.of(context).please_select_a_method_to_send_otp_code,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            height: 54,
            child: ButtonPrimary(
              "Email",
              expand: true,
              onPress: email,
              elevation: 0.0,
              radius: 10,
              negativeColor: true,
              border: 1,
              borderColor: primaryColor,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            height: 54,
            child: ButtonPrimary(
              "WA",
              expand: true,
              onPress: wa,
              elevation: 0.0,
              radius: 10,
              negativeColor: true,
              border: 1,
              borderColor: primaryColor,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            height: 54,
            child: ButtonPrimary(
              "SMS",
              expand: true,
              onPress: sms,
              elevation: 0.0,
              radius: 10,
            ),
          ),
        ],
      ),
    );
  }
}
