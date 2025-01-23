import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContainerYellowHome extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final IconData icon;
  final Color iconColor;

  const ContainerYellowHome({
    super.key,
    required this.onTap,
    required this.title,
    required this.icon,
    this.iconColor = Colors.blue, // Warna default untuk ikon
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFFFBF008),
            borderRadius: BorderRadius.circular(
                8), // Menggunakan .r untuk radius responsif
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                icon,
                size: 24.sp, // Menggunakan .sp untuk ukuran ikon responsif
                color: iconColor,
              ),
              Text(
                title,
                style: TextStyle(
                  color: iconColor,
                  fontSize:
                      10.sp, // Menggunakan .sp untuk ukuran teks responsif
                ),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
