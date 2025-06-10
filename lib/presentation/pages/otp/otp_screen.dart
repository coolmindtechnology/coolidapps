import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:coolappflutter/data/provider/provider_auth.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/utils/notification_utils.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:provider/provider.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({
    super.key,
    required this.channel,
    required this.idUser,
    this.phonenumber,
    this.password,
  });

  final String channel;
  final String idUser;
  final String? phonenumber;
  final String? password;

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
        final screenWidth = MediaQuery.of(context).size.width;
        final screenHeight = MediaQuery.of(context).size.height;
        final boxCount = 6;
        final spacing = 8.0; // spacing antar kotak
        final totalSpacing = spacing * (boxCount - 1);
        final pinBoxWidth = (screenWidth - totalSpacing - 40) / boxCount; // 40 adalah padding horizontal
        final pinBoxHeight = screenHeight * 0.08; // contoh: 8% dari tinggi layar

        return Scaffold(
          backgroundColor: primaryColor,
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
              padding: const EdgeInsets.only(bottom: 30, right: 20, left: 20, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 80),
                  Text(
                    S.of(context).OTP_Code_Input,
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 28),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.channel == "sms"
                        ? S.of(context).otp_code_has_been_sent(
                        providerAuth.formattedTime)
                        : widget.channel == "wa"
                        ? S.of(context).otp_code_has_been_sent_wa(
                        providerAuth.formattedTime)
                        : S.of(context).otp_code_has_been_sent_email(
                        providerAuth.formattedTime),
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.start,
                  ),
                  gapH20,
                  PinCodeTextField(
                    pinBoxHeight: pinBoxHeight,
                    pinBoxWidth: pinBoxWidth,
                    pinBoxRadius: 10,
                    pinTextStyle: const TextStyle(color: Colors.white),
                    defaultBorderColor: Colors.white,
                    hasTextBorderColor: const Color(0xFFF2F2F2),
                    pinBoxColor: primaryColor,
                    maxLength: boxCount,
                    isCupertino: true,
                    controller: otpController,
                    pinBoxDecoration: ProvidedPinBoxDecoration.defaultPinBoxDecoration,
                  ),
                  SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      providerAuth.countdownSeconds == 0 ? Text(
                            S.of(context).have_not_received_the_otp,
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w300,),
                          ) : SizedBox(),
                      providerAuth.countdownSeconds == 0
                          ? TextButton(onPressed: () {
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
                        
                      }, child: Text(S.of(context).resend)) : Padding(
                        padding: const EdgeInsets.only(top: 10,right: 10),
                        child: Text(S.of(context).resend),
                      ),
                      providerAuth.countdownSeconds == 0
                          ? SizedBox() : Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text('(${providerAuth.formattedTime})' ),
                      )
                    ],
                  ),
                  
                  Spacer(),
                  providerAuth.isLoading ? Center(child: CircularProgressIndicator(
                    color: primaryColor,
                  )) : MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      height: 55,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      color: primaryColor,
                      textColor: Colors.white,
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
                                idUser: widget.idUser,Password: widget.password,phonenumber: widget.phonenumber);
                          }
                        }
                      }),
                  const SizedBox(
                    height: 24,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Text(
                  //       S.of(context).have_not_received_the_otp,
                  //       style: TextStyle(
                  //           fontSize: 12,
                  //           fontWeight: FontWeight.w300,
                  //           color: primaryColor),
                  //     ),
                  //     const SizedBox(
                  //       width: 8,
                  //     ),
                  //     providerAuth.countdownSeconds == 0
                  //         ? GestureDetector(
                  //             onTap: providerAuth.countdownSeconds == 0
                  //                 ? () {
                  //                     debugPrint(
                  //                         "cek otp ${providerAuth.countdownSeconds}");
                  //                     // if (providerAuth.sourceToOtpScreen ==
                  //                     //     "forgot_password") {
                  //                     //   providerAuth.resendOtp(
                  //                     //       widget.channel, widget.idUser);
                  //                     // }
                  //                     // if (providerAuth.sourceToOtpScreen ==
                  //                     //     "register") {
                  //                     //   providerAuth.resendOtp(
                  //                     //       widget.channel, widget.idUser);
                  //                     // }
                  //
                  //                     providerAuth.resendOtp(
                  //                         widget.channel, widget.idUser);
                  //                     // providerAuth.resendOtp(widget.channel);
                  //                   }
                  //                 : null,
                  //             child: Text(
                  //               S.of(context).resend,
                  //               style: TextStyle(
                  //                   fontSize: 12,
                  //                   fontWeight: FontWeight.w400,
                  //                   color: primaryColor),
                  //             ),
                  //           )
                  //         : Container()
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
