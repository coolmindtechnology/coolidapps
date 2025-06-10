import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/on_boarding/onboarding_golda.dart';
import 'package:coolappflutter/presentation/pages/main/nav_home.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/date_util.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/widgets/custom_input_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/GlobalButton.dart';

class OnboardingBirthday extends StatefulWidget {
  const OnboardingBirthday({super.key});

  @override
  State<OnboardingBirthday> createState() => _OnboardingBirthdayState();
}

class _OnboardingBirthdayState extends State<OnboardingBirthday> {
  final TextEditingController controllerDateOfBirth = TextEditingController();
  final TextEditingController controllerAge = TextEditingController();
  DateTime? selectedDate;

  @override
  void dispose() {
    controllerDateOfBirth.dispose();
    controllerAge.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      child: Image.asset('images/OnBoardingBirthday.png'),
                    ),
                  ),
                ),
                Text(
                  S.of(context).isiTanggalLahir,
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
                CustomInputField(
                  textEditingController: controllerDateOfBirth,
                  isReadOnly: true,
                  hintText: S.of(context).date_of_birth,
                  suffixIcon:  Icon(Icons.calendar_month_outlined,),
                  validator: (val) => val!.isEmpty ? S.of(context).cannot_be_empty : null,
                  onTap: () async {
                    final res = await DateUtil.pickDate(context);
                    if (res != null) {
                      setState(() {
                        selectedDate = res;
                        controllerDateOfBirth.text =
                            DateFormat("dd, MMMM yyyy", "en_US").format(res);

                        final now = DateTime.now();
                        int age = now.year - res.year;
                        if (now.month < res.month || (now.month == res.month && now.day < res.day)) {
                          age--;
                        }

                        controllerAge.text = age.toString();
                      });
                    }
                  },
                ),
                Spacer(),
                GlobalButton(
                  onPressed: () async {
                    await Nav.to(OnboardingGolda(
                      controllerDateOfBirth: controllerDateOfBirth,
                      controllerAge: controllerAge,
                    ));
                  },
                  color: primaryColor,
                  text: S.of(context).next,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

