

import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:coolappflutter/presentation/pages/auth/scan_page.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/widgets/GlobalButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';

Future<String?> showCodeRefDialog(BuildContext context) async {
  String? coderef;
  String? errorMessage; // Tambahkan untuk menyimpan pesan error
  TextEditingController controller = TextEditingController();

  return await showDialog<String>(
    context: context,
    builder: (context) {
      return StatefulBuilder( // Gunakan ini agar bisa update state di dalam dialog
        builder: (context, setState) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(S.of(context).kodepromosi, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                    gapH10,
                    Text(S.of(context).inputfavcode, style: TextStyle(fontSize: 11)),
                  ],
                ),
                Expanded(
                  child: IconButton(
                    onPressed: () => Nav.back(),
                    icon: Icon(CupertinoIcons.xmark, color: Colors.black),
                  ),
                )
              ],
            ),
            content: TextField(
              keyboardType: TextInputType.phone,
              controller: controller,
              onChanged: (value) {
                coderef = value;
                if (errorMessage != null) {
                  setState(() => errorMessage = null); // Reset error ketika user mengetik ulang
                }
              },
              decoration: InputDecoration(
                hintText: S.of(context).kodepromosi,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(13)),
                errorText: errorMessage, // Di sini kita tampilkan error
                suffixIcon: GestureDetector(
                  onTap: () async {
                    var data = await Nav.to(const ScanPage());
                    if (data != null) {
                      coderef = data;
                      controller.text = data; // Sinkronkan input
                      setState(() => errorMessage = null); // Reset error jika berhasil scan
                    }
                  },
                  child: const Icon(Icons.qr_code_scanner_rounded),
                ),
              ),
            ),
            actions: [
              GlobalButton(
                onPressed: () {
                  if (coderef?.isEmpty ?? true) {
                    setState(() {
                      errorMessage = S.of(context).cannot_be_empty; // Set error untuk tampil
                    });
                  } else {
                    Navigator.of(context).pop(coderef); // Lanjutkan dengan code ref
                  }
                },
                color: primaryColor,
                text: S.of(context).lanjutt,
              ),
              gapH10,
              GlobalButton(
                onPressed: () => Navigator.of(context).pop(null),
                color: Colors.white,
                text: S.of(context).lanjuttampa,
                textStyle: TextStyle(color: primaryColor),
              ),
            ],
          );
        },
      );
    },
  );
}
