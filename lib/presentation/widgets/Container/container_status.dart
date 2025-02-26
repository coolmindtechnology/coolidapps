import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:flutter/material.dart';

class RequestContainer extends StatelessWidget {
  final String dataRequest;
  final String typeKeperluan; // Tambahkan parameter opsional

  const RequestContainer({
    super.key,
    required this.dataRequest,
    this.typeKeperluan = "Jenis keperluan", // Default value
  });

  @override
  Widget build(BuildContext context) {
    // Mapping warna berdasarkan kategori request
    final Map<String, Color> requestColors = {
      "curhat": Colors.yellow.shade100, // Background kuning muda
      "konsultasi": Colors.green.shade100, // Background hijau muda
      "darurat": Colors.red.shade100, // Background merah muda
    };

    final Map<String, Color> textColors = {
      "curhat": DarkYellow,
      "konsultasi": Colors.green.shade700,
      "darurat": Colors.red.shade700,
    };

    // Ambil warna dari Map berdasarkan `dataRequest`, jika tidak ada pakai default
    Color containerColor = requestColors.entries
        .firstWhere(
          (entry) => dataRequest.toLowerCase().contains(entry.key),
      orElse: () => MapEntry("", LightBlue),
    )
        .value;

    Color textColor = textColors.entries
        .firstWhere(
          (entry) => dataRequest.toLowerCase().contains(entry.key),
      orElse: () => MapEntry("", BlueColor),
    )
        .value;

    return Container(
      width: double.infinity,
      height: 20,
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              typeKeperluan, // Menggunakan parameter opsional
              style: TextStyle(color: textColor, fontWeight: FontWeight.w500),
            ),
            Text(
              dataRequest,
              style: TextStyle(color: textColor, fontWeight: FontWeight.w500),maxLines: 1,overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
