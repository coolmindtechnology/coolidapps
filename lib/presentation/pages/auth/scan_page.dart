import 'dart:convert';

import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

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
      body: MobileScanner(
        // fit: BoxFit.contain,
        controller: scannerController,
        onDetect: (capture) async {
          //auto nav back bawa hasil dari qr code

          if (capture.barcodes.first.rawValue == null) {
            debugPrint("Failed to scan Barcode");
          } else {
            final String code = capture.barcodes.first.rawValue!;
            String decode = jsonDecode(code)['referral_code'];

            Nav.back(data: decode);
            await scannerController.stop();
          }
        },
      ),
    );
  }
}
