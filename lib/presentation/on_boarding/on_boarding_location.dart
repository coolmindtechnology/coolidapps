import 'dart:async';

import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:coolappflutter/data/locals/preference_handler.dart';
import 'package:coolappflutter/data/provider/provider_adress.dart';
import 'package:coolappflutter/data/provider/provider_auth.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/on_boarding/on_boarding_isi_ktp.dart';
import 'package:coolappflutter/presentation/pages/auth/component/alert_dialog_otp.dart';
import 'package:coolappflutter/presentation/pages/auth/component/country_state_city_provider.dart';
import 'package:coolappflutter/presentation/pages/auth/map_screen.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/utils/notification_utils.dart';
import 'package:coolappflutter/presentation/widgets/GlobalButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/locals/shared_pref.dart';
import '../pages/auth/component/location_provider.dart';

class OnBoardingLoactionPage extends StatefulWidget {
  final String phoneNumber;
  final String email;
  final String coderef;
  OnBoardingLoactionPage({super.key, required this.phoneNumber, required this.email,required this.coderef});
  @override
  State<OnBoardingLoactionPage> createState() => _OnBoardingLoactionPageState();
}

class _OnBoardingLoactionPageState extends State<OnBoardingLoactionPage> {
  TextEditingController codeReferal = TextEditingController();
  TextEditingController controllerCountry = TextEditingController();
  TextEditingController controllerState = TextEditingController();
  TextEditingController controllerCity = TextEditingController();
  TextEditingController controllerDistrict = TextEditingController();
  TextEditingController controllerLong = TextEditingController();
  TextEditingController controllerLat = TextEditingController();

  final _formKey = GlobalKey<FormState>();

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
    if (widget.coderef != null) {
      List<String> parts = widget.coderef!.split('/');
      String code = parts.last;
      codeReferal.text = code;
    }
    cekSession();
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
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, Colors.white], // Gradasi biru ke putih
                begin: Alignment.topCenter,
                end: Alignment.center,
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          'images/imageLoaction.png', // Ganti dengan path gambar kamu
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                     Text(
                      S.of(context).isiIdentitas,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                     Text(
                       S.of(context).use_your_location,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 24),
                    if (controllerCountry.text.isNotEmpty)
                      ...[
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                controller: controllerCountry,
                                onChanged: (value) {
                                  setState(() {
                                    selectedCountry = value;
                                  });
                                },
                                textColor: primaryColor,
                              ),
                            ),
                            const SizedBox(width: 10), // Pengganti gapH10
                            Expanded(
                              child: CustomTextField(
                                controller: controllerState,
                                onChanged: (value) {
                                  setState(() {
                                    selectedState = value;
                                  });
                                },
                                textColor: primaryColor,
                              ),
                            ),
                          ],
                        )
                      ],
                    if (controllerCountry.text.isNotEmpty)
                      ...[
                        Row(
                          children: [
                            Expanded(
                              child:  CustomTextField(
                                controller: controllerCity,
                                onChanged: (value) {
                                  setState(() {
                                    selectedCity = value;
                                  });
                                },
                                textColor: primaryColor,
                              ),
                            ),
                            const SizedBox(width: 10), // Pengganti gapH10
                            Expanded(
                              child: CustomTextField(
                                controller: controllerDistrict,
                                onChanged: (value) {
                                  setState(() {
                                    selectedDistrict = value;
                                  });
                                },
                                textColor: primaryColor,
                              ),
                            ),
                          ],
                        )
                      ],
                    MaterialButton(
                        minWidth: MediaQuery.of(context).size.width,
                        height: 55,
                        elevation: 0,
                        shape: RoundedRectangleBorder(side: BorderSide(color: Colors.black38),

                            borderRadius: BorderRadius.circular(10),

                        ),
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
                          S.of(context).silahkanPilihLokasi,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold),
                        )),
                    const SizedBox(height: 60),
                    const SizedBox(
                      height: 16,
                    ),
                    if (controllerCountry.text.isNotEmpty)
                    MaterialButton(
                        minWidth: MediaQuery.of(context).size.width,
                        height: 55,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: primaryColor,
                        textColor: whiteColor,
                        onPressed: state.isLoading
                            ? () {}
                            : () async {
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
                                        widget.email,
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
                                        widget.phoneNumber);
                                  },
                                  wa: () {
                                    Nav.back();
                                    state.register(
                                        context,
                                        'wa',
                                        widget.email,
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
                                        widget.phoneNumber);
                                  },
                                  sms: () {
                                    Nav.back();
                                    state.register(
                                        context,
                                        "sms",
                                        widget.email,
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
                                        widget.phoneNumber);
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
                                S.of(context).pin_lokasi,
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
                                S.of(context).cek_form_register,
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
              ),
            ),
          ),
        ),
      ),
    );
  });
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
        style: TextStyle(color: primaryColor),
        controller: controller,
        onChanged: onChanged,
        enabled: false,
        decoration: InputDecoration(
          hintStyle: TextStyle(color: primaryColor),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black38, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color:  Colors.black38, width: 2.0),
          ),
        ),
      ),
    );
  }
}

