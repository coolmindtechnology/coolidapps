import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:flutter/material.dart';

class StatusContainer extends StatelessWidget {
  final String dataRequest;

  // Konstruktor hanya menerima dataRequest
  StatusContainer({
    required this.dataRequest,
  });

  @override
  Widget build(BuildContext context) {
    // Menambahkan logika untuk mengganti warna berdasarkan dataRequest
    Color containerColor = LightBlue; // Default container color
    Color textColor = BlueColor; // Default text color

    // Jika dataRequest mengandung kata "curhat", ganti warna
    if (dataRequest.toLowerCase().contains("ditolak")) {
      containerColor = LightRed; // Light yellow
      textColor = Darkred; // Yellow text
    } else if (dataRequest.toLowerCase().contains("menunggu")) {
    containerColor = Colors.white; // Light yellow
    textColor = BlueColor; // Yellow text
    }

    return Container(
      width: double.infinity,
      height: 20,
      decoration: BoxDecoration(
        color: containerColor, // Gunakan warna yang sudah ditentukan berdasarkan dataRequest
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 10, left: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Keperluan",
              style: TextStyle(color: textColor, fontWeight: FontWeight.w500),
            ),
            Text(
              dataRequest, // Menampilkan data request yang diterima
              style: TextStyle(color: textColor, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
