import 'dart:async';
import 'dart:convert';
import 'package:coolappflutter/data/locals/preference_handler.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../../data/locals/shared_pref.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  MobileScannerController scannerController = MobileScannerController();

  @override
  void dispose() {
    scannerController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      cekSession();
    });
    cekSession();
    super.initState();
  }

  cekSession() async {
    dynamic ceklanguage = await PreferenceHandler.retrieveISelectLanguage();
    Prefs().setLocale('$ceklanguage', () {
      setState(() {
        S.load(Locale('$ceklanguage'));
      });
    });

    Timer(const Duration(seconds: 2), () {
      Prefs().getLocale().then((locale) {
        debugPrint(locale);
        S.load(Locale(locale));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).scan_qr_code,
          style: TextStyle(color: whiteColor),
        ),
        iconTheme: IconThemeData(color: whiteColor),
        backgroundColor: primaryColor,
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: scannerController,
              onDetect: (capture) async {
                if (capture.barcodes.first.rawValue == null) {
                  debugPrint("Failed to scan Barcode");
                } else {
                  final String code = capture.barcodes.first.rawValue!;

                  try {
                    // Coba decode sebagai JSON jika string dimulai dengan '{'
                    if (code.trim().startsWith('{')) {
                      String referralCode = jsonDecode(code)['referral_code'];
                      Nav.back(data: referralCode);
                    } else {
                      // Kalau bukan JSON, anggap itu URL
                      Uri uri = Uri.parse(code);
                      String? referralCode = uri.queryParameters['ref'];
                      if (referralCode != null) {
                        Nav.back(data: referralCode);
                      } else {
                        debugPrint("Referral code tidak ditemukan di dalam URL");
                      }
                    }

                    await scannerController.stop();
                  } catch (e) {
                    debugPrint("Terjadi error saat parsing QR: $e");
                  }
                }
              }


          ),
          Center(
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
                color: Colors.transparent,
              ),
            ),
          ),
          // Optional overlay hitam di sekeliling kotak
          IgnorePointer(
            child: Container(
              color: Colors.black.withOpacity(0.5),
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      width: 250,
                      height: 250,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Clear kotak tengah agar scanner tetap berfungsi
          Center(
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
