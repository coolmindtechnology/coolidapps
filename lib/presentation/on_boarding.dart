// ignore_for_file: use_build_context_synchronously

import 'package:cool_app/data/locals/shared_pref.dart';
import 'package:cool_app/data/provider/provider_boarding.dart';
import 'package:cool_app/generated/l10n.dart';
import 'package:cool_app/presentation/on_boarding2.dart';
import 'package:cool_app/presentation/theme/color_utils.dart';
import 'package:cool_app/presentation/utils/nav_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ObBoarding extends StatefulWidget {
  // final void Function() onChanged;
  const ObBoarding({super.key, this.codeReferral});
  final String? codeReferral;

  @override
  State<ObBoarding> createState() => _ObBoardingState();
}

class _ObBoardingState extends State<ObBoarding> {
  String isSelected = "Indonesia";
  void selectBahasa(String? val) {
    setState(() {
      isSelected = val ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 60,
          ),
          Center(
            child: Image.asset(
              "images/logo_coolapp_new.png",
              height: 60,
              width: 194,
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          Text(
            S.of(context).choose_language,
            style: TextStyle(
                color: whiteColor, fontSize: 20, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: 2,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectBahasa(
                        index == 0 ? "Indonesia" : "English",
                      );
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 2, color: Colors.white)),
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          index == 0
                              ? "${"🇮🇩"} Indonesia"
                              : "${"🇺🇸"} English",
                          style: const TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          height: 24,
                          width: 24,
                          child: Radio(
                            fillColor: MaterialStateColor.resolveWith(
                                (states) => Colors.white),
                            focusColor: Colors.white,
                            value: index == 0 ? "Indonesia" : "English",
                            groupValue: isSelected,
                            onChanged: (String? value) {
                              selectBahasa(value);
                            },
                            activeColor: Colors.white,
                            hoverColor: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Padding(padding: EdgeInsets.only(bottom: 16));
              },
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: MaterialButton(
                minWidth: MediaQuery.of(context).size.width,
                height: 55,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: Colors.white,
                textColor: primaryColor,
                child: Text(
                  S.of(context).next,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();

                  if (isSelected == "Indonesia") {
                    Prefs().setLocale('id_ID', () {
                      setState(() {
                        S.load(const Locale('id_ID'));
                      });
                    });
                  } else if (isSelected == "English") {
                    Prefs().setLocale('en_US', () {
                      setState(() {
                        S.load(const Locale('en_US'));
                      });
                    });
                  }
                  await prefs.setBool("lang_dialog_showed", true);

                  context
                      .read<ProviderBoarding>()
                      .getSOnBoarding(context)
                      .then((value) {
                    Nav.replace(const ObBoarding2());
                  });
                }),
          ),
        ],
      ),
    );
  }
}
