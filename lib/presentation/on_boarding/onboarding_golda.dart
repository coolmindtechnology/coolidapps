import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:coolappflutter/data/data_global.dart';
import 'package:coolappflutter/data/provider/provider_user.dart';
import 'package:coolappflutter/data/response/profiling/res_form.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/profiling/konfrimasi%20identitas.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/utils/notification_utils.dart';
import 'package:coolappflutter/presentation/widgets/GlobalButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme/color_utils.dart';
import 'onboarding_birthday.dart';

class OnboardingGolda extends StatefulWidget {
  final TextEditingController controllerDateOfBirth;
  final TextEditingController controllerAge;

  const OnboardingGolda({
    super.key,
    required this.controllerDateOfBirth,
    required this.controllerAge,
  });

  @override
  State<OnboardingGolda> createState() => _OnboardingGoldaState();
}

class _OnboardingGoldaState extends State<OnboardingGolda> {
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
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final providerUser = Provider.of<ProviderUser>(context, listen: false);
      providerUser.getUser(context);
    });

    // Inisialisasi hanya sekali dan semua sinkron (index 0)
    controllersName.add(TextEditingController(text: dataGlobal.dataUser?.name ?? ""));
    controllersDateOfBirth.add(widget.controllerDateOfBirth);
    controllersAge = [
      TextEditingController(text: widget.controllerAge.text)  // pakai text dari widget.controllerAge
    ];
    controllersResidence.add(TextEditingController(text: dataGlobal.dataUser?.address ?? "gagal"));
    controllersCodeRef.add(TextEditingController(text: ""));
    selectedBloodType.add(null);
    selectedDate.add(DateTime.now());
    formKeys.add(GlobalKey<FormState>());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   actions: [
      //     IconButton(onPressed: () {
      //       Nav.toAll(OnboardingBirthday());
      //     }, icon: Icon(Icons.catching_pokemon_outlined))
      //   ],
      // ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryColor, Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.center,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 50, right: 20, left: 20, bottom: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 40, left: 20, right: 20, top: 100),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset('images/OnBoardingGolda.png'),
                    ),
                  ),
                ),
                Text(
                  S.of(context).pilihGolonganDarah,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                gapH10,
                 Text(
                   S.of(context).selangkahLagi,
                  style: TextStyle(fontSize: 15),
                ),
                gapH20,
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color: greyColor),
                  ),
                  child: DropdownButton<String>(
                    value: selectedBloodType[0],
                    hint: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(S.of(context).choose),
                    ),
                    underline: Container(),
                    isExpanded: true,
                    items: [
                      if (controllersAge[0].text.isEmpty || (int.tryParse(controllersAge[0].text) ?? 0) < 17)
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
                        selectedBloodType[0] = val!;
                      });
                    },
                  ),
                ),
                const Spacer(),
                GlobalButton(
                  onPressed: () async {
                    final name = controllersName[0].text.trim();
                    final age = controllersAge[0].text.trim();
                    final residence = controllersResidence[0].text.trim();
                    final bloodType = selectedBloodType[0];

                    print('DEBUG - name: "$name"');
                    print('DEBUG - age: "$age"');
                    print('DEBUG - residence: "$residence"');
                    print('DEBUG - bloodType: "$bloodType"');

                    if (name.isEmpty || age.isEmpty || residence.isEmpty || bloodType == null || bloodType == "-") {
                      NotificationUtils.showSnackbar("Harap lengkapi semua data sebelum melanjutkan.");
                      return;
                    }

                    NotificationUtils.showSimpleDialog2(
                      context,
                      S.of(context).is_the_data_entered_correct,
                      textButton1: S.of(context).yes,
                      textButton2: S.of(context).no,
                      onPress1: () async {
                        Nav.back();

                        final profil = ProfilData(
                          name: name,
                          dateOfBirth: selectedDate[0].day.toString(),
                          age: age,
                          residence: residence,
                          bloodType: bloodType,
                          monthDate: selectedDate[0].month.toString(),
                          yearDate: selectedDate[0].year.toString(),
                        );

                        // Print data profil ke konsol untuk debug
                        print('==== DATA PROFIL ====');
                        print('Nama: ${profil.name}');
                        print('Tanggal Lahir: ${profil.dateOfBirth}');
                        print('Umur: ${profil.age}');
                        print('Tempat Tinggal: ${profil.residence}');
                        print('Golongan Darah: ${profil.bloodType}');
                        print('Bulan: ${profil.monthDate}');
                        print('Tahun: ${profil.yearDate}');
                        print('=====================');

                        // Kirim ke halaman konfirmasi
                        Nav.to(KonfirmasiIdentitiasPage(profiles: [profil], '',route: 'register',));
                      },
                      onPress2: () {
                        Nav.back();
                      },
                    );
                  },
                  color: primaryColor,
                  text: S.of(context).next,
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
