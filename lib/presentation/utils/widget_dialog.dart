import 'package:cool_app/generated/l10n.dart';
import 'package:cool_app/presentation/theme/color_utils.dart';
import 'package:flutter/material.dart';

class WidgetDialogOtp extends StatefulWidget {
  final String? judul, isiContent;
  final Function? ok, dismiss, otp;
  const WidgetDialogOtp(
      {super.key,
      this.judul,
      this.isiContent,
      this.dismiss,
      this.ok,
      this.otp});

  @override
  State<WidgetDialogOtp> createState() => _WidgetDialogOtpState();
}

class _WidgetDialogOtpState extends State<WidgetDialogOtp> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      insetPadding: const EdgeInsets.all(20),
      scrollable: true,
      title: Center(child: Text("${widget.judul}")),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  "images/disclaimer.png",
                  height: 37.5,
                  width: 37.5,
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              Center(
                  child: Text(
                "${widget.isiContent}",
                textAlign: TextAlign.center,
              )),
              const SizedBox(
                height: 25,
              ),
              MaterialButton(
                  minWidth: 150,
                  height: 45,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: primaryColor,
                  textColor: Colors.white,
                  child: Text(
                    S.of(context).resend,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    widget.ok!();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
