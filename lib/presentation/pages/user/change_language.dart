import 'package:coolappflutter/data/locals/preference_handler.dart';
import 'package:coolappflutter/data/locals/shared_pref.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/widgets/button_primary.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'language/model_language.dart';
import 'language/service_language.dart';

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
      } else if (locale == "ar_AR") {
        setState(() {
          isSelected = "Arabic";
        });
      } else if (locale == "zh_CN") {
        setState(() {
          isSelected = "Chinese";
        });
      } else if (locale == "es_ES") {
        setState(() {
          isSelected = "Spanish";
        });
      } else if (locale == "ms_MY") {
        setState(() {
          isSelected = "Malay";
        });
      } else if (locale == "ru_RU") {
        setState(() {
          isSelected = "Russia";
        });
      } else if (locale == "tr_TR") {
        setState(() {
          isSelected = "Türkiye";
        });
      }

      S.load(Locale(locale)).then((value) {});
    });
  }

  final LocaleService _localeService = LocaleService();
  final PostLocaleService postlocaleService = PostLocaleService();
  List<LocaleModel> _locales = [];
  String? _selectedLocale;
  bool _isLoading = true;

  @override
  void initState() {
    cekSession();
    _loadLocales();
    super.initState();
  }

  Future<void> postloadLocales() async {
    await postlocaleService.postfetchLocales();
  }

  Future<void> _loadLocales() async {
    try {
      final locales = await _localeService.fetchLocales();
      setState(() {
        _locales = locales;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading locales: $e')),
      );
    }
  }

  void _selectLocale(String? locale) {
    setState(() {
      _selectedLocale = locale;
    });
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
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).change_language,
              ),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                  height: MediaQuery.sizeOf(context).height / 1.38,
                  child: _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _locales.length,
                          itemBuilder: (context, index) {
                            final locale = _locales[index];
                            return GestureDetector(
                              onTap: () {
                                _selectLocale(locale.locale);
                                selectBahasa(locale.locale);
                                setState(() {});
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(width: 1, color: Colors.grey),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 16,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${_getFlagEmoji(locale.locale)} ${locale.name}",
                                      style: const TextStyle(
                                          color: Color(0xFF4F4F4F)),
                                    ),
                                    SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: Radio<String>(
                                        value: locale.locale,
                                        groupValue: _selectedLocale,
                                        onChanged: (value) {
                                          debugPrint("cek  b  $value");
                                          _selectLocale(value);
                                          selectBahasa(value);
                                          setState(() {});
                                        },
                                        fillColor: WidgetStateColor.resolveWith(
                                          (Set<WidgetState> states) {
                                            if (states.contains(
                                                WidgetState.selected)) {
                                              return Colors.blue;
                                            }
                                            return Colors.grey;
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        )),
              // GestureDetector(
              //   onTap: () {
              //     setState(() {
              //       selectBahasa("Indonesia");
              //     });
              //   },
              //   child: Container(
              //       decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(10),
              //           border: Border.all(width: 1, color: greyColor)),
              //       padding: const EdgeInsets.symmetric(
              //         horizontal: 20,
              //         vertical: 16,
              //       ),
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           const Text(
              //             "${"🇮🇩"} Indonesia",
              //             style: TextStyle(color: Color(0xFF4F4F4F)),
              //           ),
              //           SizedBox(
              //             width: 24,
              //             height: 24,
              //             child: Radio(
              //               value: "Indonesia",
              //               groupValue: isSelected,
              //               onChanged: (String? value) {
              //                 selectBahasa(value);
              //               },
              //               fillColor: MaterialStateColor.resolveWith(
              //                 (Set<MaterialState> states) {
              //                   if (states.contains(MaterialState.selected)) {
              //                     return primaryColor;
              //                   }
              //                   return greyColor;
              //                 },
              //               ),
              //             ),
              //           ),
              //         ],
              //       )),
              // ),
              // const SizedBox(height: 16),
              // GestureDetector(
              //   onTap: () {
              //     setState(() {
              //       selectBahasa("English");
              //     });
              //   },
              //   child: Container(
              //       decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(10),
              //           border: Border.all(width: 1, color: greyColor)),
              //       padding: const EdgeInsets.symmetric(
              //         horizontal: 20,
              //         vertical: 16,
              //       ),
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           const Text(
              //             "${"🇺🇸"} English",
              //             style: TextStyle(color: Color(0xFF4F4F4F)),
              //           ),
              //           SizedBox(
              //             width: 24,
              //             height: 24,
              //             child: Radio(
              //               fillColor: MaterialStateColor.resolveWith(
              //                 (Set<MaterialState> states) {
              //                   if (states.contains(MaterialState.selected)) {
              //                     return primaryColor;
              //                   }
              //                   return greyColor;
              //                 },
              //               ),
              //               value: "English",
              //               groupValue: isSelected,
              //               onChanged: (String? value) {
              //                 selectBahasa(value);
              //               },
              //             ),
              //           ),
              //         ],
              //       )),
              // ),
              // const SizedBox(
              //   height: 16,
              // ),

              // //arab
              // GestureDetector(
              //   onTap: () {
              //     setState(() {
              //       selectBahasa("Arabic");
              //     });
              //   },
              //   child: Container(
              //       decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(10),
              //           border: Border.all(width: 1, color: greyColor)),
              //       padding: const EdgeInsets.symmetric(
              //         horizontal: 20,
              //         vertical: 16,
              //       ),
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           const Text(
              //             "${"🇸🇦"} Arabic",
              //             style: TextStyle(color: Color(0xFF4F4F4F)),
              //           ),
              //           SizedBox(
              //             width: 24,
              //             height: 24,
              //             child: Radio(
              //               fillColor: MaterialStateColor.resolveWith(
              //                 (Set<MaterialState> states) {
              //                   if (states.contains(MaterialState.selected)) {
              //                     return primaryColor;
              //                   }
              //                   return greyColor;
              //                 },
              //               ),
              //               value: "Arabic",
              //               groupValue: isSelected,
              //               onChanged: (String? value) {
              //                 selectBahasa(value);
              //               },
              //             ),
              //           ),
              //         ],
              //       )),
              // ),

              // //cina
              // const SizedBox(
              //   height: 16,
              // ),
              // GestureDetector(
              //   onTap: () {
              //     setState(() {
              //       selectBahasa("Chinese");
              //     });
              //   },
              //   child: Container(
              //       decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(10),
              //           border: Border.all(width: 1, color: greyColor)),
              //       padding: const EdgeInsets.symmetric(
              //         horizontal: 20,
              //         vertical: 16,
              //       ),
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           const Text(
              //             "${"🇨🇳"} Chinese",
              //             style: TextStyle(color: Color(0xFF4F4F4F)),
              //           ),
              //           SizedBox(
              //             width: 24,
              //             height: 24,
              //             child: Radio(
              //               fillColor: MaterialStateColor.resolveWith(
              //                 (Set<MaterialState> states) {
              //                   if (states.contains(MaterialState.selected)) {
              //                     return primaryColor;
              //                   }
              //                   return greyColor;
              //                 },
              //               ),
              //               value: "Chinese",
              //               groupValue: isSelected,
              //               onChanged: (String? value) {
              //                 selectBahasa(value);
              //               },
              //             ),
              //           ),
              //         ],
              //       )),
              // ),
              // //spanish
              // const SizedBox(
              //   height: 16,
              // ),
              // GestureDetector(
              //   onTap: () {
              //     setState(() {
              //       selectBahasa("Spanish");
              //     });
              //   },
              //   child: Container(
              //       decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(10),
              //           border: Border.all(width: 1, color: greyColor)),
              //       padding: const EdgeInsets.symmetric(
              //         horizontal: 20,
              //         vertical: 16,
              //       ),
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           const Text(
              //             "${"🇪🇸"} Spanish",
              //             style: TextStyle(color: Color(0xFF4F4F4F)),
              //           ),
              //           SizedBox(
              //             width: 24,
              //             height: 24,
              //             child: Radio(
              //               fillColor: MaterialStateColor.resolveWith(
              //                 (Set<MaterialState> states) {
              //                   if (states.contains(MaterialState.selected)) {
              //                     return primaryColor;
              //                   }
              //                   return greyColor;
              //                 },
              //               ),
              //               value: "Spanish",
              //               groupValue: isSelected,
              //               onChanged: (String? value) {
              //                 selectBahasa(value);
              //               },
              //             ),
              //           ),
              //         ],
              //       )),
              // ),

              // //malaysia

              // const SizedBox(
              //   height: 16,
              // ),
              // GestureDetector(
              //   onTap: () {
              //     setState(() {
              //       selectBahasa("Malay");
              //     });
              //   },
              //   child: Container(
              //       decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(10),
              //           border: Border.all(width: 1, color: greyColor)),
              //       padding: const EdgeInsets.symmetric(
              //         horizontal: 20,
              //         vertical: 16,
              //       ),
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           const Text(
              //             "${"🇲🇾"} Melayu",
              //             style: TextStyle(color: Color(0xFF4F4F4F)),
              //           ),
              //           SizedBox(
              //             width: 24,
              //             height: 24,
              //             child: Radio(
              //               fillColor: MaterialStateColor.resolveWith(
              //                 (Set<MaterialState> states) {
              //                   if (states.contains(MaterialState.selected)) {
              //                     return primaryColor;
              //                   }
              //                   return greyColor;
              //                 },
              //               ),
              //               value: "Malay",
              //               groupValue: isSelected,
              //               onChanged: (String? value) {
              //                 selectBahasa(value);
              //               },
              //             ),
              //           ),
              //         ],
              //       )),
              // ),
              // //Russia
              // const SizedBox(
              //   height: 16,
              // ),
              // GestureDetector(
              //   onTap: () {
              //     setState(() {
              //       selectBahasa("Russia");
              //     });
              //   },
              //   child: Container(
              //       decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(10),
              //           border: Border.all(width: 1, color: greyColor)),
              //       padding: const EdgeInsets.symmetric(
              //         horizontal: 20,
              //         vertical: 16,
              //       ),
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           const Text(
              //             "${"🇷🇺"} Russia",
              //             style: TextStyle(color: Color(0xFF4F4F4F)),
              //           ),
              //           SizedBox(
              //             width: 24,
              //             height: 24,
              //             child: Radio(
              //               fillColor: MaterialStateColor.resolveWith(
              //                 (Set<MaterialState> states) {
              //                   if (states.contains(MaterialState.selected)) {
              //                     return primaryColor;
              //                   }
              //                   return greyColor;
              //                 },
              //               ),
              //               value: "Russia",
              //               groupValue: isSelected,
              //               onChanged: (String? value) {
              //                 selectBahasa(value);
              //               },
              //             ),
              //           ),
              //         ],
              //       )),
              // ),

              // //Turkie
              // const SizedBox(
              //   height: 16,
              // ),
              // GestureDetector(
              //   onTap: () {
              //     setState(() {
              //       selectBahasa("Türkiye");
              //     });
              //   },
              //   child: Container(
              //       decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(10),
              //           border: Border.all(width: 1, color: greyColor)),
              //       padding: const EdgeInsets.symmetric(
              //         horizontal: 20,
              //         vertical: 16,
              //       ),
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           const Text(
              //             "${"🇹🇷"} Türkiye",
              //             style: TextStyle(color: Color(0xFF4F4F4F)),
              //           ),
              //           SizedBox(
              //             width: 24,
              //             height: 24,
              //             child: Radio(
              //               fillColor: MaterialStateColor.resolveWith(
              //                 (Set<MaterialState> states) {
              //                   if (states.contains(MaterialState.selected)) {
              //                     return primaryColor;
              //                   }
              //                   return greyColor;
              //                 },
              //               ),
              //               value: "Türkiye",
              //               groupValue: isSelected,
              //               onChanged: (String? value) {
              //                 selectBahasa(value);
              //               },
              //             ),
              //           ),
              //         ],
              //       )),
              // ),

              const SizedBox(
                height: 16,
              ),
              SizedBox(
                height: 54,
                child: ButtonPrimary(
                  S.of(context).save,
                  onPress: () async {
                    debugPrint("is selec $isSelected");
                    if (kDebugMode) {
                      print(isSelected);
                    }
                    if (isSelected == "id_ID") {
                      await PreferenceHandler.storingId("is_indonesia");
                      await PreferenceHandler.storingIdLanguage("0");
                      await PreferenceHandler.storingISelectLanguage("id_ID");
                      Prefs().setLocale('id_ID', () {
                        setState(() {
                          S.load(const Locale('id_ID'));
                          widget.onChanged();
                        });
                      });
                      postloadLocales();
                    } else if (isSelected == "en_US") {
                      await PreferenceHandler.storingId("is_english");
                      await PreferenceHandler.storingIdLanguage("1");
                      await PreferenceHandler.storingISelectLanguage("en_US");

                      Prefs().setLocale('en_US', () {
                        setState(() {
                          S.load(const Locale('en_US'));
                          widget.onChanged();
                        });
                      });
                      postloadLocales();
                    } else if (isSelected == "ar_AR") {
                      await PreferenceHandler.storingId("is_arab");
                      await PreferenceHandler.storingIdLanguage("2");
                      await PreferenceHandler.storingISelectLanguage("ar_AR");
                      Prefs().setLocale('ar_AR', () {
                        setState(() {
                          S.load(const Locale('ar_AR'));
                          widget.onChanged();
                        });
                      });
                      postloadLocales();
                    } else if (isSelected == "zh_CN") {
                      await PreferenceHandler.storingId("is_mandarin");
                      await PreferenceHandler.storingIdLanguage("3");
                      await PreferenceHandler.storingISelectLanguage("zh_CN");
                      Prefs().setLocale('zh_CN', () {
                        setState(() {
                          S.load(const Locale('zh_CN'));
                          widget.onChanged();
                        });
                      });
                      postloadLocales();
                    } else if (isSelected == "es_ES") {
                      await PreferenceHandler.storingId("is_spanish");
                      await PreferenceHandler.storingIdLanguage("4");
                      await PreferenceHandler.storingISelectLanguage("es_ES");
                      Prefs().setLocale('es_ES', () {
                        setState(() {
                          S.load(const Locale('es_ES'));
                          widget.onChanged();
                        });
                      });
                      postloadLocales();
                    } else if (isSelected == "ms_MY") {
                      await PreferenceHandler.storingId("is_melayu");
                      await PreferenceHandler.storingIdLanguage("5");
                      await PreferenceHandler.storingISelectLanguage("ms_MY");

                      Prefs().setLocale('ms_MY', () {
                        setState(() {
                          S.load(const Locale('ms_MY'));
                          widget.onChanged();
                        });
                      });
                      postloadLocales();
                    } else if (isSelected == "ru_RU") {
                      await PreferenceHandler.storingId("is_rusia");
                      await PreferenceHandler.storingIdLanguage("6");
                      await PreferenceHandler.storingISelectLanguage("ru_RU");
                      Prefs().setLocale('ru_RU', () {
                        setState(() {
                          S.load(const Locale('ru_RU'));
                          widget.onChanged();
                        });
                      });
                      postloadLocales();
                    }
                    //Türkiye
                    else if (isSelected == "tr_TR") {
                      await PreferenceHandler.storingId("is_turkish");
                      await PreferenceHandler.storingIdLanguage("7");
                      await PreferenceHandler.storingISelectLanguage("tr_TR");
                      Prefs().setLocale('tr_TR', () {
                        setState(() {
                          S.load(const Locale('tr_TR'));
                          widget.onChanged();
                        });
                      });
                      postloadLocales();
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
      ),
    );
  }

  String _getFlagEmoji(String locale) {
    switch (locale) {
      case 'id_ID':
        return '🇮🇩';
      case 'en_US':
        return '🇺🇸';
      case 'ar_AR':
        return '🇸🇦';
      case 'zh_CN':
        return '🇨🇳';
      case 'es_ES':
        return '🇪🇸';
      case 'ms_MY':
        return '🇲🇾';
      case 'ru_RU':
        return '🇷🇺';
      case 'tr_TR':
        return '🇹🇷';
      default:
        return '';
    }
  }
}
