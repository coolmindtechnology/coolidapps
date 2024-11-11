// ignore_for_file: deprecated_member_use

import 'package:coolappflutter/data/provider/provider_auth.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/widgets/button_primary.dart';
import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen(
      {super.key, required this.channel, this.isVerif = false, this.number});
  final String channel;
  final bool isVerif;
  final String? number;

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final keyForm = GlobalKey<FormState>();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPhone = TextEditingController();
  final TextEditingController phones = TextEditingController();
  String selectedCountryCode = '+62'; // Default to Indonesia
  String selectedFlag = '🇮🇩'; // Default to Indonesia flag

  final List<Map<String, String>> countryCodes = [
    {'code': '+1', 'flag': '🇺🇸'}, // USA
    {'code': '+44', 'flag': '🇬🇧'}, // UK
    {'code': '+60', 'flag': '🇲🇾'}, // Malaysia
    {'code': '+62', 'flag': '🇮🇩'}, // Indonesia
    {'code': '+91', 'flag': '🇮🇳'}, // India
    {'code': '+81', 'flag': '🇯🇵'}, // Japan
    // Tambahkan lebih banyak kode negara dan bendera sesuai kebutuhan
  ];

  @override
  void initState() {
    setState(() {});
    if (widget.number.toString().startsWith("62")) {
      controllerPhone.text = widget.isVerif
          ? widget.number.toString().replaceFirst("62", "")
          : "No.Hp";
    }
    if (widget.number.toString().startsWith("60")) {
      controllerPhone.text = widget.isVerif
          ? widget.number.toString().replaceFirst("60", "")
          : "No.Hp";
    }

    // controllerPhone.text = widget.isVerif ? widget.number.toString().replaceFirst("62", "") : "No.Hp";
    // phones.addListener(() {
    //   // Cek apakah teks diawali dengan "08"
    //   if (phones.text.startsWith("08")) {
    //     setState(() {
    //       phones.text = phones.text.replaceFirst("08", "628");
    //       phones.selection = TextSelection.fromPosition(
    //         TextPosition(offset: phones.text.length),
    //       );
    //     });
    //   }
    // });
    super.initState();
  }

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
                    if (widget.isVerif)
                      PhoneFormField(
                        initialValue: PhoneNumber.parse(
                            widget.number.toString().substring(0, 2) == '62'
                                ? '+62'
                                : '+60'), // or use the controller
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
                        enabled: widget.isVerif ? false : true,
                        countryButtonPadding: null,
                        isCountrySelectionEnabled: true,
                        isCountryButtonPersistent: true,
                        showDialCode: true,
                        showIsoCodeInInput: false,
                        showFlagInInput: true,
                        flagSize: 16,

                        style: TextStyle(color: whiteColor),
                        decoration: InputDecoration(
                          labelText: controllerPhone.text.toString(),
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
                    if (!widget.isVerif)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            // DropdownButton untuk kode negara dan bendera
                            DropdownButtonHideUnderline(
                              child: DropdownButton<Map<String, String>>(
                                value: countryCodes.firstWhere((item) =>
                                    item['code'] == selectedCountryCode),
                                onChanged: (Map<String, String>? newValue) {
                                  setState(() {
                                    selectedCountryCode = newValue!['code']!;
                                    selectedFlag = newValue['flag']!;
                                  });
                                },
                                items: countryCodes
                                    .map<DropdownMenuItem<Map<String, String>>>(
                                        (Map<String, String> country) {
                                  return DropdownMenuItem<Map<String, String>>(
                                    value: country,
                                    child: Row(
                                      children: [
                                        Text(country['flag']!), // Bendera
                                        const SizedBox(width: 8),
                                        Text(country['code']!), // Kode negara
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            const SizedBox(width: 10),
                            // TextField untuk nomor telepon
                            Expanded(
                              child: TextField(
                                controller: phones,
                                keyboardType: TextInputType.phone,
                                decoration: const InputDecoration(
                                  hintText: "No.Hp",
                                  border: InputBorder
                                      .none, // Hilangkan border internal TextField
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    // TextField(
                    //   controller: phones,
                    //   decoration: const InputDecoration(
                    //       hintText: "No.Hp", border: OutlineInputBorder()),
                    // )
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
                      state.isLoading == true
                          ? S.of(context).sending
                          : S.of(context).send,
                      onPress: state.isLoading
                          ? () {}
                          : () {
                              // setState(() {});
                              controllerPhone.text = widget.number.toString();
                              debugPrint(
                                  "cek salah3  ${widget.number.toString()}");
                              debugPrint("cek salah4  ${controllerPhone.text}");
                              debugPrint("cek email  ${controllerEmail.text}");
                              if (widget.channel == "email") {
                                debugPrint("masuk email");
                                state.sendOtpResetPassword(
                                    context, widget.channel,
                                    email: controllerEmail.text,
                                    phoneNumber: "",
                                    isVerif: widget.isVerif);
                              }
                              if (widget.channel == "sms" ||
                                  widget.channel == "wa") {
                                debugPrint("masuk phone");
                                if (!widget.isVerif) {
                                  state.sendOtpResetPassword(
                                      context, widget.channel,
                                      email: "",
                                      phoneNumber:
                                          selectedCountryCode + phones.text,
                                      isVerif: widget.isVerif);
                                } else {
                                  state.sendOtpResetPassword(
                                      context, widget.channel,
                                      email: "",
                                      phoneNumber: controllerPhone.text,
                                      isVerif: widget.isVerif);
                                }
                              } else {
                                debugPrint("cek salah1");
                              }
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
