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
      "emotion_out": Colors.green,
      "emotion": Colors.green,
      "action_in": Colors.red,
      "action_out": Colors.red,
      "action": Colors.red,
      "creative_in": Colors.orange,
      "creative_out": Colors.orange,
      "creative": Colors.orange,
      "master": Colors.black,
      "logic_in": Colors.yellow,
      "logic_out": Colors.yellow,
      "logic": Colors.yellow,
    };

    // Tentukan warna berdasarkan typeBrain, default hitam jika tidak ditemukan
    Color borderColor = brainColors[typeBrain] ?? Colors.white;
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
            color: _getColorForText(typeBrain),
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

Color _getColorForText(String type) {
  switch (type) {
    case 'emotion_in':
    case 'emotion_out':
    case 'emotion':
      return Colors.green;
    case 'action_in':
    case 'action_out':
    case 'action':
      return Colors.red;
    case 'master':
      return Colors.black;
    case 'creative_in':
    case 'creative_out':
    case 'creative':
      return Colors.orange;
    case 'logic_in':
    case 'logic_out':
    case 'logic':
      return Colors.black;
    default:
      return Colors.white; // Warna default jika type tidak cocok
  }
}
