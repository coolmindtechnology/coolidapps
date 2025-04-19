import 'package:coolappflutter/data/provider/provider_consultant.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/konsultant/experience_page.dart';
import 'package:coolappflutter/presentation/pages/main/nav_home.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/widgets/GlobalButton.dart';
import 'package:coolappflutter/presentation/widgets/costum_floatingbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';

class TermaKonsultant extends StatefulWidget {
  final bool isCheck;
  const TermaKonsultant({super.key, required this.isCheck});

  @override
  State<TermaKonsultant> createState() => _TermaKonsultantState();
}

class _TermaKonsultantState extends State<TermaKonsultant> {
  bool isConfirmed = false;

  @override
  void initState() {
    super.initState();
    // Panggil API saat halaman dimuat
    Future.microtask(() {
      Provider.of<ConsultantProvider>(context, listen: false)
          .getTermsAndConditions(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Consumer<ConsultantProvider>(
          builder: (context, provider, child) {
            if (provider.isLoadingTerms) {
              // Tampilkan loading jika data sedang diambil
              return Center(child: CircularProgressIndicator());
            }

            final termsHtml = provider.terms?.data?.data; // Data HTML dari API
            if (termsHtml == null) {
              // Tampilkan pesan error jika data kosong
              return Center(child: Text("Failed to load Terms and Conditions"));
            }

            return Column(
              children: [
                const SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    child: Html(
                      data: termsHtml, // Render data HTML
                      style: {
                        "body": Style(
                          fontSize: FontSize(14),
                          textAlign: TextAlign.justify,
                        ),
                      },
                    ),
                  ),
                ),
                if (widget
                    .isCheck) // Hanya tampilkan checkbox jika isCheck true
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
                const SizedBox(height: 10),
                GlobalButton(
                  onPressed: widget.isCheck
                      ? (isConfirmed
                          ? () {
                              Nav.to(
                                  ExperiencePage()); // Navigasi ke halaman ExperiencePage
                            }
                          : null)
                      : () {
                          Nav.toAll(
                              NavMenuScreen()); // Navigasi ke NavMenuScreen jika isCheck false
                        },
                  color: widget.isCheck
                      ? (isConfirmed ? primaryColor : Colors.grey)
                      : primaryColor, // Warna tombol
                  text: widget.isCheck
                      ? S
                          .of(context)
                          .next // Teks tombol "Next" jika isCheck true
                      : S
                          .of(context)
                          .back, // Teks tombol "Back" jika isCheck false
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: const CustomFAB(),
    );
  }
}
