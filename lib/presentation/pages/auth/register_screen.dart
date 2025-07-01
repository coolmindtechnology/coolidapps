// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:coolappflutter/data/locals/preference_handler.dart';
import 'package:coolappflutter/data/provider/provider_auth.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/auth/component/country_state_city_provider.dart';
import 'package:coolappflutter/presentation/pages/auth/component/map_selection.dart';
import 'package:coolappflutter/presentation/pages/auth/login_screen.dart';
import 'package:coolappflutter/presentation/pages/auth/map_screen.dart';
import 'package:coolappflutter/presentation/pages/auth/scan_page.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/notification_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:provider/provider.dart';
import '../../../data/locals/shared_pref.dart';
import '../../utils/nav_utils.dart';
import '../user/language/model_language.dart';
import '../user/language/service_language.dart';
import 'component/alert_dialog_otp.dart';
import 'component/location_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, this.codeReferral});

  final String? codeReferral;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  TextEditingController controllerPhone = TextEditingController();
  TextEditingController phoneNumberReg = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController codeReferal = TextEditingController();

  TextEditingController controllerCountry = TextEditingController();
  TextEditingController controllerState = TextEditingController();
  TextEditingController controllerCity = TextEditingController();
  TextEditingController controllerDistrict = TextEditingController();
  TextEditingController controllerLong = TextEditingController();
  TextEditingController controllerLat = TextEditingController();

  bool isIndonesia = true;
  String? selectedCountry;
  String? selectedState;
  String? selectedCity;
  String? selectedDistrict;
  String? selectedLong;
  String? selectedLat;

  @override
  void initState() {
    controllerCountry.text = selectedCountry ?? '';
    controllerState.text = selectedState ?? '';
    controllerCity.text = selectedCity ?? '';
    controllerDistrict.text = selectedDistrict ?? '';
    controllerLong.text = selectedDistrict ?? '';
    controllerLat.text = selectedDistrict ?? '';

    Timer(Duration(seconds: 3), () {
      cekSession();
    });
    cekSession();
    // Fetch countries when the widget initializes
    final provider =
    Provider.of<CountryStateCityProvider>(context, listen: false);
    provider.fetchCountries(0);
    Future.microtask(() async {
      Provider.of<CountryStateCityProvider>(context, listen: false);
      await provider.fetchCountries(0);
    });

    // // Memanggil fetchCountries dan getCurrentLocation
    Future.microtask(() async {
      final locationProvider =
      Provider.of<LocationProvider>(context, listen: false);
      await locationProvider.fetchCountries();
      await locationProvider.fetchCurrentLocation();
    });
    if (widget.codeReferral != null) {
      List<String> parts = widget.codeReferral!.split('/');
      String code = parts.last;
      codeReferal.text = code;
    }
    cekSession();
    super.initState();
  }

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

  String? _validateEmail(String? value) {
    // Memeriksa apakah email kosong
    if (value == null || value.isEmpty) {
      return S.of(context).cannot_be_empty;
    }
    // Memeriksa format email
    final emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
      caseSensitive: false,
    );
    if (!emailRegExp.hasMatch(value)) {
      return S.of(context).please_enter_a_valid_email_address;
    }
    return null;
  }

  // Fungsi untuk membuka map dan memilih lokasi
  void openMap() async {
    final LatLng? result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapSelectionScreen(
          initialPosition:
          Provider.of<LocationProvider>(context).selectedPosition ??
              const LatLng(-6.1751, 106.8650), // Default position
        ),
      ),
    );

    if (result != null) {
      Provider.of<LocationProvider>(context)
          .fetchLocationData(result.latitude, result.longitude);
    }
  }

  cekSession() async {
    dynamic ceklanguage = await PreferenceHandler.retrieveISelectLanguage();
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

  void _navigateToMap() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MapScreen()),
    );

    if (result != null) {
      setState(() {
        controllerCountry.text = result['country'];
        controllerState.text = result['state'];
        controllerCity.text = result['city'];
        controllerDistrict.text = result['district'];
        controllerLong.text = result['longtitude'].toString();
        controllerLat.text = result['latitide'].toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);
    final provider = Provider.of<CountryStateCityProvider>(context);
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
                  const SizedBox(
                    height: 50,
                  ),
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
                            phoneNumberReg.text =
                                phoneNumber.countryCode.toString() +
                                    phoneNumber.nsn.toString();
                            cekSession();
                          },
                          enabled: true,
                          isCountrySelectionEnabled: true,
                          isCountryButtonPersistent: true,
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
                          validator: _validateEmail,
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
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 2.0),
                            ),
                          ),
                          validator: _validatePassword,
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
                          enabled: widget.codeReferral != null ? false : true,
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
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        if (controllerCountry.text.isNotEmpty)
                        CustomTextField(
                          controller: controllerCountry,
                          onChanged: (value) {
                            setState(() {
                              selectedCountry = value;
                            });
                          },
                          textColor: whiteColor,
                        ),
                        if (controllerCountry.text.isNotEmpty)
                        CustomTextField(
                          controller: controllerState,
                          onChanged: (value) {
                            setState(() {
                              selectedState = value;
                            });
                          },
                          textColor: whiteColor,
                        ),
                        if (controllerCountry.text.isNotEmpty)
                        CustomTextField(
                          controller: controllerCity,
                          onChanged: (value) {
                            setState(() {
                              selectedCity = value;
                            });
                          },
                          textColor: whiteColor,
                        ),
                        if (controllerCountry.text.isNotEmpty)
                        CustomTextField(
                          controller: controllerDistrict,
                          onChanged: (value) {
                            setState(() {
                              selectedDistrict = value;
                            });
                          },
                          textColor: whiteColor,
                        ),
                        MaterialButton(
                            minWidth: MediaQuery.of(context).size.width,
                            height: 55,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            color: Colors.white,
                            textColor: primaryColor,
                            onPressed: () async {
                              _navigateToMap();
                              cekSession();
                            },
                            child: state.isLoading
                                ? Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: <Widget>[
                                const CircularProgressIndicator(),
                                const SizedBox(width: 20),
                                Text(S
                                    .of(context)
                                    .registering), // Display loading text
                              ],
                            )
                                : Text(
                              'Silahkan Pilih Lokasi Anda',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold),
                            )),
                        const SizedBox(
                          height: 16,
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
                              if (controllerCountry.text.isNotEmpty || controllerState.text.isNotEmpty || controllerCity.text.isNotEmpty || controllerDistrict.text.isNotEmpty) {
                                // if (isIndonesia) {
                                showDialog(
                                  context: context,
                                  builder: (context2) {
                                    return AlertDialogOtp(
                                      email: () {
                                        Nav.back();
                                        state.register(
                                            context,
                                            'email',
                                            controllerEmail.text,
                                            codeReferal.text,
                                            controllerCountry
                                                .text,
                                            controllerState
                                                .text,
                                            controllerCity
                                                .text,
                                            controllerDistrict
                                                .text,
                                            controllerLong.text,
                                            controllerLat.text,
                                            phoneNumberReg.text);
                                      },
                                      wa: () {
                                        Nav.back();
                                        state.register(
                                            context,
                                            'wa',
                                            controllerEmail.text,
                                            codeReferal.text,
                                            controllerCountry
                                                .text,
                                            controllerState
                                                .text,
                                            controllerCity
                                                .text,
                                            controllerDistrict
                                                .text,
                                            controllerLong.text,
                                            controllerLat.text,
                                            phoneNumberReg.text);
                                      },
                                      sms: () {
                                        Nav.back();
                                        state.register(
                                            context,
                                            "sms",
                                            controllerEmail.text,
                                            codeReferal.text,
                                            controllerCountry
                                                .text,
                                            controllerState
                                                .text,
                                            controllerCity
                                                .text,
                                            controllerDistrict
                                                .text,
                                           controllerLong.text,
                                            controllerLat.text,
                                            phoneNumberReg.text);
                                      },
                                    );
                                  },
                                );
                              }else if (controllerCountry.text.isEmpty || controllerState.text.isEmpty || controllerCity.text.isEmpty || controllerDistrict.text.isEmpty){
                                NotificationUtils.showDialogError(
                                  context,
                                      () {
                                    Navigator.pop(context); // Menutup dialog saat tombol OK ditekan
                                  },
                                  widget: Text(
                                    'Silahkan pin lokasi terlebih dahulu',
                                    textAlign: TextAlign.center,
                                  ),
                                  textButton: 'Oke',
                                );

                              }else{
                                NotificationUtils.showDialogError(
                                  context,
                                      () {
                                    Navigator.pop(context); // Menutup dialog saat tombol OK ditekan
                                  },
                                  widget: Text(
                                    'Silahkan cek kembali form register',
                                    textAlign: TextAlign.center,
                                  ),
                                  textButton: 'Oke',
                                );

                              }
                              cekSession();
                            },
                            child: state.isLoading
                                ? Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: <Widget>[
                                const CircularProgressIndicator(),
                                const SizedBox(width: 20),
                                Text(S
                                    .of(context)
                                    .registering), // Display loading text
                              ],
                            )
                                : Text(
                              state.isLoading
                                  ? S.of(context).registering
                                  : S.of(context).register,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold),
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

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final Color textColor;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.onChanged,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        style: TextStyle(color: textColor),
        controller: controller,
        onChanged: onChanged,
        enabled: false,
        decoration: InputDecoration(
          hintStyle: TextStyle(color: textColor),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: textColor, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: textColor, width: 2.0),
          ),
        ),
      ),
    );
  }
}
