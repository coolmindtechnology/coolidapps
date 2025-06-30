import 'dart:async';

import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:coolappflutter/data/locals/shared_pref.dart';
import 'package:coolappflutter/data/provider/provider_profiling.dart';
import 'package:coolappflutter/data/response/profiling/res_form.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/main/nav_home.dart';
import 'package:coolappflutter/presentation/pages/profiling/profiling%20dashboard.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/circular_progress_widget.dart';
import 'package:coolappflutter/presentation/utils/date_util.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/utils/notification_utils.dart';
import 'package:coolappflutter/presentation/widgets/GlobalButton.dart';
import 'package:coolappflutter/presentation/widgets/button_primary.dart';
import 'package:coolappflutter/presentation/widgets/custom_input_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../data/locals/preference_handler.dart';
import '../../../data/models/data_checkout_transaction.dart';

class KonfirmasiIdentitiasPage extends StatefulWidget {
  final List<ProfilData> profiles;
  final String? coderef;
  final String? route;
  const KonfirmasiIdentitiasPage(this.coderef,
      {Key? key, required this.profiles,this.route,})
      : super(key: key);

  @override
  State<KonfirmasiIdentitiasPage> createState() =>
      _KonfirmasiIdentitiasPageState();
}

class _KonfirmasiIdentitiasPageState extends State<KonfirmasiIdentitiasPage> {
  late List<ProfilData> allProfiles;

  @override
  void initState() {
    super.initState();
    cekSession();
    allProfiles = widget.profiles;
    Future.microtask(() {
      final provider = Provider.of<ProviderProfiling>(context, listen: false);
      provider.getPriceProfiling(context,widget.profiles.length.toString()); // ← ganti “1” dengan qty yang sesuai
    });
  }

  void deleteProfile(int index,BuildContext context) {
    setState(() {
      allProfiles.removeAt(index);
    });
    final provider = Provider.of<ProviderProfiling>(context, listen: false);
    provider.getPriceProfiling(context,allProfiles.length.toString());
  }

  void editProfile(int index, ProfilData updatedProfile) {
    setState(() {
      allProfiles[index] = updatedProfile;
    });
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
    return Consumer<ProviderProfiling>(builder: (context, value, child) {
      String _getFormattedPrice() {
        if (value.priceProfiling?.data == null) return '';
        return 'Rp ${NumberFormat("#,##0", "id_ID").format(value.priceProfiling!.data)}';
      }
      bool isLoading = value.isCreateMultipleProfiling || value.isPayProfiling || value.isCreatePayment;
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            S.of(context).identity_confirmation,
            style: const TextStyle(color: Colors.white),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: primaryColor,
        ),
        body: Padding(
          padding:
              const EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(S.of(context).your_profiling,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
              gapH10,
              Text(S.of(context).check_profiling_data,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
              gapH20,
              SizedBox(
                height: 400,
                child: PageView.builder(
                  itemCount: allProfiles.length,
                  itemBuilder: (context, index) {
                    final profile = allProfiles[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color(0xFF93F1FB),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => Editpop(
                                        profile: profile,
                                        onSave: (updatedProfile) {
                                          editProfile(index, updatedProfile);
                                        },
                                      ),
                                    );
                                  },
                                  child: Icon(Icons.note_alt_rounded,
                                      color: BlueColor),
                                ),
                                const SizedBox(width: 10),
                                if(allProfiles.length != 1)
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => Dialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: SizedBox(
                                          height: 230,
                                          child: DeleteWarningPop(
                                            onDelete: () =>
                                                deleteProfile(index,context),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Icon(CupertinoIcons.trash_fill,
                                      color: BlueColor),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(S.of(context).name),
                            const SizedBox(height: 5),
                            Text(profile.name ?? '-',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600)),
                            const SizedBox(height: 20),
                            Text(S.of(context).date_of_birth),
                            const SizedBox(height: 5),
                            Text(
                              // Gabungkan data tanggal, bulan, dan tahun
                              '${profile.dateOfBirth}, ${DateFormat('MMMM yyyy', 'en_US').format(DateTime(
                                int.parse(profile.yearDate), // Tahun
                                int.parse(profile.monthDate), // Bulan (dimulai dari 0)
                                int.parse(profile.dateOfBirth), // Tanggal
                              ))}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(S.of(context).age),
                            const SizedBox(height: 5),
                            Text('${profile.age ?? '-'} Tahun',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600)),
                            const SizedBox(height: 20),
                            Text(S.of(context).residence),
                            const SizedBox(height: 5),
                            Text(profile.residence ?? '-',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600)),
                            const SizedBox(height: 20),
                            Text(S.of(context).blood_group),
                            const SizedBox(height: 5),
                            Text(profile.bloodType ?? '-',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(S.of(context).total+" :"),
                  value.isLoadingPriceProfiling ? CircularProgressIndicator() : Text(
                  value.priceProfiling?.data != null
                  ? 'Rp ${NumberFormat("#,##0", "id_ID").format(value.priceProfiling!.data)}'
                      : '',
                  )
                ],
              ),
              if (widget.coderef?.isNotEmpty ?? false)
                CustomInputField(
                  isReadOnly: true,
                  title: S.of(context).referral_code_optional,
                  textEditingController: TextEditingController(
                    text: widget.coderef ?? '',
                  ),
                ),
              gapH10,
              SizedBox(
                height: 54,
                child: isLoading
                    ? const CircularProgressWidget()
                    : ButtonPrimary(S.of(context).save,
                        expand: true,
                        radius: 10,
                        elevation: 0.0, onPress: () async {
                        bool invalidAge = false;
                        if(widget.route == 'register') {
                          List<Map<String, dynamic>> formData = [];
                          for (int i = 0;
                          i < allProfiles.length;
                          i++) {
                            Map<String, dynamic> formDataItem = {
                              'name': allProfiles[i].name,
                              'birth_date': allProfiles[i]
                                  .dateOfBirth
                                  .toString(),
                              'month_date': allProfiles[i]
                                  .monthDate
                                  .toString(),
                              'year_date': allProfiles[i]
                                  .yearDate
                                  .toString(),
                              'blood_type':
                              allProfiles[i].bloodType == "-"
                                  ? ""
                                  : allProfiles[i].bloodType ??
                                  "",
                              'domicile': allProfiles[i].residence,
                              "ref_code": widget.coderef,
                            };

                            formData.add(formDataItem);
                          }
                          await value.createMultipleProfiling(
                            context, formData, );

                          if(value.multipleProfilingResult!.success == true){
                            int qty = value.qty;
                            List<int> idLogs = value.parsedIdLogs;
                            await value.payProfiling(
                                context,
                                idLogs,
                                "0",
                                "transaction_type",
                                qty, onUpdate: () async {
                              await value
                                  .getListProfiling(context);
                            }, fromPage: "profiling");

                          }else{
                            NotificationUtils.showDialogError(context, () {
                              Nav.back();
                            },
                                widget: Text(
                                    value.multipleProfilingResult!.message ?? "-") );
                          }
                        } else{
                          if (!invalidAge) {
                            NotificationUtils.showSimpleDialog2(context,
                                S.of(context).yakinbayar + '${_getFormattedPrice()}',
                                textButton1: S.of(context).yes,
                                textButton2: S.of(context).no,
                                onPress1: value.isCreateMultipleProfiling
                                    ? () {}
                                    : () async {
                                  Nav.back();
                                  List<Map<String, dynamic>> formData = [];
                                  for (int i = 0;
                                  i < allProfiles.length;
                                  i++) {
                                    Map<String, dynamic> formDataItem = {
                                      'name': allProfiles[i].name,
                                      'birth_date': allProfiles[i]
                                          .dateOfBirth
                                          .toString(),
                                      'month_date': allProfiles[i]
                                          .monthDate
                                          .toString(),
                                      'year_date': allProfiles[i]
                                          .yearDate
                                          .toString(),
                                      'blood_type':
                                      allProfiles[i].bloodType == "-"
                                          ? ""
                                          : allProfiles[i].bloodType ??
                                          "",
                                      'domicile': allProfiles[i].residence,
                                      "ref_code": widget.coderef,
                                    };

                                    formData.add(formDataItem);
                                  }
                                  await value.createMultipleProfiling(
                                    context, formData, );
                                  if(value.multipleProfilingResult!.success == true){
                                    int qty = value.qty;
                                    List<int> idLogs = value.parsedIdLogs;
                                    await NotificationUtils
                                        .showSimpleDialog2(
                                        context,
                                        S
                                            .of(context)
                                            .pay_with_your_cool_balance,
                                        textButton1: S
                                            .of(context)
                                            .yes_continue,
                                        textButton2:
                                        S.of(context).other_pay,
                                        onPress2: () async {
                                          Nav.back();
                                          await value.payProfiling(
                                              context,
                                              idLogs,
                                              "0",
                                              "transaction_type",
                                              qty, onUpdate: () async {
                                            await value
                                                .getListProfiling(context);
                                          }, fromPage: "profiling");
                                        }, onPress1: () async {
                                      Nav.back();
                                      await value
                                          .createTransactionProfiling(
                                          context,
                                          DataCheckoutTransaction(
                                              idLogs: idLogs,
                                              discount: "0",
                                              idItemPayments: "1",
                                              qty: qty,
                                              gateway: "paypal"),
                                              () async {
                                            await value
                                                .getListProfiling(context);
                                          });
                                    },
                                        colorButon1: primaryColor,
                                        colorButton2: Colors.white);

                                  }else{
                                    NotificationUtils.showDialogError(context, () {
                                      Nav.back();
                                    },
                                        widget: Text(
                                            value.multipleProfilingResult!.message ?? "-") );
                                  }
                                  // onAdd: widget.onAdd
                                },
                                onPress2: value.isCreateMultipleProfiling
                                    ? () {}
                                    : () async {
                                  Nav.back();
                                });
                          }
                        }

                      }),
              )
              // // Row(
              // //   children: [
              // //     Text('Jumlah :'),
              // //     Spacer(),
              // //     Text("Rp. 200.000")
              // //   ],
              // // ),
              // gapH10,
              // GlobalButton(onPressed: () {}, color: primaryColor, text: S.of(context).pay),
              // GlobalButton(onPressed: () {}, color: Colors.white, text: S.of(context).add_profile, textStyle: TextStyle(color: primaryColor)),
            ],
          ),
        ),
      );
    });
  }
}

class DeleteWarningPop extends StatelessWidget {
  final VoidCallback onDelete;

  const DeleteWarningPop({super.key, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(S.of(context).data_deletion_warning),
            gapH32,
            GlobalButton(
              onPressed: () {
                onDelete(); // 🔥 Panggil fungsi hapus
                Navigator.pop(context); // Tutup popup
              },
              color: primaryColor,
              text: S.of(context).yes_delete,
            ),
            gapH10,
            GlobalButton(
              onPressed: () {
                Navigator.pop(context);
              },
              color: Colors.white,
              text: S.of(context).no_dont,
              textStyle: TextStyle(color: primaryColor),
            )
          ],
        ),
      ),
    );
  }
}

class Editpop extends StatefulWidget {
  final ProfilData profile;
  final ValueChanged<ProfilData> onSave;

  const Editpop({super.key, required this.profile, required this.onSave});

  @override
  State<Editpop> createState() => _EditpopState();
}

class _EditpopState extends State<Editpop> {
  final TextEditingController controllersName = TextEditingController();
  final TextEditingController controllersDateOfBirth = TextEditingController();
  final TextEditingController controllersAge = TextEditingController();
  final TextEditingController controllersResidence = TextEditingController();

  DateTime? selectedDate;
  String? selectedBloodType;

  @override
  void initState() {
    cekSession();
    super.initState();
    controllersName.text = widget.profile.name ?? '';
    controllersDateOfBirth.text = widget.profile.dateOfBirth ?? '';
    controllersAge.text = widget.profile.age?.toString() ?? '';
    controllersResidence.text = widget.profile.residence ?? '';
    selectedBloodType = widget.profile.bloodType;


    String formattedDate = '';
    if (widget.profile.dateOfBirth != null &&
        widget.profile.monthDate != null &&
        widget.profile.yearDate != null) {
      formattedDate = DateFormat('dd, MMMM yyyy', 'en_US').format(
        DateTime(
          int.parse(widget.profile.yearDate!), // Tahun
          int.parse(widget.profile.monthDate!), // Bulan (dimulai dari 0)
          int.parse(widget.profile.dateOfBirth!), // Tanggal
        ),
      );
    }

    setState(() {
      controllersDateOfBirth.text = formattedDate;
    });
  }





  @override
  void dispose() {
    controllersName.dispose();
    controllersDateOfBirth.dispose();
    controllersAge.dispose();
    controllersResidence.dispose();
    super.dispose();
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
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                  color: Colors.grey,
                  onPressed: () {
                    Nav.back();
                  },
                  icon: Icon(CupertinoIcons.xmark)),
              gapH10,
              CustomInputField(
                title: S.of(context).name,
                textEditingController: controllersName,
                validator: (val) =>
                    val!.isEmpty ? S.of(context).cannot_be_empty : null,
              ),
              const SizedBox(height: 8.0),
              CustomInputField(
                title: S.of(context).date_of_birth,
                textEditingController: controllersDateOfBirth,
                isReadOnly: true,
                suffixIcon: const Icon(Icons.calendar_month_outlined),
                validator: (val) => val!.isEmpty ? S.of(context).cannot_be_empty : null,
                onTap: () async {
                  var res = await DateUtil.pickDate(context);
                  if (res != null) {
                    setState(() {
                      // Format hasil dari picker date ke dalam format "dd, MMMM yyyy"
                      controllersDateOfBirth.text =
                          DateFormat("dd, MMMM yyyy", "en_US").format(res);
                      selectedDate = res;

                      // Menghitung usia berdasarkan tanggal yang dipilih
                      DateTime currentDate = DateTime.now();
                      int age = currentDate.year - res.year;

                      // Menyesuaikan jika tanggal lahir belum terjadi tahun ini
                      if (currentDate.month < res.month ||
                          (currentDate.month == res.month && currentDate.day < res.day)) {
                        age--;
                      }

                      // Set umur ke TextEditingController untuk usia
                      controllersAge.text = age.toString();
                    });
                  }
                },
              ),


              const SizedBox(height: 8.0),
              CustomInputField(
                title: S.of(context).age,
                textEditingController: controllersAge,
                isReadOnly: true,
              ),
              const SizedBox(height: 8.0),
              CustomInputField(
                title: S.of(context).residence,
                textEditingController: controllersResidence,
                validator: (val) =>
                    val!.isEmpty ? S.of(context).cannot_be_empty : null,
              ),
              const SizedBox(height: 8.0),
              Text(S.of(context).blood_type,
                  style: const TextStyle(fontSize: 14)),
              const SizedBox(height: 8),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1, color: greyColor),
                ),
                child: DropdownButton<String>(
                  value: selectedBloodType,
                  hint: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(S.of(context).choose),
                  ),
                  underline: Container(),
                  isExpanded: true,
                  items: [
                    if (controllersAge.text.isEmpty ||
                        (int.tryParse(controllersAge.text) ?? 0) < 17)
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
                        child: Text(e),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedBloodType = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
              GlobalButton(
                onPressed: () {
                  DateTime selectedDate = DateFormat("dd, MMMM yyyy", "en_US").parse(controllersDateOfBirth.text);
                  final updatedProfile = ProfilData(
                    name: controllersName.text,
                    dateOfBirth: selectedDate.day.toString(),
                    age: controllersAge.text.isNotEmpty ? controllersAge.text : "0",
                    residence: controllersResidence.text,
                    bloodType: selectedBloodType ?? "",
                    monthDate: selectedDate.month.toString(),
                    yearDate: selectedDate.year.toString(),
                  );
                  widget.onSave(updatedProfile);
                  Navigator.pop(context);
                },
                color: primaryColor,
                text: S.of(context).save,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
