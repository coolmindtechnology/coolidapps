import 'package:flutter/material.dart';

class BrainTypeWidget extends StatelessWidget {
  final String typeBrain;

  const BrainTypeWidget({super.key, required this.typeBrain});

  @override
  Widget build(BuildContext context) {
    // Jika typeBrain adalah "N/A", kembalikan widget kosong (tidak ditampilkan)
    if (typeBrain == "null") return SizedBox.shrink();

    // Map warna berdasarkan typeBrain
    final Map<String, Color> brainColors = {
      "emotion_in": Colors.green,
      "action_in": Colors.red,
      "creative_in": Colors.orange,
      "master": Colors.black,
      "logic_in": Colors.yellow,
    };

    // Tentukan warna berdasarkan typeBrain, default hitam jika tidak ditemukan
    Color borderColor = brainColors[typeBrain] ?? Colors.black;
    Color textColor = borderColor;

    // Ubah format teks (replace "_" dengan spasi dan uppercase)
    String displayText = typeBrain.replaceAll("_", " ").toUpperCase();

    return Container(
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor, // Warna border
          width: 2, // Lebar border
        ),
        borderRadius: BorderRadius.circular(10), // Radius border
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          displayText,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
