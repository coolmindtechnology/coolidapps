import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/date_util.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/widgets/GlobalButton.dart';
import 'package:coolappflutter/presentation/widgets/custom_input_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class KonfirmasiIdentitiasPage extends StatefulWidget {
  const KonfirmasiIdentitiasPage({super.key});

  @override
  State<KonfirmasiIdentitiasPage> createState() => _KonfirmasiIdentitiasPageState();
}

class _KonfirmasiIdentitiasPageState extends State<KonfirmasiIdentitiasPage> {
  @override
  Widget build(BuildContext context) {
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
        padding: const EdgeInsets.only(top: 30,left: 20,right: 20,bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(S.of(context).your_profiling,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
            gapH10,
            Text(S.of(context).check_profiling_data,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400),),
            gapH20,
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color(0xFF93F1FB)
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
                                builder: (BuildContext context) {
                                  return Editpop();
                                },
                              );


                            },
                            child: Icon(Icons.note_alt_rounded,color: BlueColor,)),
                        gapW10,
                        InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: SizedBox(
                                        height: 230,
                                        child: DeleteWarningPop()),
                                  );
                                },
                              );


                            },
                            child: Icon(CupertinoIcons.trash_fill,color: BlueColor))
                      ],
                    ),
                    Text(S.of(context).name,style: TextStyle(),),
                    gapH10,
                    Text('Fadlan',style: TextStyle(fontWeight: FontWeight.w600),),
                    gapH20,
                    Text(S.of(context).date_of_birth),
                    gapH10,
                    Text('12 Januari 2001',style: TextStyle(fontWeight: FontWeight.w600),),
                    gapH20,
                    Text(S.of(context).age),
                    gapH10,
                    Text('12 Tahum',style: TextStyle(fontWeight: FontWeight.w600),),
                    gapH20,
                    Text(S.of(context).residence),
                    gapH10,
                    Text('Jakarta',style: TextStyle(fontWeight: FontWeight.w600),),
                    gapH20,
                    Text(S.of(context).blood_group),
                    gapH10,
                    Text('O',style: TextStyle(fontWeight: FontWeight.w600),),
                    gapH20,
                  ],
                ),
              ),
            ),
            Spacer(),
            Row(
              children: [
                Text('Jumblah :'),
                Spacer(),
                Text("Rp. 200.000")
              ],
            ),
            gapH10,
            GlobalButton(onPressed: () {

            }, color: primaryColor, text: S.of(context).pay) ,
            GlobalButton(onPressed: () {

            }, color: Colors.white, text: S.of(context).add_profile,textStyle: TextStyle(color: primaryColor),)

          ],
        ),
      ),
    );
  }
}

class DeleteWarningPop extends StatelessWidget {
  const DeleteWarningPop({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
           IconButton(
               color: Colors.grey,
               onPressed: () {
             Nav.back();
           }, icon: Icon(CupertinoIcons.xmark)),
            gapH10,
            Text(S.of(context).data_deletion_warning,),
            gapH10,
            GlobalButton(onPressed: () {

            }, color: primaryColor, text: S.of(context).yes_delete) ,
            GlobalButton(onPressed: () {
              Navigator.pop(context);
            }, color: Colors.white, text: S.of(context).no_dont,textStyle: TextStyle(color: primaryColor),)

          ],
        ),
      ),
    );
  }
}

class Editpop extends StatefulWidget {
  const Editpop({super.key});

  @override
  State<Editpop> createState() => _EditpopState();
}

class _EditpopState extends State<Editpop> {
  // Inisialisasi TextEditingController
  final TextEditingController controllersName = TextEditingController();
  final TextEditingController controllersDateOfBirth = TextEditingController();
  final TextEditingController controllersAge = TextEditingController();
  final TextEditingController controllersResidence = TextEditingController();

  DateTime? selectedDate;
  String? selectedBloodType;

  @override
  void dispose() {
    // Jangan lupa untuk dispose agar tidak terjadi memory leak
    controllersName.dispose();
    controllersDateOfBirth.dispose();
    controllersAge.dispose();
    controllersResidence.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Supaya tidak panjang ke bawah
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            IconButton(
                color: Colors.grey,
                onPressed: () {
              Nav.back();
            }, icon: Icon(CupertinoIcons.xmark)),
            gapH10,
            CustomInputField(
              title: S.of(context).name,
              textEditingController: controllersName,
              validator: (val) => val!.isEmpty
                  ? S.of(context).cannot_be_empty
                  : null,
            ),
            const SizedBox(height: 8.0),
            CustomInputField(
              title: S.of(context).date_of_birth,
              textEditingController: controllersDateOfBirth,
              isReadOnly: true,
              suffixIcon: const Icon(Icons.calendar_month_outlined),
              validator: (val) => val!.isEmpty
                  ? S.of(context).cannot_be_empty
                  : null,
              onTap: () async {
                var res = await DateUtil.pickDate(context);
                if (res != null) {
                  setState(() {
                    controllersDateOfBirth.text =
                        DateFormat("dd, MMMM yyyy", "en_US").format(res);
                    selectedDate = res;

                    DateTime currentDate = DateTime.now();
                    int age = currentDate.year - res.year;

                    if (currentDate.month < res.month ||
                        (currentDate.month == res.month && currentDate.day < res.day)) {
                      age--;
                    }
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
              validator: (val) => val!.isEmpty
                  ? S.of(context).cannot_be_empty
                  : null,
            ),
            const SizedBox(height: 8.0),
            Text(S.of(context).blood_type, style: const TextStyle(fontSize: 14)),
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
                  if (controllersAge.text.isEmpty || (int.tryParse(controllersAge.text) ?? 0) < 17)
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
                    selectedBloodType = val!;
                  });
                },
              ),
            ),
            gapH10,
            GlobalButton(
              onPressed: () {
                // Tambahkan logika penyimpanan di sini
              },
              color: primaryColor,
              text: S.of(context).save,
            ),
          ],
        ),
      ),
    );
  }
}

