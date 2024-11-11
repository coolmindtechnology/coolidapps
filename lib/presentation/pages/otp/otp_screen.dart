import 'package:coolappflutter/data/provider/provider_auth.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/utils/notification_utils.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:provider/provider.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, required this.channel, required this.idUser});
  final String channel;
  final String idUser;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController otpController = TextEditingController();
  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderAuth>(
      builder: (context, providerAuth, child) {
        return Scaffold(
          backgroundColor: primaryColor,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    "images/logo_coolapp_new.png",
                    height: 60,
                    width: 194,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 85),
                  child: Column(
                    children: [
                      PinCodeTextField(
                        pinBoxHeight: 55,
                        pinBoxWidth: 45,
                        pinBoxRadius: 10,
                        pinTextStyle: const TextStyle(color: Colors.white),
                        defaultBorderColor: Colors.white,
                        hasTextBorderColor: const Color(0XFFF2F2F2),
                        pinBoxColor: primaryColor,
                        maxLength: 6,
                        isCupertino: true,
                        controller: otpController,
                        pinBoxDecoration:
                            ProvidedPinBoxDecoration.defaultPinBoxDecoration,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Text(
                          widget.channel == "sms"
                              ? S.of(context).otp_code_has_been_sent(
                                  providerAuth.formattedTime)
                              : widget.channel == "wa"
                                  ? S.of(context).otp_code_has_been_sent_wa(
                                      providerAuth.formattedTime)
                                  : S.of(context).otp_code_has_been_sent_email(
                                      providerAuth.formattedTime),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      MaterialButton(
                          minWidth: MediaQuery.of(context).size.width,
                          height: 55,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          color: Colors.white,
                          textColor: primaryColor,
                          child: Text(
                            S.of(context).next,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            if (otpController.value.text.length < 6 ||
                                otpController.value.text.isEmpty) {
                              NotificationUtils.showDialogError(context, () {
                                Nav.back();
                              },
                                  widget: Text(
                                    otpController.value.text.length < 6
                                        ? S.of(context).not_complete
                                        : S.of(context).cannot_be_empty,
                                    style: const TextStyle(fontSize: 16),
                                    textAlign: TextAlign.center,
                                  ));
                            } else {
                              if (providerAuth.sourceToOtpScreen ==
                                  "forgot_password") {
                                providerAuth.verifyOtpResetPassword(
                                    context, otpController.text);
                              }
                              if (providerAuth.sourceToOtpScreen ==
                                  "register") {
                                providerAuth.verify(context, otpController.text,
                                    idUser: widget.idUser);
                              }
                            }
                          }),
                      const SizedBox(
                        height: 24,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            S.of(context).have_not_received_the_otp,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                color: whiteColor),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          providerAuth.countdownSeconds == 0
                              ? GestureDetector(
                                  onTap: providerAuth.countdownSeconds == 0
                                      ? () {
                                          debugPrint(
                                              "cek otp ${providerAuth.countdownSeconds}");
                                          // if (providerAuth.sourceToOtpScreen ==
                                          //     "forgot_password") {
                                          //   providerAuth.resendOtp(
                                          //       widget.channel, widget.idUser);
                                          // }
                                          // if (providerAuth.sourceToOtpScreen ==
                                          //     "register") {
                                          //   providerAuth.resendOtp(
                                          //       widget.channel, widget.idUser);
                                          // }

                                          providerAuth.resendOtp(
                                              widget.channel, widget.idUser);
                                          // providerAuth.resendOtp(widget.channel);
                                        }
                                      : null,
                                  child: Text(
                                    S.of(context).resend,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: whiteColor),
                                  ),
                                )
                              : Container()
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
