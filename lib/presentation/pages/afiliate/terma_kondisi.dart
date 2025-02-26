import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:coolappflutter/data/provider/provider_consultant.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/afiliate/pop-up/next_pop.dart';
import 'package:coolappflutter/presentation/pages/afiliate/pop-up/warning_pop.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/konsultant/experience_page.dart';
import 'package:coolappflutter/presentation/pages/main/nav_home.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/widgets/GlobalButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';

class TermaAff extends StatefulWidget {
  const TermaAff({super.key});

  @override
  State<TermaAff> createState() => _TermaAffState();
}

class _TermaAffState extends State<TermaAff> {
  bool isConfirmed = false;
  bool isCheck = true;

  // @override
  // void initState() {
  //   super.initState();
  //   // Panggil API saat halaman dimuat
  //   Future.microtask(() {
  //     Provider.of<ConsultantProvider>(context, listen: false)
  //         .getTermsAndConditions(context);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Consumer<ConsultantProvider>(
          builder: (context, provider, child) {
            // if (provider.isLoadingTerms) {
            //   // Tampilkan loading jika data sedang diambil
            //   return Center(child: CircularProgressIndicator());
            // }
            //
            // final termsHtml = provider.terms?.data?.data; // Data HTML dari API
            // if (termsHtml == null) {
            //   // Tampilkan pesan error jika data kosong
            //   return Center(child: Text("Failed to load Terms and Conditions"));
            // }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                // Expanded(
                //   child: SingleChildScrollView(
                //     child: Html(
                //       data: termsHtml, // Render data HTML
                //       style: {
                //         "body": Style(
                //           fontSize: FontSize(14),
                //           textAlign: TextAlign.justify,
                //         ),
                //       },
                //     ),
                //   ),
                // ),
                // if (widget
                //     .isCheck) // Hanya tampilkan checkbox jika isCheck true
                 
                 Text('Terma & Syarat',style: TextStyle(fontWeight: FontWeight.w800,fontSize: 22),),
                 gapH20,
                 Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean venenatis finibus orci, id sollicitudin neque tincidunt quis. Cras ante lacus, venenatis et malesuada gravida, dapibus maximus neque. Quisque tempus pellentesque pretium. Integer luctus ullamcorper quam at dapibus. Vivamus faucibus velit eu accumsan faucibus. Pellentesque euismod blandit elementum. Integer tristique enim ligula, a mollis neque suscipit ut. S ,Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                     'Aenean venenatis finibus orci, id sollicitudin neque tincidunt quis. Cras ante lacus, venenatis et malesuada gravida, dapibus maximus neque. Quisque tempus pellentesque pretium. Integer luctus ullamcorper '
                     'quam at dapibus. Vivamus faucibus velit eu accumsan faucibus. Pellentesque euismod blandit elementum. Integer tristique enim ligula, a mollis neque suscipit ut. S',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 17),),
                Spacer(),
                Text(S.of(context).enterAgentCode,style: TextStyle(fontWeight: FontWeight.w600,color: primaryColor,fontSize: 18),),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: isConfirmed,
                        onChanged: (bool? value) {
                          setState(() {
                            isConfirmed = value ?? false;
                          });
                        },
                      ),
                      Expanded(
                        child: Text(
                          S.of(context).Information_Confirmed,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: const TextStyle(
                              fontSize: 14.0, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                gapH10,
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: greyColor),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                GlobalButton(
                  onPressed: () {
                      if (isConfirmed) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              child: NextPop(),
                            );
                          },
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              child: WarningPop(),
                            );
                          },
                        );
                      }
                    },
                  color: primaryColor,
                  text: isCheck ? S.of(context).next : S.of(context).back,
                ),
                // GlobalButton(
                //   onPressed: isCheck
                //       ? (isConfirmed
                //       ? () {
                //     Nav.to(
                //         ExperiencePage()); // Navigasi ke halaman ExperiencePage
                //   }
                //       : null)
                //       : () {
                //     Nav.toAll(
                //         NavMenuScreen()); // Navigasi ke NavMenuScreen jika isCheck false
                //   },
                //   color: isCheck
                //       ? (isConfirmed ? primaryColor : Colors.grey)
                //       : primaryColor, // Warna tombol
                //   text: isCheck
                //       ? S
                //       .of(context)
                //       .next // Teks tombol "Next" jika isCheck true
                //       : S
                //       .of(context)
                //       .back, // Teks tombol "Back" jika isCheck false
                // ),
              ],
            );
          },
        ),
      ),
    );
  }
}
