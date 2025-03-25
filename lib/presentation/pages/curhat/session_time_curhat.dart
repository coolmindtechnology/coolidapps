import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/curhat/choose_consultant_curhat.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/normal_user/choose_consultant.dart';

import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/widgets/GlobalButton.dart';
import 'package:coolappflutter/presentation/widgets/costum_floatingbutton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../data/provider/provider_consultation.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SessionTimeCurhat extends StatefulWidget {
  const SessionTimeCurhat(
      {super.key, required this.getTopik, required this.getId});
  final String getTopik;
  final String getId;

  @override
  State<SessionTimeCurhat> createState() => _SessionTimeState();
}

class _SessionTimeState extends State<SessionTimeCurhat> {
  String? selectedTimeSlot;
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderConsultation>(
      builder: (BuildContext context, valueConsultation, Widget? child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
          ),
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.lightBlueAccent.shade100,
                  Colors.white,
                ],
                begin: Alignment.topCenter,
                end: Alignment.center,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Colors.blue, width: 2.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).Choose_session_time,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: BlueColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          S.of(context).Choose_time_consult,
                          style:
                              TextStyle(fontSize: 14.0, color: Colors.black54),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 16.0),
                        GestureDetector(
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: selectedDate ?? DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2100),
                            );

                            if (pickedDate != null) {
                              setState(() {
                                selectedDate = pickedDate;
                                String dateString = selectedDate.toString();
                                valueConsultation.getListTime(
                                    context, dateString);
                              });
                            }
                          },
                          child: Row(
                            children: [
                              Icon(Icons.calendar_today, color: BlueColor),
                              SizedBox(width: 8.0),
                              Text(
                                selectedDate != null
                                    ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"
                                    : S.of(context).Pick_Date,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: BlueColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.0),

                  // Pilih waktu sesi
                  Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Colors.blue, width: 2.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).Choose_time_consult,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          S.of(context).Only_30_minutes,
                          overflow: TextOverflow.ellipsis,
                          style:
                              TextStyle(fontSize: 14.0, color: Colors.black54),
                        ),
                        SizedBox(height: 16.0),
                        Column(
                          children: valueConsultation.sessionData?.times.entries
                                  .map((entry) => _buildTimeSlot(entry.value))
                                  .toList() ??
                              [
                                Center(
                                  child: Text(
                                    S.of(context).no_data,
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 16.0),
                                  ),
                                ),
                              ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.0),

                  // Tombol untuk melanjutkan
                  GlobalButton(
                    onPressed: () {
                      if (selectedDate != null && selectedTimeSlot != null) {
                        Nav.to(ChooseConsultantCurhat(
                          getTopik: widget.getTopik,
                          getTime: selectedTimeSlot.toString(),
                          getIdTheme: widget.getId,
                        ));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(S.of(context).Choose_time_consult)),
                        );
                      }
                    },
                    color: primaryColor,
                    text: S.of(context).next,
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: const CustomFAB(),
        );
      },
    );
  }

  Widget _buildTimeSlot(String time) {
    final isSelected = selectedTimeSlot == time;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedTimeSlot = time;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue : Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: isSelected ? Colors.blue : primaryColor,
              width: 1.5,
            ),
          ),
          padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          child: Row(
            children: [
              Icon(
                Icons.access_time,
                color: isSelected ? Colors.white : primaryColor,
              ),
              SizedBox(width: 8.0),
              Text(
                time,
                style: TextStyle(
                  fontSize: 16.0,
                  color: isSelected ? Colors.white : primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
