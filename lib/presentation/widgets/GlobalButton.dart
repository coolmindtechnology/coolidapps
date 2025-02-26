import 'package:flutter/material.dart';

class GlobalButton extends StatelessWidget {
  final VoidCallback? onPressed; // Fungsi saat tombol ditekan
  final Color color; // Warna tombol
  final String text; // Teks tombol
  final TextStyle? textStyle; // Gaya teks (opsional)
  final Widget? icon; // Ikon opsional di kiri teks

  const GlobalButton({
    super.key,
    required this.onPressed,
    required this.color,
    required this.text,
    this.textStyle,
    this.icon, // Tambahkan ikon opsional
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      minWidth: double.infinity,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      height: 50,
      disabledColor: Colors.grey.shade300,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, // Tengahkan isi tombol
        mainAxisSize: MainAxisSize.min, // Ukuran minimum agar tidak berlebihan
        children: [
          if (icon != null) ...[
            icon!, // Menampilkan ikon jika ada
            const SizedBox(width: 8), // Jarak antara ikon dan teks
          ],
          Text(
            text,
            style: textStyle ??
                TextStyle(
                  color: onPressed == null
                      ? Colors.grey.shade600
                      : Colors.white,
                  fontWeight: FontWeight.w500,
                ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
