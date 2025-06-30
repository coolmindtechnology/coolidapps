import 'package:flutter/material.dart';

class CardHomeKonsultant extends StatelessWidget {
  final String title; // Judul
  final String subtitle; // Subtitle
  final String imageAsset; // Gambar asset
  final Color containerColor; // Warna latar belakang container
  final Color? titleColor; // Warna teks judul (opsional)
  final Color? subtitleColor; // Warna teks subtitle (opsional)
  final VoidCallback? onTap; // Aksi ketika card ditekan (opsional)

  const CardHomeKonsultant({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.imageAsset,
    required this.containerColor,
    this.titleColor, // Warna teks judul opsional
    this.subtitleColor, // Warna teks subtitle opsional
    this.onTap, // Tambahkan aksi opsional
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap, // Gunakan parameter onTap
        child: Container(
          height: 80, // Tinggi container
          decoration: BoxDecoration(
            color: containerColor, // Warna latar belakang sesuai parameter
            borderRadius: BorderRadius.circular(8), // Membulatkan sudut
          ),
          child: Stack(
            children: [
              // Bagian untuk menampilkan title dan subtitle
              Positioned(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title, // Menampilkan title
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: titleColor ?? Colors.black, // Warna teks opsional
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 13),
                      Text(
                        subtitle, // Menampilkan subtitle
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: subtitleColor ?? Colors.black, // Warna teks opsional
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
              // Gambar yang diletakkan di sebelah kanan
              Positioned(
                left: 130,
                top: 20,
                bottom: 7,
                right: 7,
                child: FractionallySizedBox(
                  alignment: Alignment.center, // Menjaga gambar tetap di tengah
                  widthFactor: 1.3, // Membesar gambar 30% dari ukuran normal
                  heightFactor: 1.3, // Membesar gambar 30% dari ukuran normal
                  child: Image.asset(
                    imageAsset,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
