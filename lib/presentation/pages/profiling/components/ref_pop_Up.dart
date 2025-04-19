

import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:coolappflutter/presentation/pages/auth/scan_page.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/widgets/GlobalButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<String?> showCodeRefDialog(BuildContext context) async {
  String? coderef;
  return await showDialog<String>(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Promotion Code',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                gapH10,
                Text(
                  'Input your favorite user promotion code',
                  style: TextStyle(fontSize: 11),
                ),
              ],
            ),
            IconButton(
                onPressed: () {
                  Nav.back();
                },
                icon: Icon(
                  CupertinoIcons.xmark,
                  color: Colors.black,
                ))
          ],
        ),
        content: TextField(
          controller: TextEditingController(text: coderef), // supaya bisa di-set setelah scan
          onChanged: (value) {
            coderef = value;
          },
          decoration: InputDecoration(
            hintText: 'Masukkan Code Ref',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
            ),
            suffixIcon: GestureDetector(
              onTap: () async {
                var data = await Nav.to(const ScanPage());
                if (data != null) {
                  coderef = data; // update variabel
                  // kalau pakai TextEditingController, kamu bisa panggil controller.text = data
                }
              },
              child: const Icon(Icons.qr_code_scanner_rounded),
            ),
          ),
        ),

        actions: [
          GlobalButton(
              onPressed: () {
                // Jika tidak ingin menggunakan code ref, lanjutkan tanpa mengisi textfield
                Navigator.of(context).pop(null);
              },
              color: primaryColor,
              text: 'Lanjut tanpa Code Ref'),
          gapH10,
          GlobalButton(
            onPressed: () {
              // Pastikan textfield tidak kosong jika ingin melanjutkan dengan code ref
              if (coderef?.isEmpty ?? true) {
                // Tampilkan pesan kesalahan jika kosong
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Code Ref tidak boleh kosong')),
                );
              } else {
                // Jika textfield diisi, lanjutkan dengan code ref
                Navigator.of(context).pop(coderef);
              }
            },
            color: Colors.white,
            text: 'Lanjut dengan Code Ref',
            textStyle: TextStyle(color: primaryColor),
          )
        ],
      );
    },
  );
}