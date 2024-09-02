// ignore_for_file: deprecated_member_use

import 'package:cool_app/data/provider/provider_auth.dart';
import 'package:cool_app/generated/l10n.dart';
import 'package:cool_app/presentation/theme/color_utils.dart';
import 'package:cool_app/presentation/widgets/button_primary.dart';
import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen(
      {super.key, required this.channel, this.isVerif = false});
  final String channel;
  final bool isVerif;

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final keyForm = GlobalKey<FormState>();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPhone = TextEditingController();
  @override
  void dispose() {
    controllerEmail.dispose();
    controllerPhone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderAuth>(
      builder: (context, state, child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              widget.isVerif
                  ? "Verfikasi Akun"
                  : S.of(context).forgot_password_2,
              style: const TextStyle(color: Colors.white),
            ),
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: primaryColor,
          ),
          backgroundColor: primaryColor,
          body: Form(
            key: keyForm,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      widget.channel == 'email'
                          ? S.of(context).enter_email
                          : S.of(context).enter_phone_number,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (widget.channel == "sms" || widget.channel == "wa") ...[
                    PhoneFormField(
                      initialValue:
                          PhoneNumber.parse('+62'), // or use the controller
                      validator: PhoneValidator.compose([
                        PhoneValidator.required(context,
                            errorText: S.of(context).cannot_be_empty),
                        PhoneValidator.validMobile(context,
                            errorText: S.of(context).invalid_phone_number)
                      ]),
                      countrySelectorNavigator:
                          const CountrySelectorNavigator.dialog(),

                      onChanged: (phoneNumber) {
                        controllerPhone.text =
                            phoneNumber.countryCode.toString() +
                                phoneNumber.nsn.toString();
                      },
                      enabled: true,
                      countryButtonPadding: null,
                      isCountrySelectionEnabled: true,
                      isCountryButtonPersistent: true,
                      showDialCode: true,
                      showIsoCodeInInput: false,
                      showFlagInInput: true,
                      flagSize: 16,

                      style: TextStyle(color: whiteColor),
                      decoration: InputDecoration(
                        labelText: S.of(context).phone_number,
                        labelStyle:
                            TextStyle(color: whiteColor, fontFamily: "Poppins"),
                        helperStyle: TextStyle(color: whiteColor),
                        border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                  if (widget.channel == 'email') ...[
                    TextFormField(
                      style: TextStyle(color: whiteColor),
                      controller: controllerEmail,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: S.of(context).email,
                        hintStyle: const TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 2.0,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return S.of(context).cannot_be_empty;
                        }
                        return null;
                      },
                    ),
                  ],
                  const SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    height: 54,
                    child: ButtonPrimary(
                      state.isLoading
                          ? S.of(context).sending
                          : S.of(context).send,
                      onPress: state.isLoading
                          ? () {}
                          : () {
                              if (keyForm.currentState?.validate() == true) {
                                state.sendOtpResetPassword(
                                    context, widget.channel,
                                    email: controllerEmail.text,
                                    phoneNumber: controllerPhone.text,
                                    isVerif: widget.isVerif);
                              } else {}
                            },
                      expand: true,
                      negativeColor: true,
                      radius: 10.0,
                      elevation: 0.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
