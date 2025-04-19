// ignore_for_file: must_be_immutable, library_private_types_in_public_api

import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:coolappflutter/data/provider/provider_profiling.dart';
import 'package:coolappflutter/data/response/profiling/res_form.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/profiling/konfrimasi%20identitas.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/circular_progress_widget.dart';
import 'package:coolappflutter/presentation/utils/date_util.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/utils/notification_utils.dart';
import 'package:coolappflutter/presentation/widgets/button_primary.dart';
import 'package:coolappflutter/presentation/widgets/costum_floatingbutton.dart';
import 'package:coolappflutter/presentation/widgets/custom_input_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddMultipleProfiling extends StatefulWidget {
  int jumlahProfiling;
  int maxJumlahProfiling;
  String? coderef;

  AddMultipleProfiling(
    this.jumlahProfiling,
    this.maxJumlahProfiling,
      this.coderef,
   {
    super.key,
  });

  @override
  _AddMultipleProfilingState createState() => _AddMultipleProfilingState();
}

class _AddMultipleProfilingState extends State<AddMultipleProfiling> {
  late ScrollController _scrollController;
  List<TextEditingController> controllers = [];
  List<TextEditingController> controllersName = [];
  List<TextEditingController> controllersDateOfBirth = [];
  List<TextEditingController> controllersAge = [];
  List<TextEditingController> controllersResidence = [];
  List<TextEditingController> controllersCodeRef = [];
  List<String?> selectedBloodType = [];
  List<DateTime> selectedDate = [];
  List<GlobalKey<FormState>> formKeys = [];

  @override
  void initState() {
    _scrollController = ScrollController();
    controllersAge = List.generate(
        widget.jumlahProfiling, (index) => TextEditingController());
    controllersResidence = List.generate(
        widget.jumlahProfiling, (index) => TextEditingController());
    controllersCodeRef = List.generate(
        widget.jumlahProfiling, (index) => TextEditingController());
    selectedBloodType = List.generate(widget.jumlahProfiling, (index) => null);
    controllersCodeRef.add(TextEditingController(text: widget.coderef ?? ""));
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
    controllersCodeRef.add(TextEditingController());
    selectedBloodType.add(null);
    selectedDate.add(DateTime.now());
    formKeys.add(GlobalKey<FormState>());
  }

  void scrollToForm(int index) {
    double screenWidth = MediaQuery.of(context).size.width;
    double separatorWidth = 10.0; // Sesuai dengan separator

    double itemWidth = screenWidth + separatorWidth;
    double targetPosition = index * itemWidth;

    // Batasi agar tidak melebihi batas scroll maksimum
    double maxScroll = _scrollController.position.maxScrollExtent;
    targetPosition = targetPosition.clamp(0, maxScroll);

    print("Scrolling to: $targetPosition (index: $index)");

    _scrollController.animateTo(
      targetPosition,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
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
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 60,
                  width: double.infinity,
                  color: lightBlue,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Image.asset('images/profiling/icBuatProfiling.png'),
                        gapW10,
                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true, // Tambahkan shrinkWrap
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: controllersName.length, // Gunakan panjang list yang dinamis
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () => scrollToForm(index),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Container(
                                    width: 90,
                                    height: 50, // Ubah tinggi agar ada ruang untuk tombol delete
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: primaryColor),
                                    ),
                                    child: Center(
                                      child: TextButton(
                                        onPressed: () => scrollToForm(index),
                                        style: TextButton.styleFrom(foregroundColor: BlueColor),
                                        child: Text(
                                          S.of(context).profile + " " + "${index + 1}",
                                          style: const TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
            
                        IconButton(onPressed: () {
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
                        }, icon: Icon(CupertinoIcons.plus,color: BlueColor,))
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    controller: _scrollController,
                    itemCount: controllersName.length, // Menggunakan panjang list yang dinamis
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 0, left: 16, right: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Baris atas (judul + tombol hapus)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Profil ${index + 1}",
                                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.red),
                                    onPressed: () {
                                      setState(() {
                                        // Hapus data berdasarkan index
                                        controllersName.removeAt(index);
                                        controllersDateOfBirth.removeAt(index);
                                        controllersAge.removeAt(index);
                                        controllersResidence.removeAt(index);
                                        selectedBloodType.removeAt(index);
                                        selectedDate.removeAt(index);
                                      });
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              CustomInputField(
                                title: S.of(context).name,
                                textEditingController: controllersName[index],
                                validator: (val) => val!.isEmpty
                                    ? S.of(context).cannot_be_empty
                                    : null,
                              ),
                              const SizedBox(height: 8.0),
                              CustomInputField(
                                title: S.of(context).date_of_birth,
                                textEditingController:
                                controllersDateOfBirth[index],
                                isReadOnly: true,
                                suffixIcon:
                                const Icon(Icons.calendar_month_outlined),
                                validator: (val) => val!.isEmpty
                                    ? S.of(context).cannot_be_empty
                                    : null,
                                onTap: () async {
                                  var res = await DateUtil.pickDate(context);

                                  if (res != null) {
                                    setState(() {
                                      controllersDateOfBirth[index].text =
                                          DateFormat("dd, MMMM yyyy", "en_US").format(res);

                                      selectedDate[index] = res;

                                      DateTime currentDate = DateTime.now();
                                      int age = currentDate.year - res.year;

                                      if (currentDate.month < res.month ||
                                          (currentDate.month == res.month &&
                                              currentDate.day < res.day)) {
                                        age--;
                                      }
                                      controllersAge[index].text =
                                          age.toString();
                                    });
                                  }
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
                            textEditingController:
                            controllersResidence[index],
                            validator: (val) => val!.isEmpty
                                ? S.of(context).cannot_be_empty
                                : null,
                          ),
                          const SizedBox(height: 8.0),
                          Text(S.of(context).blood_type,
                              style: const TextStyle(fontSize: 14)),
                          const SizedBox(height: 8),
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border:
                              Border.all(width: 1, color: greyColor),
                            ),
                            child: DropdownButton<String>(
                              value: selectedBloodType[index],
                              hint: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(S.of(context).choose),
                              ),
                              underline: Container(),
                              isExpanded: true,
                              items: [
                                if (controllersAge[index].text.isEmpty ||
                                    (int.tryParse(controllersAge[index]
                                        .text) ??
                                        0) <
                                        17)
                                  "-",
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
                                  selectedBloodType[index] = val!;
                                });
                              },
                            ),
                          ),
                              const SizedBox(height: 8.0),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                gapH10,
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // if (widget.coderef != null)
                // CustomInputField(
                //   isReadOnly: true,
                //   title: S.of(context).referral_code_optional,
                //   textEditingController: controllersCodeRef[0]..text = widget.coderef ?? '',
                // ),
                // gapH10,
                // SizedBox(
                //   height: 54,
                //   child: ButtonPrimary(S.of(context).save,
                //       expand: true,
                //       radius: 10,
                //       elevation: 0.0, onPress: ()  async {
                //       Nav.back();
                //       final List<ProfilData> allProfiles = [];
                //       for (int i = 0; i < controllersName.length; i++) {
                //         allProfiles.add(
                //           ProfilData(
                //             name: controllersName[i].text,
                //             dateOfBirth: selectedDate[i].day.toString(),
                //             age: controllersAge[i].text,
                //             residence: controllersResidence[i].text,
                //             bloodType: selectedBloodType[i] ?? "-",
                //             monthDate: selectedDate[i].month.toString(),
                //             yearDate: selectedDate[i].year.toString(),
                //           ),
                //         );
                //       }
                //
                //       Nav.to(KonfirmasiIdentitiasPage(profiles: allProfiles,widget.coderef ?? ''));
                //     },
                //
                //       ),
                // )
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
                                            "ref_code":
                                                controllersCodeRef[i].text,
                                          };

                                          formData.add(formDataItem);
                                        }
                                        await value.createMultipleProfiling(
                                            context, formData,
                                            // onAdd: widget.onAdd
                                            );
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
          floatingActionButton: const CustomFAB(),
        );
      }),
    );
  }
}
