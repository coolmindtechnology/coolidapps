// ignore_for_file: deprecated_member_use

import 'package:cool_app/data/provider/provider_auth.dart';
import 'package:cool_app/generated/l10n.dart';
import 'package:cool_app/presentation/pages/auth/register_screen.dart';
import 'package:cool_app/presentation/pages/otp/forgot_password_screen.dart';
import 'package:cool_app/presentation/theme/color_utils.dart';
import 'package:cool_app/presentation/utils/nav_utils.dart';
import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:provider/provider.dart';

import 'component/alert_dialog_otp.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController controllerPhone = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  PhoneController phoneController =
      PhoneController(initialValue: PhoneNumber.parse('+62'));
  @override
  void dispose() {
    controllerPhone.dispose();
    passwordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    assert(() {
      controllerPhone.text = '+6285364665287';
      passwordController.text = 'babahAimar@2024';
      phoneController.value =
          PhoneNumber(isoCode: IsoCode.ID, nsn: '6285364665287');
      return true;
    }());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Consumer<ProviderAuth>(builder: (context, value, child) {
        return Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
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
                          controller: phoneController,
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
                          controller: passwordController,
                          obscureText: value.isHide,
                          textInputAction: TextInputAction.done,
                          style: TextStyle(color: whiteColor),
                          decoration: InputDecoration(
                            hintText: S.of(context).password,
                            hintStyle: const TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 1),
                                borderRadius: BorderRadius.circular(
                                    10) // Set the border color here
                                ),
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
                            suffixIcon: GestureDetector(
                              onTap: value.onHide,
                              child: Icon(
                                value.isHide
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null) {
                              return S.of(context).cannot_be_empty;
                            }
                            if (value.length < 8) {
                              return S.of(context).min_8_characters;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () async {
                              await showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialogOtp(
                                    sms: () {
                                      Nav.back();
                                      Nav.to(const ForgotPasswordScreen(
                                        channel: "sms",
                                      ));
                                    },
                                    wa: () {
                                      Nav.back();
                                      Nav.to(const ForgotPasswordScreen(
                                        channel: 'wa',
                                      ));
                                    },
                                    email: () {
                                      Nav.back();
                                      Nav.to(const ForgotPasswordScreen(
                                        channel: 'email',
                                      ));
                                    },
                                  );
                                },
                              );

                              setState(() {
                                passwordController.clear();
                                controllerPhone.clear();
                                phoneController.value = const PhoneNumber(
                                    isoCode: IsoCode.ID, nsn: '');
                              });
                            },
                            child: Text(
                              S.of(context).forgot_password,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
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
                                borderRadius: BorderRadius.circular(10)),
                            color: Colors.white,
                            textColor: primaryColor,
                            onPressed: value.isLoading
                                ? () {}
                                : () {
                                    if (_formKey.currentState?.validate() ??
                                        false) {
                                      value.login(context,
                                          phoneNumber: controllerPhone.text,
                                          password: passwordController.text);
                                    }
                                  },
                            child: Text(
                              value.isLoading
                                  ? S.of(context).logging_in
                                  : S.of(context).sign_in,
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
                S.of(context).dont_have_an_account,
                style: TextStyle(color: whiteColor),
              ),
              const SizedBox(
                width: 8,
              ),
              GestureDetector(
                onTap: () {
                  Nav.back();
                  Nav.to(const RegisterScreen());
                },
                child: Text(
                  S.of(context).register,
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
