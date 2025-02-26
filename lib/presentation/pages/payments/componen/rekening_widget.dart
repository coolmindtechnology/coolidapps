import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:flutter/material.dart';

class RekeningInfoWidget extends StatelessWidget {
  final String nama;
  final String tanggal;
  final String namaBank;
  final String nomorRekening;

  const RekeningInfoWidget({
    super.key,
    required this.nama,
    required this.tanggal,
    required this.namaBank,
    required this.nomorRekening,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 125,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: primaryColor)
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(nama, style: TextStyle(fontWeight: FontWeight.w600)),
                Text(tanggal),
              ],
            ),
            SizedBox(height: 10),
            Text(namaBank),
            SizedBox(height: 10),
            Text(nomorRekening),
          ],
        ),
      ),
    );
  }
}
