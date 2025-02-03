import 'package:flutter/material.dart';

class GlobalButton extends StatelessWidget {
  final VoidCallback? onPressed; // Fungsi yang dipanggil saat tombol ditekan
  final Color color; // Warna tombol
  final String text; // Teks pada tombol
  final TextStyle? textStyle; // Gaya teks, opsional

  const GlobalButton({
    super.key,
    required this.onPressed,
    required this.color,
    required this.text,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      minWidth: double.infinity, // Tombol selebar layar
      color: color, // Warna tombol
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Sudut lekukan tombol
      ),
      height: 50, // Tinggi tombol
      disabledColor: Colors.grey.shade300, // Warna saat tombol dinonaktifkan
      child: Text(
        text,
        style: textStyle ??
            TextStyle(
              color: onPressed == null
                  ? Colors.grey.shade600
                  : Colors.white, // Warna teks sesuai status
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }
}
