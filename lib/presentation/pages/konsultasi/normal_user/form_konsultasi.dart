import 'package:coolappflutter/generated/l10n.dart';

import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/widgets/GlobalButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../data/provider/provider_consultation.dart';
import 'card_consultant.dart';
import 'consultation_summary.dart';
import 'profile_card.dart';

import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/widgets/GlobalButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../data/provider/provider_consultation.dart';
import 'card_consultant.dart';
import 'consultation_summary.dart';
import 'profile_card.dart';

class FormConsultant extends StatefulWidget {
  const FormConsultant({
    super.key,
    required this.id,
    required this.getTime,
    required this.getTopik,
    required this.getSesi,
    required this.getThemeId,
  });
  final int id;
  final String getTime;
  final String getTopik;
  final String getSesi;
  final String getThemeId;

  @override
  State<FormConsultant> createState() => _FormConsultantState();
}

class _FormConsultantState extends State<FormConsultant> {
  @override
  void initState() {
    Provider.of<ProviderConsultation>(context, listen: false)
        .getDetailConsultant(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController inputDeskrip = TextEditingController();
    return Consumer<ProviderConsultation>(builder: (context, provider, _) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
          ),
          body: Padding(
            padding: const EdgeInsets.all(18),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).Your_Explanation,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: BlueColor,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  ProfileCard(
                      imagePath: provider.image,
                      name: provider.name,
                      title: provider.typebrain,
                      bloodType: provider.typeblood,
                      location: provider.address,
                      time: widget.getTime,
                      timeRemaining: widget.getSesi,
                      timeColor: BlueColor,
                      status: 'Pencapaian ',
                      warnastatus: Colors.white),
                  SizedBox(height: 16.0),
                  CardConsultant(
                    topic: S.of(context).Selected_topic,
                    topicSelected: widget.getTopik,
                    consultationTime: S.of(context).Consultation_time,
                    consultationTimeSelected: widget.getTime,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.3,
                    ),
                    child: TextField(
                      minLines: 5,
                      controller: inputDeskrip,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                          hintText: S.of(context).Why_Need_Consultant,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade300))),
                    ),
                  ),
                  SizedBox(height: 20),
                  GlobalButton(
                      onPressed: () {
                        Nav.to(SummaryConsultant(
                          consultId: widget.id.toString(),
                          themeId: widget.getThemeId,
                          partisipant: inputDeskrip.text,
                          typeSession: 'consultation',
                          time: widget.getTime,
                          imagePath: provider.image.toString(),
                          name: provider.name.toString(),
                          title: widget.getTopik,
                          bloodType: provider.typeblood.toString(),
                          location: provider.address.toString(),
                          getSesi: widget.getSesi,
                        ));
                      },
                      color: primaryColor,
                      text: S.of(context).next)
                ],
              ),
            ),
          ));
    });
  }
}
