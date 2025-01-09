// ignore_for_file: deprecated_member_use

import 'package:coolappflutter/data/locals/preference_handler.dart';
import 'package:coolappflutter/data/provider/provider_auth.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/auth/component/country_state_city_provider.dart';
import 'package:coolappflutter/presentation/pages/auth/component/map_selection.dart';
import 'package:coolappflutter/presentation/pages/auth/login_screen.dart';
import 'package:coolappflutter/presentation/pages/auth/scan_page.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:provider/provider.dart';
import '../../utils/nav_utils.dart';
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
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController codeReferal = TextEditingController();

  TextEditingController controllerCountry = TextEditingController();
  TextEditingController controllerState = TextEditingController();
  TextEditingController controllerCity = TextEditingController();
  TextEditingController controlleDistrict = TextEditingController();

  bool isIndonesia = true;
  String? selectedCountry;
  String? selectedState;
  String? selectedProvince;
  @override
  void initState() {
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
                          // validator: (value) {
                          //   if (value!.isEmpty && state.isCountryIndonesia) {
                          //     return S.of(context).cannot_be_empty;
                          //   }
                          //   return null;
                          // },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        // Dropdown for Country
                        DropdownButtonFormField<int>(
                          hint: Text(S.of(context).select_country,
                              style: const TextStyle(color: Colors.white)),
                          value: provider.selectedCountryId,
                          items: provider.countries
                              .map<DropdownMenuItem<int>>((country) {
                            return DropdownMenuItem<int>(
                              value: country['id'],
                              child: Text(
                                country['name'],
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              provider.setSelectedCountryId(value);
                              provider.fetchCountries(value);
                              provider.fetchStates(value);
                              provider.selectedStateId = null;
                            }
                          },
                          icon: const Icon(Icons.arrow_drop_down,
                              color: Colors.white), // Panah putih
                          decoration: InputDecoration(
                            labelText: S.of(context).country,
                            labelStyle: const TextStyle(color: Colors.white),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 2.0),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 2.0),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Dropdown for State
                        if (provider.selectedCountryId != null)
                          DropdownButtonFormField<int>(
                            hint: Text(S.of(context).select_state,
                                style: const TextStyle(color: Colors.white)),
                            value: provider.selectedStateId,
                            items: provider.states
                                .map<DropdownMenuItem<int>>((state) {
                              return DropdownMenuItem<int>(
                                value: state['id'],
                                child: Text(state['name']),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value != null) {
                                provider.setSelectedStateId(value);
                                // provider.fetchStates(
                                //   provider.selectedCountryId!,
                                // );
                                provider.fetchCities(
                                  provider.selectedCountryId!,
                                  provider.selectedStateId!,
                                );
                              }
                            },
                            icon: const Icon(Icons.arrow_drop_down,
                                color: Colors.white), // Panah putih
                            decoration: InputDecoration(
                              labelText: S.of(context).state,
                              labelStyle: const TextStyle(color: Colors.white),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 2.0),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 2.0),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),

                        const SizedBox(height: 16),
                        // Dropdown for City
                        if (provider.selectedStateId != null)
                          DropdownButtonFormField<int>(
                            hint: Text(S.of(context).select_city,
                                style: const TextStyle(color: Colors.white)),
                            value: provider.selectedCityId,
                            items: provider.cities
                                .map<DropdownMenuItem<int>>((cities) {
                              return DropdownMenuItem<int>(
                                value: cities['id'],
                                child: Text(cities['name']),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value != null) {
                                provider.setSelectedCityId(value);
                                provider.fetchCities(
                                  provider.selectedCountryId!,
                                  provider.selectedStateId!,
                                );
                                provider.fetchDistricts(
                                    provider.selectedCountryId!,
                                    provider.selectedStateId!,
                                    value);
                                print('Selected City ID: $value');
                              }
                            },
                            icon: const Icon(Icons.arrow_drop_down,
                                color: Colors.white), // Panah putih
                            decoration: InputDecoration(
                              labelText: S.of(context).city,
                              labelStyle: const TextStyle(color: Colors.white),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 2.0),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 2.0),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),

                        const SizedBox(
                          height: 16,
                        ),
                        // Dropdown for District
                        if (provider.selectedCityId != null)
                          DropdownButtonFormField<int>(
                            hint: Text(S.of(context).select_district,
                                style: const TextStyle(color: Colors.white)),
                            value: provider.selectedDistrictId,
                            items: provider.district
                                .map<DropdownMenuItem<int>>((district) {
                              return DropdownMenuItem<int>(
                                value: district['id'],
                                child: Text(district['name']),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value != null) {
                                provider.setSelectedDistrictId(value);
                                // provider.fetchDistricts(
                                //     provider.selectedCountryId!,
                                //     provider.selectedStateId!,
                                //     value);
                              }
                            },
                            icon: const Icon(Icons.arrow_drop_down,
                                color: Colors.white), // Panah putih
                            decoration: InputDecoration(
                              labelText: S.of(context).district,
                              labelStyle: const TextStyle(color: Colors.white),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 2.0),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 2.0),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),

                        const SizedBox(
                          height: 15,
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
                              // dynamic idUser =
                              //     await PreferenceHandler.retrieveIdUser();
                              // try {
                              //   await provider.postAddress(
                              //     userId: idUser,
                              //     longitude: locationProvider.longitude,
                              //     latitude: locationProvider.latitude,
                              //   );
                              //   ScaffoldMessenger.of(context)
                              //       .showSnackBar(const SnackBar(
                              //     content: Text("Address posted successfully!"),
                              //   ));
                              // } catch (e) {
                              //   ScaffoldMessenger.of(context)
                              //       .showSnackBar(SnackBar(
                              //     content: Text("Error posting address: $e"),
                              //   ));
                              // }
                              await locationProvider.getCurrentLocation();
                              await locationProvider.openMap(context);
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
                                    S.of(context).use_your_location,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  )),
                        // ElevatedButton(
                        //   onPressed: () {
                        //     // locationProvider.openMap(context);
                        //   },
                        //   child: const Text('Gunakan Lokasi Anda'),
                        // ),

                        // ElevatedButton(
                        //   onPressed: () {
                        //     // Contoh koordinat untuk Jakarta, Indonesia
                        //     locationProvider.fetchLocationData(
                        //         -6.1751, 106.8650); // Latitude, Longitude
                        //   },
                        //   child: const Text('Get Location Data'),
                        // ),
                        // if (locationProvider.selectedCountry != null) ...[
                        //   Text('Country: ${locationProvider.selectedCountry}'),
                        //   Text('State: ${locationProvider.selectedState}'),
                        //   Text('City: ${locationProvider.selectedCity}'),
                        //   if (locationProvider.selectedDistrict != null) ...[
                        //     Text(
                        //         'District: ${locationProvider.selectedDistrict}'), // Menampilkan district
                        //   ]
                        // ],

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
                                    setState(() {});
                                    if (_form.currentState?.validate() ??
                                        false) {
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
                                                provider.selectedCountryId
                                                    .toString(),
                                                provider.selectedStateId
                                                    .toString(),
                                                provider.selectedCityId
                                                    .toString(),
                                                provider.selectedDistrictId
                                                    .toString(),
                                                locationProvider.longitude
                                                    .toString(),
                                                locationProvider.latitude
                                                    .toString(),
                                              );
                                            },
                                            wa: () {
                                              Nav.back();
                                              state.register(
                                                context,
                                                'wa',
                                                controllerEmail.text,
                                                codeReferal.text,
                                                provider.selectedCountryId
                                                    .toString(),
                                                provider.selectedStateId
                                                    .toString(),
                                                provider.selectedCityId
                                                    .toString(),
                                                provider.selectedDistrictId
                                                    .toString(),
                                                locationProvider.longitude
                                                    .toString(),
                                                locationProvider.latitude
                                                    .toString(),
                                              );
                                            },
                                            sms: () {
                                              Nav.back();
                                              state.register(
                                                context,
                                                "sms",
                                                controllerEmail.text,
                                                codeReferal.text,
                                                provider.selectedCountryId
                                                    .toString(),
                                                provider.selectedStateId
                                                    .toString(),
                                                provider.selectedCityId
                                                    .toString(),
                                                provider.selectedDistrictId
                                                    .toString(),
                                                locationProvider.longitude
                                                    .toString(),
                                                locationProvider.latitude
                                                    .toString(),
                                              );
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
