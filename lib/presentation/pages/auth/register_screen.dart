// ignore_for_file: deprecated_member_use

import 'package:cool_app/data/provider/provider_auth.dart';
import 'package:cool_app/generated/l10n.dart';
import 'package:cool_app/presentation/pages/auth/login_screen.dart';
import 'package:cool_app/presentation/pages/auth/scan_page.dart';
import 'package:cool_app/presentation/theme/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:provider/provider.dart';
import '../../utils/nav_utils.dart';
import 'component/alert_dialog_otp.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, this.codeReferral});

  final String? codeReferral;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  TextEditingController controllerPhone = TextEditingController();

  TextEditingController controllerEmail = TextEditingController();
  TextEditingController codeReferal = TextEditingController();

  bool isIndonesia = true;
  @override
  void initState() {
    if (widget.codeReferral != null) {
      List<String> parts = widget.codeReferral!.split('/');
      String code = parts.last;
      codeReferal.text = code;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Consumer<ProviderAuth>(builder: (context, state, child) {
        return Form(
          key: _form,
          child: Center(
            child: SingleChildScrollView(
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
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 48),
                    child: Column(
                      children: [
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
                            state.phoneNumberReg.text =
                                phoneNumber.countryCode.toString() +
                                    phoneNumber.nsn.toString();

                            if (phoneNumber.countryCode.toString() != "62") {
                              setState(() {
                                isIndonesia = false;
                              });
                            }
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
                            labelStyle: TextStyle(
                                color: whiteColor, fontFamily: "Poppins"),
                            helperStyle: TextStyle(color: whiteColor),
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 1),
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
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          style: TextStyle(color: whiteColor),
                          controller: controllerEmail,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintText: S.of(context).email,
                            hintStyle: const TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 1),
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
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          style: TextStyle(color: whiteColor),
                          controller: state.passwordReg,
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.next,
                          obscureText: state.isHide,
                          decoration: InputDecoration(
                            hintText: S.of(context).password,
                            hintStyle: const TextStyle(color: Colors.white),
                            suffixIcon: GestureDetector(
                              onTap: state.onHide,
                              child: Icon(
                                state.isHide
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.white,
                              ),
                            ),
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 1),
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
                            if (value == null || value.length < 8) {
                              return S.of(context).min_8_characters;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          style: TextStyle(color: whiteColor),
                          controller: state.confirmPasswordReg,
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.next,
                          obscureText: state.isHide2,
                          decoration: InputDecoration(
                            hintText: S.of(context).repeat_password,
                            hintStyle: const TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 1),
                                borderRadius: BorderRadius.circular(10)),
                            suffixIcon: GestureDetector(
                              onTap: state.onHide2,
                              child: Icon(
                                state.isHide2
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.white,
                              ),
                            ),
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
                            } else if (value != state.passwordReg.text) {
                              return S.of(context).not_match;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          style: TextStyle(color: whiteColor),
                          controller: codeReferal,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            hintText: state.isCountryIndonesia
                                ? S.of(context).referral_code_affiliate
                                : S.of(context).referral_code_optional,
                            hintStyle: const TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 1),
                                borderRadius: BorderRadius.circular(10)),
                            suffixIcon: GestureDetector(
                              onTap: () async {
                                var data = await Nav.to(const ScanPage());
                                // if (data != null) {
                                setState(() {
                                  codeReferal.text = data;
                                });
                                // }
                              },
                              child: Icon(
                                Icons.qr_code_scanner_rounded,
                                color: whiteColor,
                              ),
                            ),
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
                          // validator: (value) {
                          //   if (value!.isEmpty && state.isCountryIndonesia) {
                          //     return S.of(context).cannot_be_empty;
                          //   }
                          //   return null;
                          // },
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        MaterialButton(
                            minWidth: MediaQuery.of(context).size.width,
                            height: 55,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            color: Colors.white,
                            textColor: primaryColor,
                            onPressed: state.isLoading
                                ? () {}
                                : () {
                                    if (_form.currentState?.validate() ??
                                        false) {
                                      // if (isIndonesia) {
                                      showDialog(
                                        context: context,
                                        builder: (context2) {
                                          return AlertDialogOtp(
                                            sms: () {
                                              Nav.back();
                                              state.register(
                                                  context,
                                                  "sms",
                                                  controllerEmail.text,
                                                  codeReferal.text);
                                            },
                                            wa: () {
                                              Nav.back();
                                              state.register(
                                                  context,
                                                  'wa',
                                                  controllerEmail.text,
                                                  codeReferal.text);
                                            },
                                            email: () {
                                              Nav.back();
                                              state.register(
                                                  context,
                                                  'email',
                                                  controllerEmail.text,
                                                  codeReferal.text);
                                            },
                                          );
                                        },
                                      );
                                      // } else {
                                      //   state.register(
                                      //       context,
                                      //       'email',
                                      //       controllerEmail.text,
                                      //       codeReferal.text);
                                      // }
                                    }
                                  },
                            child: Text(
                              state.isLoading
                                  ? S.of(context).registering
                                  : S.of(context).register,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
      bottomNavigationBar: SizedBox(
        height: 100,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                S.of(context).already_have_an_account,
                style: TextStyle(color: whiteColor),
              ),
              const SizedBox(
                width: 8,
              ),
              GestureDetector(
                onTap: () {
                  Nav.back();
                  Nav.to(const LoginScreen());
                },
                child: Text(
                  S.of(context).sign_in,
                  style:
                      TextStyle(color: whiteColor, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
