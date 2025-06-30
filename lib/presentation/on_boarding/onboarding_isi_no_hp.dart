import 'dart:async';

import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:coolappflutter/data/locals/preference_handler.dart';
import 'package:coolappflutter/data/locals/shared_pref.dart';
import 'package:coolappflutter/data/provider/provider_auth.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/on_boarding/onboarding_isi_identitas.dart';
import 'package:coolappflutter/presentation/pages/auth/scan_page.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/widgets/GlobalButton.dart';
import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:provider/provider.dart';

import '../theme/color_utils.dart';

class OnboardingIsiNoHp extends StatefulWidget {
  const OnboardingIsiNoHp({super.key,this.codeReferral});
  final String? codeReferral;

  @override
  State<OnboardingIsiNoHp> createState() => _OnboardingIsiNoHpState();
}

class _OnboardingIsiNoHpState extends State<OnboardingIsiNoHp> {
  TextEditingController controllerPhone = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController codeReferal = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  PhoneController phoneController =
  PhoneController(initialValue: PhoneNumber.parse('+62'));
  bool isHide = true;

  onHide() {
    isHide = !isHide;
    setState(() {});
  }

  @override
  void dispose() {
    controllerPhone.dispose();
    passwordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  cekSession() async {
    dynamic ceklanguage = await PreferenceHandler.retrieveISelectLanguage();
    if (ceklanguage == null) {
      Prefs().setLocale('en_US', () {
        setState(() {
          S.load(Locale('en_US'));
          setState(() {});
        });
      });
      Timer(Duration(seconds: 2), () {
        Prefs().getLocale().then((locale) {
          debugPrint(locale);

          S.load(Locale(locale)).then((value) {});
        });
      });
    } else {
      Prefs().setLocale('$ceklanguage', () {
        setState(() {
          S.load(Locale('$ceklanguage'));
          setState(() {});
        });
      });
      Timer(Duration(seconds: 2), () {
        Prefs().getLocale().then((locale) {
          debugPrint(locale);

          S.load(Locale(locale)).then((value) {});
        });
      });
    }
  }

  // logout() async {
  //   debugPrint("logout sukses");
  //   await FirebaseAuth.instance.signOut();
  // }

  bool _isPasswordStrong(String password) {
    final hasUppercase = password.contains(RegExp(r'[A-Z]'));
    final hasLowercase = password.contains(RegExp(r'[a-z]'));
    final hasDigits = password.contains(RegExp(r'[0-9]'));
    final hasSpecialCharacters =
    password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    return password.length >= 8 &&
        hasUppercase &&
        hasLowercase &&
        hasDigits &&
        hasSpecialCharacters;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return S.of(context).cannot_be_empty;
    } else if (value.length < 8) {
      return S.of(context).password_must_be_at_least_8_characters;
    } else if (!_isPasswordStrong(value)) {
      return S
          .of(context)
          .password_must_include_uppercase_letters_lowercase_letters_digits_and_special_characters;
    }
    return null;
  }

  @override
  void initState() {
    // cekSession();
    assert(() {
      controllerPhone.text = '+62821777775';
      passwordController.text = 'Password1234()';
      phoneController.value =
      const PhoneNumber(isoCode: IsoCode.ID, nsn: '+62821777775');
      return true;
    }());
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
   return Consumer<ProviderAuth>(builder: (context, state, child) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, Colors.white], // Gradasi biru ke putih
                begin: Alignment.topCenter,
                end: Alignment.center,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 100,right: 20,left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Image.asset('images/nohpimage.png')),
                  gapH32,
                  Text(S.of(context).register,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  gapH10,
                  Text(S.of(context).phone_number,),
                  gapH6,
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
                    // countryButtonPadding: null,
                    isCountrySelectionEnabled: true,
                    isCountryButtonPersistent: true,
                    // showDialCode: true,
                    // showIsoCodeInInput: false,
                    // showFlagInInput: true,
                    // flagSize: 16,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      helperStyle: TextStyle(color: Colors.black54),
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(
                          color: Colors.black54,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(
                          color: Colors.black54,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(S.of(context).password,),
                  gapH6,
                  TextFormField(
                    style: TextStyle(color: Colors.black54),
                    controller: state.passwordReg,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.next,
                    obscureText: state.isHide,
                    decoration: InputDecoration(
                      hintText: S.of(context).password,
                      hintStyle: const TextStyle(color: Colors.black54),
                      suffixIcon: GestureDetector(
                        onTap: state.onHide,
                        child: Icon(
                          state.isHide
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.black54,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.black54, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Colors.black54),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                            color: Colors.black54, width: 2.0),
                      ),
                    ),
                    validator: _validatePassword,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(S.of(context).repeat_password,),
                  gapH6,
                  TextFormField(
                    style: TextStyle(color: Colors.black54),
                    controller: state.confirmPasswordReg,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.next,
                    obscureText: state.isHide2,
                    decoration: InputDecoration(
                      hintText: S.of(context).repeat_password,
                      hintStyle: const TextStyle(color: Colors.black54),
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.black54, width: 1),
                          borderRadius: BorderRadius.circular(10)),
                      suffixIcon: GestureDetector(
                        onTap: state.onHide2,
                        child: Icon(
                          state.isHide2
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.black54,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Colors.black54,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Colors.black54,
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
                  gapH32,
                  Consumer<ProviderAuth>(
                    builder: (context, authProvider, child) {
                      return authProvider.isLoadingCredential ? Center(child: CircularProgressIndicator(color: primaryColor,)) :GlobalButton(
                        color: primaryColor,
                        text: S.of(context).next,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            authProvider.cekCredential(
                              context: context,
                              phoneNumber: controllerPhone.text,
                              email: null,
                              navigasi: 'nohp',
                              coderef: codeReferal.text
                            );
                          }
                        },
                      );
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  });
  }
}
