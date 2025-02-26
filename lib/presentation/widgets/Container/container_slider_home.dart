import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:flutter/material.dart';

/// Class untuk container slider home
class ContainerSliderHome extends StatelessWidget {
  final String text;
  final String imageUrl;
  final Color? containerColor;
  final Color? textColor;
  final double? textSize;
  final double? ContainerSize;

  const ContainerSliderHome({
    Key? key,
    required this.text,
    required this.imageUrl,
    this.containerColor, // Opsional warna latar container
    this.textColor,
    this.textSize,
    this.ContainerSize// Opsional warna teks
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Lebar container penuh
      height: ContainerSize ?? 120, // Tinggi container
      decoration: BoxDecoration(
        color: containerColor ?? primaryColor, // Warna default atau opsional
        borderRadius: BorderRadius.circular(15), // Sudut container dibulatkan
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Text di sebelah kiri
          Expanded(
            flex: 2, // Atur proporsi teks
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                text,
                style: TextStyle(
                  color: textColor ?? BlueColor, // Warna teks default atau opsional
                  fontSize: textSize ?? 20,
                  fontWeight: FontWeight.bold,
                ),
                overflow : TextOverflow.ellipsis,
                maxLines: 5,
              ),
            ),
          ),
          // Gambar di sebelah kanan
          Expanded(
            flex: 2, // Atur proporsi gambar
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20), // Menyesuaikan sudut gambar
              child: Image.asset(
                imageUrl,  // URL gambar
                fit: BoxFit.cover,  // Agar gambar memenuhi ruang
                height: 150,  // Menyesuaikan tinggi gambar dengan container/ Menyesuaikan tinggi gambar dengan container
              ),
            ),
          ),
        ],
      ),
    );
  }
}
