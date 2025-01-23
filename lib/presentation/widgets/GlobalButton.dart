import 'package:flutter/material.dart';

class GlobalButton extends StatelessWidget {
  final VoidCallback onPressed; // Fungsi yang dipanggil saat tombol ditekan
  final Color color; // Warna tombol
  final String text; // Teks pada tombol
  final TextStyle? textStyle; // Gaya teks, opsional

  const GlobalButton({
    Key? key,
    required this.onPressed,
    required this.color,
    required this.text,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      minWidth: double.infinity, // Selebar layar
      color: color, // Warna tombol
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Sudut lekuk
      ),
      height: 50, // Tinggi tombol
      child: Text(
        text,
        style: textStyle ?? TextStyle(color: Colors.white), // Default putih
      ),
    );
  }
}
