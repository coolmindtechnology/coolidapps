import 'dart:async';

import 'package:coolappflutter/data/locals/preference_handler.dart';
import 'package:coolappflutter/data/locals/shared_pref.dart';
import 'package:coolappflutter/data/provider/provider_profiling.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/circular_progress_widget.dart';
import 'package:coolappflutter/presentation/utils/date_util.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/utils/notification_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ScreenTambahProfiling extends StatefulWidget {
  final Function? onAdd;
  const ScreenTambahProfiling({super.key, this.onAdd});

  @override
  State<ScreenTambahProfiling> createState() => _ScreenTambahProfilingState();
}

class _ScreenTambahProfilingState extends State<ScreenTambahProfiling> {
  @override
  void initState() {
    cekSession();
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return ProviderProfiling();
      },
      child: Consumer<ProviderProfiling>(
        builder: (BuildContext context, value, Widget? child) => Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              S.of(context).profiling,
              style: const TextStyle(color: Colors.white),
            ),
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: primaryColor,
          ),
          body: SingleChildScrollView(
            child: Form(
              key: value.keyForm,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 11),
                child: Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).name,
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          validator: (val) {
                            return val!.isEmpty
                                ? S.of(context).cannot_be_empty
                                : null;
                          },
                          controller: value.name,
                          decoration: InputDecoration(
                            hintText: S.of(context).name,
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 1),
                                borderRadius: BorderRadius.circular(
                                    10) // Set the border color here
                                ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          S.of(context).date_of_birth,
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          readOnly: true,
                          validator: (val) {
                            return val!.isEmpty
                                ? S.of(context).cannot_be_empty
                                : null;
                          },
                          controller: value.tglLahir,
                          onTap: () async {
                            var res = await DateUtil.pickDate(context);

                            value.tglLahir.text = DateFormat("dd, MMMM yyyy")
                                .format(res ?? DateTime.now());
                            value.dayDate = res?.day.toString();
                            value.monthDate = res?.month.toString();
                            value.yearDate = res?.year.toString();
                            DateTime currentDate = DateTime.now();
                            value.birthDate = currentDate.year - res!.year;

                            if (currentDate.month < res.month ||
                                (currentDate.month == res.month &&
                                    currentDate.day < res.day)) {
                              value.birthDate;
                            }
                            debugPrint("tes date");
                            setState(() {});
                          },
                          decoration: InputDecoration(
                              hintText: S.of(context).select,
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 1),
                                  borderRadius: BorderRadius.circular(
                                      10) // Set the border color here
                                  ),
                              suffixIcon:
                                  const Icon(Icons.calendar_month_outlined)),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          S.of(context).age,
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          enabled: false,
                          decoration: InputDecoration(
                              hintText:
                                  "${value.birthDate ?? "0"} ${S.of(context).year}",
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 1),
                                  borderRadius: BorderRadius.circular(
                                      10) // Set the border color here
                                  ),
                              fillColor: Colors.grey.withOpacity(0.2),
                              filled: true),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          S.of(context).residence,
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          validator: (val) {
                            return val!.isEmpty
                                ? S.of(context).cannot_be_empty
                                : null;
                          },
                          controller: value.domicile,
                          decoration: InputDecoration(
                            hintText: "${S.of(context).type_ex} Jakarta",
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 1),
                                borderRadius: BorderRadius.circular(
                                    10) // Set the border color here
                                ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          S.of(context).blood_type,
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: 1, color: greyColor)),
                          child: DropdownButton(
                              value: value.bloodType,
                              hint: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(S.of(context).choose),
                              ),
                              underline: Container(),
                              isExpanded: true,
                              items: [
                                if (value.birthDate! < value.minYears) ...["-"],
                                "A",
                                "B",
                                "AB",
                                "O"
                              ].map((e) {
                                return DropdownMenuItem(
                                  value: e,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(e.toString()),
                                  ),
                                );
                              }).toList(),
                              onChanged: (val) {
                                setState(() {
                                  value.bloodType = val;
                                });
                              }),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        value.isAddProfiling
                            ? CircularProgressWidget(color: primaryColor)
                            : MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                color: primaryColor,
                                textColor: Colors.white,
                                height: 54,
                                minWidth: MediaQuery.of(context).size.width,
                                onPressed: value.isAddProfiling
                                    ? null
                                    : () {
                                        if (value.keyForm.currentState!
                                            .validate()) {
                                          if (value.birthDate! < 17) {
                                            NotificationUtils.showSimpleDialog2(
                                                context,
                                                S
                                                    .of(context)
                                                    .is_the_data_entered_correct,
                                                textButton1: S.of(context).yes,
                                                textButton2: S.of(context).no,
                                                isLoading: value.isAddProfiling,
                                                onPress1: () async {
                                              if (!value.isAddProfiling) {
                                                Nav.back();
                                                await value.addDataProfiling(
                                                    context,
                                                    value.bloodType == "-"
                                                        ? ""
                                                        : value.bloodType ?? "",
                                                    value.name.text,
                                                    value.domicile.text,
                                                    onAdd: () async {
                                                  widget.onAdd!();
                                                });
                                              }
                                            }, onPress2: () {
                                              Nav.back();
                                            });
                                          } else if (value.birthDate! > 17 &&
                                              value.bloodType != null) {
                                            NotificationUtils.showSimpleDialog2(
                                                context,
                                                S
                                                    .of(context)
                                                    .is_the_data_entered_correct,
                                                textButton1: S.of(context).yes,
                                                textButton2: S.of(context).no,
                                                onPress1: value.isAddProfiling
                                                    ? () {}
                                                    : () {
                                                        Nav.back();
                                                        value.addDataProfiling(
                                                            context,
                                                            value.bloodType ??
                                                                "",
                                                            value.name.text,
                                                            value.domicile.text,
                                                            onAdd: () async {
                                                          widget.onAdd!();
                                                        });
                                                      },
                                                onPress2: value.isAddProfiling
                                                    ? () {}
                                                    : () {
                                                        Nav.back();
                                                      });
                                          } else if (value.birthDate! > 17 &&
                                              value.bloodType == null) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text(S
                                                  .of(context)
                                                  .please_select_blood_type),
                                              backgroundColor: primaryColor,
                                            ));
                                          }
                                        }
                                      },
                                child: Text(S.of(context).save),
                              )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
