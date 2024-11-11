// ignore_for_file: must_be_immutable, library_private_types_in_public_api

import 'package:coolappflutter/data/provider/provider_profiling.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/circular_progress_widget.dart';
import 'package:coolappflutter/presentation/utils/date_util.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/utils/notification_utils.dart';
import 'package:coolappflutter/presentation/widgets/button_primary.dart';
import 'package:coolappflutter/presentation/widgets/custom_input_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddMultipleProfiling extends StatefulWidget {
  int jumlahProfiling;
  int maxJumlahProfiling;
  Function? onAdd;

  AddMultipleProfiling(
    this.jumlahProfiling,
    this.maxJumlahProfiling,
    this.onAdd, {
    super.key,
  });

  @override
  _AddMultipleProfilingState createState() => _AddMultipleProfilingState();
}

class _AddMultipleProfilingState extends State<AddMultipleProfiling> {
  List<TextEditingController> controllers = [];
  List<TextEditingController> controllersName = [];
  List<TextEditingController> controllersDateOfBirth = [];
  List<TextEditingController> controllersAge = [];
  List<TextEditingController> controllersResidence = [];
  List<String?> selectedBloodType = [];
  List<DateTime> selectedDate = [];
  List<GlobalKey<FormState>> formKeys = [];

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < widget.jumlahProfiling; i++) {
      addForm();
    }
  }

  void addForm() {
    controllersName.add(TextEditingController());
    controllersDateOfBirth.add(TextEditingController());
    controllersAge.add(TextEditingController());
    controllersResidence.add(TextEditingController());
    selectedBloodType.add(null);
    selectedDate.add(DateTime.now());
    formKeys.add(GlobalKey<FormState>());
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProviderProfiling(),
      child: Consumer<ProviderProfiling>(builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(S.of(context).add, style: TextStyle(color: whiteColor)),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ListView.separated(
              itemCount: widget.jumlahProfiling,
              separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: greyColor),
                        borderRadius: BorderRadius.circular(20)),
                    child: Form(
                      key: formKeys[index],
                      child: ExpansionTile(
                        maintainState: true,
                        shape: const Border(),
                        title: Text(
                          '${S.of(context).form} ${index + 1}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        childrenPadding: const EdgeInsets.all(20),
                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomInputField(
                            title: S.of(context).name,
                            textEditingController: controllersName[index],
                            validator: (val) {
                              return val!.isEmpty
                                  ? S.of(context).cannot_be_empty
                                  : null;
                            },
                          ),
                          const SizedBox(height: 8.0),
                          CustomInputField(
                            title: S.of(context).date_of_birth,
                            textEditingController:
                                controllersDateOfBirth[index],
                            isReadOnly: true,
                            suffixIcon:
                                const Icon(Icons.calendar_month_outlined),
                            validator: (val) {
                              return val!.isEmpty
                                  ? S.of(context).cannot_be_empty
                                  : null;
                            },
                            onTap: () async {
                              var res = await DateUtil.pickDate(context);

                              setState(() {
                                if (res != null) {
                                  controllersDateOfBirth[index].text =
                                      DateFormat("dd, MMMM yyyy").format(res);
                                  selectedDate[index] = res;

                                  DateTime currentDate = DateTime.now();
                                  controllersAge[index].text =
                                      (currentDate.year - res.year).toString();

                                  if (currentDate.month < res.month ||
                                      (currentDate.month == res.month &&
                                          currentDate.day < res.day)) {
                                    controllersAge[index].text;
                                  }
                                }
                              });
                            },
                          ),
                          const SizedBox(height: 8.0),
                          CustomInputField(
                            title: S.of(context).age,
                            textEditingController: controllersAge[index],
                            isReadOnly: true,
                          ),
                          const SizedBox(height: 8.0),
                          CustomInputField(
                            title: S.of(context).residence,
                            textEditingController: controllersResidence[index],
                            validator: (val) {
                              return val!.isEmpty
                                  ? S.of(context).cannot_be_empty
                                  : null;
                            },
                          ),
                          const SizedBox(height: 8.0),
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
                                value: selectedBloodType[index],
                                hint: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(S.of(context).choose),
                                ),
                                underline: Container(),
                                isExpanded: true,
                                items: [
                                  if (controllersAge[index].text.isEmpty ||
                                      int.parse(controllersAge[index].text) <
                                          17) ...["-"],
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
                                    selectedBloodType[index] = val;
                                  });
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!value.isCreateMultipleProfiling) ...[
                  SizedBox(
                    height: 54,
                    child: ButtonPrimary(S.of(context).add,
                        iconWidget: const Icon(Icons.add),
                        expand: true,
                        negativeColor: true,
                        useBorder: true,
                        border: 1,
                        radius: 10,
                        elevation: 0.0,
                        borderColor: primaryColor, onPress: () {
                      if (widget.jumlahProfiling == widget.maxJumlahProfiling) {
                        NotificationUtils.showDialogError(context, () {
                          Nav.back();
                        },
                            widget: Text(
                              S
                                  .of(context)
                                  .maximum_10_profiling_data_for_1x_transaction(
                                      widget.maxJumlahProfiling),
                              style: const TextStyle(fontSize: 16),
                              textAlign: TextAlign.center,
                            ));
                      } else {
                        setState(() {
                          widget.jumlahProfiling += 1;
                          addForm();
                        });
                      }
                    }),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
                SizedBox(
                  height: 54,
                  child: value.isCreateMultipleProfiling
                      ? const CircularProgressWidget()
                      : ButtonPrimary(S.of(context).save,
                          expand: true,
                          radius: 10,
                          elevation: 0.0, onPress: () async {
                          bool isFormValid = true;
                          for (int i = 0; i < widget.jumlahProfiling; i++) {
                            if (formKeys[i].currentState != null &&
                                !formKeys[i].currentState!.validate()) {
                              isFormValid = false;
                            }
                            if (controllersName[i].text.isEmpty ||
                                controllersDateOfBirth[i].text.isEmpty ||
                                controllersResidence[i].text.isEmpty) {
                              NotificationUtils.showDialogError(context, () {
                                Nav.back();
                              },
                                  widget: Text(
                                    "${S.of(context).please_check_again_on_form} ${i + 1}",
                                    style: const TextStyle(fontSize: 16),
                                    textAlign: TextAlign.center,
                                  ));

                              break;
                            }
                          }

                          bool invalidAge = false;

                          if (isFormValid) {
                            for (int i = 0; i < widget.jumlahProfiling; i++) {
                              if (int.parse(controllersAge[i].text) >= 17 &&
                                  selectedBloodType[i] == null) {
                                invalidAge = true;
                                NotificationUtils.showDialogError(context, () {
                                  Nav.back();
                                },
                                    widget: Text(
                                      "${S.of(context).please_select_blood_type} ${S.of(context).form} ${i + 1}",
                                      style: const TextStyle(fontSize: 16),
                                      textAlign: TextAlign.center,
                                    ));

                                break;
                              }
                            }
                          }

                          if (!invalidAge && isFormValid) {
                            NotificationUtils.showSimpleDialog2(context,
                                S.of(context).is_the_data_entered_correct,
                                textButton1: S.of(context).yes,
                                textButton2: S.of(context).no,
                                onPress1: value.isCreateMultipleProfiling
                                    ? () {}
                                    : () async {
                                        Nav.back();
                                        List<Map<String, dynamic>> formData =
                                            [];
                                        for (int i = 0;
                                            i < widget.jumlahProfiling;
                                            i++) {
                                          Map<String, dynamic> formDataItem = {
                                            'name': controllersName[i].text,
                                            'birth_date':
                                                selectedDate[i].day.toString(),
                                            'month_date': selectedDate[i]
                                                .month
                                                .toString(),
                                            'year_date':
                                                selectedDate[i].year.toString(),
                                            'blood_type':
                                                selectedBloodType[i] == "-"
                                                    ? ""
                                                    : selectedBloodType[i] ??
                                                        "",
                                            'domicile':
                                                controllersResidence[i].text,
                                          };

                                          formData.add(formDataItem);
                                        }
                                        await value.createMultipleProfiling(
                                            context, formData,
                                            onAdd: widget.onAdd);
                                      },
                                onPress2: value.isCreateMultipleProfiling
                                    ? () {}
                                    : () {
                                        Nav.back();
                                      });
                          }
                        }),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
