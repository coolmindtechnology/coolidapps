import 'package:flutter/material.dart';

class SesiCrad extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;

  const SesiCrad({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 200,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          // Gradient overlay
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.5),
                ],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          // Content inside the container
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.bottomLeft, // Menempatkan teks di kiri bawah
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min, // Pastikan ukuran column hanya sesuai dengan kontennya
                children: [
                  // Title
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis, // Agar tidak melebihi space
                  ),
                  SizedBox(height: 5),
                  // Subtitle with wrapping text
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 10,
                    ),
                    overflow : TextOverflow.ellipsis,
                    maxLines: 2,
                    softWrap: true, // Membuat teks membungkus jika melebihi lebar
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
