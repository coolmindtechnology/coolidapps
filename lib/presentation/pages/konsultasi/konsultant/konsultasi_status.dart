import 'package:coolappflutter/data/provider/provider_consultant.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/konsultant/boarding/boarding1.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/konsultant/experience_form.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/konsultant/experience_page.dart';
import 'package:coolappflutter/presentation/pages/main/nav_home.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/widgets/Container/Container_Promo.dart';
import 'package:coolappflutter/presentation/widgets/GlobalButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class KonsulatsiStatusPage extends StatefulWidget {
  final bool isRejected;

  const KonsulatsiStatusPage({super.key, required this.isRejected});

  @override
  State<KonsulatsiStatusPage> createState() => _KonsulatsiStatusPageState();
}

class _KonsulatsiStatusPageState extends State<KonsulatsiStatusPage> {
  late bool isRejected;

  @override
  void initState() {
    super.initState();
    isRejected = widget.isRejected;
    // Ambil data approval saat halaman pertama kali dimuat
    Provider.of<ConsultantProvider>(context, listen: false).getApprovalData(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).Consultation, style: TextStyle(color: Colors.white)),
      ),
      body: Consumer<ConsultantProvider>(
        builder: (context, consultantProvider, child) {
          if (consultantProvider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          // Debugging data
          print('Approval Data: ${consultantProvider.approvalData?.toJson()}');

          // Periksa jika data null atau kosong
          if (consultantProvider.approvalData == null ||
              consultantProvider.approvalData!.title == null ||
              consultantProvider.approvalData!.description == null) {
            return Center(child: Text('No valid data available'));
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Bagian jika status rejected
                  if (isRejected)
                    Container(
                      width: double.infinity,
                      color: LightRed,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  S.of(context).Rejected,
                                  style: TextStyle(
                                    color: Darkred,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Icon(
                                  CupertinoIcons.xmark_circle_fill,
                                  color: Darkred,
                                ),
                              ],
                            ),
                            GlobalButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15.0),
                                      ),
                                      child: SizedBox(
                                        height: 350,
                                        child: ContainerPromo(
                                          title: consultantProvider.approvalData!.approvalNote,
                                          subtitle2: '- Admin A',
                                          onPressed1: () {
                                            Navigator.pop(context);
                                          },
                                          onPressed2: () {
                                            Nav.to(ExperiencePage());
                                          },
                                          textpress2: S.of(context).Reapply,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              color: Darkred,
                              text: S.of(context).Why_Rejected,
                            )
                          ],
                        ),
                      ),
                    )
                  // Bagian jika status menunggu approval
                  else
                    Container(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  S.of(context).Waiting_Approval,
                                  style: TextStyle(
                                    color: BlueColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Icon(
                                  CupertinoIcons.time,
                                  color: primaryColor,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                  // Menampilkan ExperienceForm berdasarkan data dari ConsultantProvider
                  Column(
                    children: List.generate(
                      consultantProvider.approvalData!.title!.length, // Iterasi berdasarkan jumlah data title
                          (index) {
                        var title = consultantProvider.approvalData!.title![index];
                        var description = consultantProvider.approvalData!.description![index];
                        var document = consultantProvider.approvalData!.document?.isEmpty ?? true
                            ? null // Jika document kosong, set ke null
                            : consultantProvider.approvalData!.document![index];

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: ExperienceForm(
                            isEdit: false,
                            initialTitle: title,
                            initialDescription: description,
                            initialFileName: document ?? 'No document available', // Tampilkan pesan jika tidak ada dokumen
                            onDataChanged: (newTitle, newDescription, newFileName) {
                              print('Data updated for index $index: $newTitle, $newDescription, $newFileName');
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 40,),

                  // GlobalButton hanya ditampilkan jika status tidak rejected
                  if (!isRejected)
                    SizedBox(height: 30),
                  GlobalButton(
                    onPressed: () {
                      Nav.to(NavMenuScreen());
                    },
                    color: primaryColor,
                    text: S.of(context).back,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

