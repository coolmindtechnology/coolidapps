import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'home_affiliate.dart';

class TermsDialog extends StatelessWidget {
  final ApiService apiService = ApiService();
  final String token;

  TermsDialog({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: FutureBuilder<TermsAndConditions>(
        future: apiService.fetchTerms(token),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox(
              height: 150,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasError) {
            return SizedBox(
              height: 150,
              child: Center(
                child: Text('Error: ${snapshot.error}'),
              ),
            );
          } else if (snapshot.hasData) {
            final terms = snapshot.data!;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 16),
                    Html(
                      data: terms.data,
                      style: {
                        "body": Style(
                          fontSize: FontSize.large,
                          textAlign: TextAlign.justify, // Rata kiri-kanan
                          lineHeight:
                              const LineHeight(1.5), // Jarak antar baris
                          margin: Margins.all(0), // Hilangkan margin berlebih
                          padding:
                              HtmlPaddings.all(0), // Hilangkan padding berlebih
                        ),
                        "p": Style(
                          margin: Margins.only(
                              bottom: 8), // Jarak antar paragraf minimal
                        ),
                        "br": Style(
                          display: Display.none, // Hilangkan <br> tambahan
                        ),
                      },
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Tutup'),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const SizedBox(
              height: 150,
              child: Center(child: Text('Tidak ada data')),
            );
          }
        },
      ),
    );
  }
}
