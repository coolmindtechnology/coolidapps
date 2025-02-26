import 'package:flutter/material.dart';

class ContainerProfiling extends StatelessWidget {
  final Color backgroundColor; // Warna latar belakang
  final Color borderColor; // Warna garis tepi
  final Color? textColor; // Warna teks
  final Widget? leading;
  final Widget? traling; // Icon di ListTile
  final String title; // Teks judul di ListTile
  final String? subtitle; // Teks subtitle di ListTile
  final bool useGradient; // Apakah menggunakan gradien atau tidak
  final VoidCallback? onTap; // Callback untuk onTap
  final double height; // Tinggi container (opsional, default 80)
  final bool isCenter; // Menentukan apakah konten akan dipusatkan atau tidak

  const ContainerProfiling({
    super.key,
    required this.backgroundColor,
    required this.borderColor,
    this.textColor,
    this.leading,
    this.traling,
    required this.title,
    this.subtitle,
    this.useGradient = true, // Default gradien aktif
    this.onTap, // Menambahkan opsi onTap
    this.height = 80, // Default tinggi container 80
    this.isCenter = false, // Default tidak dipusatkan
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap, // Menambahkan fungsi onTap
        child: Container(
          height: height, // Gunakan tinggi yang diberikan atau default 80
          decoration: BoxDecoration(
            border:
                Border.all(color: borderColor, width: 2), // Warna garis tepi
            borderRadius:
                BorderRadius.circular(8), // Membulatkan sudut container
            color: useGradient
                ? null
                : backgroundColor, // Warna dasar jika gradien tidak digunakan
            gradient: useGradient
                ? LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.8), // Warna atas sedikit putih
                      backgroundColor, // Warna bawah sesuai dengan input
                    ],
                    begin: Alignment.topCenter, // Gradien dimulai dari atas
                    end: Alignment.bottomCenter, // Gradien berakhir di bawah
                  )
                : null, // Jika gradien tidak digunakan, gunakan warna dasar
          ),
          child: Center(
            child: ListTile(
              contentPadding:
                  const EdgeInsets.all(8.0), // Padding dalam ListTile
              leading: isCenter
                  ? null
                  : leading, // Jika isCenter true, tidak tampilkan leading
              title: isCenter
                  ? Row(
                      // Menyusun leading dan title secara vertikal saat dipusatkan
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (leading != null)
                          leading!, // Tampilkan leading jika ada
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: textColor ?? Colors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    )
                  : Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: textColor ?? Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
              subtitle: subtitle != null
                  ? Text(
                      subtitle!,
                      style: const TextStyle(fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    )
                  : null,
              trailing: isCenter
                  ? null
                  : traling, // Jika isCenter true, tidak tampilkan trailing
            ),
          ),
        ),
      ),
    );
  }
}
