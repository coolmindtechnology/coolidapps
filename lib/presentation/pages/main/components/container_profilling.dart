// global/container_profiling.dart

import 'package:flutter/material.dart';

class ContainerProfiling extends StatelessWidget {
  final Color backgroundColor; // Warna latar belakang
  final Color borderColor; // Warna garis tepi
  final Widget leading; // Icon di ListTile
  final String title; // Teks judul di ListTile
  final String subtitle; // Teks subtitle di ListTile

  const ContainerProfiling({
    super.key,
    required this.backgroundColor,
    required this.borderColor,
    required this.leading,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 80, // Tinggi container
        decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: 2), // Warna garis tepi
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0.8), // Warna atas sedikit putih
              backgroundColor, // Warna bawah sesuai dengan input
            ],
            begin: Alignment.topCenter, // Gradien dimulai dari atas
            end: Alignment.bottomCenter, // Gradien berakhir di bawah
          ), // Membulatkan sudut container
        ),
        child: Center(
          child: ListTile(
            contentPadding: const EdgeInsets.all(8.0), // Padding dalam ListTile
            leading: leading, // Widget di bagian kiri (icon atau gambar)
            title: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ), // Judul
            subtitle: Text(
              subtitle,
              style: const TextStyle(fontSize: 12),
            ), // Subtitle
          ),
        ),
      ),
    );
  }
}
