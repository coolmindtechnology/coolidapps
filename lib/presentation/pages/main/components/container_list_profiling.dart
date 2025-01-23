import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:flutter/material.dart';

class ListProfilingContainer extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final VoidCallback? onTap;
  final Widget? leading;

  const ListProfilingContainer({
    super.key,
    this.title,
    this.subtitle,
    this.onTap,
    this.leading, // Menambahkan parameter leading
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: primaryColor, // Warna biru
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (leading != null) leading!, // Menampilkan leading jika ada
            if (title != null)
              Text(
                title!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            if (subtitle != null) const SizedBox(height: 10),
            if (subtitle != null)
              Text(
                subtitle!,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }
}
