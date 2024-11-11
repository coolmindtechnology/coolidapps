import 'package:coolappflutter/data/locals/shared_pref.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/widgets/button_primary.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ChangeLanguange extends StatefulWidget {
  final void Function() onChanged;
  const ChangeLanguange({super.key, required this.onChanged});

  @override
  State<ChangeLanguange> createState() => _ChangeLanguangeState();
}

class _ChangeLanguangeState extends State<ChangeLanguange> {
  String isSelected = "Indonesia";
  void selectBahasa(String? val) {
    setState(() {
      isSelected = val ?? "";
    });
  }

  cekSession() async {
    Prefs().getLocale().then((locale) {
      if (kDebugMode) {
        print(locale);
      }

      if (locale == "id_ID") {
        setState(() {
          isSelected = "Indonesia";
        });
      } else if (locale == "en_US") {
        setState(() {
          isSelected = "English";
        });
      }

      S.load(Locale(locale)).then((value) {});
    });
  }

  @override
  void initState() {
    cekSession();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: whiteColor,
        ),
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          S.of(context).language,
          style: TextStyle(color: whiteColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).change_language,
            ),
            const SizedBox(
              height: 8,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  selectBahasa("Indonesia");
                });
              },
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 1, color: greyColor)),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "${"🇮🇩"} Indonesia",
                        style: TextStyle(color: Color(0xFF4F4F4F)),
                      ),
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: Radio(
                          value: "Indonesia",
                          groupValue: isSelected,
                          onChanged: (String? value) {
                            selectBahasa(value);
                          },
                          fillColor: MaterialStateColor.resolveWith(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.selected)) {
                                return primaryColor;
                              }
                              return greyColor;
                            },
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                setState(() {
                  selectBahasa("English");
                });
              },
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 1, color: greyColor)),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "${"🇺🇸"} English",
                        style: TextStyle(color: Color(0xFF4F4F4F)),
                      ),
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: Radio(
                          fillColor: MaterialStateColor.resolveWith(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.selected)) {
                                return primaryColor;
                              }
                              return greyColor;
                            },
                          ),
                          value: "English",
                          groupValue: isSelected,
                          onChanged: (String? value) {
                            selectBahasa(value);
                          },
                        ),
                      ),
                    ],
                  )),
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 54,
              child: ButtonPrimary(
                S.of(context).save,
                onPress: () {
                  if (kDebugMode) {
                    print(isSelected);
                  }
                  if (isSelected == "Indonesia") {
                    Prefs().setLocale('id_ID', () {
                      setState(() {
                        S.load(const Locale('id_ID'));
                        widget.onChanged();
                      });
                    });
                  } else if (isSelected == "English") {
                    Prefs().setLocale('en_US', () {
                      setState(() {
                        S.load(const Locale('en_US'));
                        widget.onChanged();
                      });
                    });
                  }

                  Nav.back();
                },
                radius: 10,
                expand: true,
              ),
            )
          ],
        ),
      ),
    );
  }
}
