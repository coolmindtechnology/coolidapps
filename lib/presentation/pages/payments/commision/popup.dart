import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/widgets/GlobalButton.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:flutter/material.dart';


class PopupCommision extends StatefulWidget {
  const PopupCommision({super.key});

  @override
  _PopupCommisionState createState() => _PopupCommisionState();
}

class _PopupCommisionState extends State<PopupCommision> {
  final PageController _pageController = PageController();

  List<Map<String, dynamic>> promoContent = [];
  // Daftar konten promo dengan onPressed2 yang dapat disesuaikan

  Future<void> _setPopStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isCommisionpop', true); // Menandakan promo sudah ditampilkan
  }

  void _goToNextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );

    _setPopStatus();
  }

  void _goBackPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    promoContent = [
      {
        'title': 'Share Your Promotion Code', // Menggunakan context di sini
        'imageUrl': 'images/qrc.png',
        'subtitle': 'Share your code to your friends, family, brother, childhood friends, or someone you know',
        'imageUrl2': 'images/promo/Frame1.png',
      },
      {
        'title': 'Invite Them!',
        'imageUrl': 'images/ic_community.png',
        'subtitle': 'Invite them to create account and do a profiling trough your link or input your code',
        'imageUrl2': 'images/promo/Frame2.png',
      },
      {
        'title': 'Get Your Commission!',
        'imageUrl': 'images/moneyc.png',
        'subtitle': 'Get commissions directly related to the amount of profiling they complete.',
        'imageUrl2': 'images/promo/Frame2.png',
      },
    ];

    return SizedBox(
      height: 400, // Adjust the height as needed for better view
      child: PageView.builder(
        controller: _pageController,
        itemCount: promoContent.length,
        itemBuilder: (context, index) {
          final item = promoContent[index];
          return ContainerPop(
            title: item['title'],
            imageUrl: item['imageUrl'],
            subtitle: item['subtitle'],
            imageUrl2: item['imageUrl2'],
            onPressed1: () {
              _goBackPage();
            },
            onPressed2: index == 2
                ? () {
              Navigator.pop(context);
            }
                : () {
              _goToNextPage();
            },
          );
        },
      ),
    );
  }
}


class ContainerPop extends StatelessWidget {
  final String? title;
  final String? imageUrl;
  final String? subtitle;
  final String? subtitle2; // Subtitle opsional
  final String? textpress2; // Subtitle opsional
  final String? imageUrl2; // Gambar kedua opsional
  final VoidCallback? onPressed1; // Tombol pertama opsional
  final VoidCallback? onPressed2; // Tombol kedua opsional

  const ContainerPop({
    super.key,
    this.title, // Judul
    this.imageUrl, // Gambar pertama
    this.subtitle, // Subtitle
    this.subtitle2, // Subtitle2 opsional
    this.textpress2, // Subtitle2 opsional
    this.imageUrl2, // Gambar kedua opsional
    this.onPressed1, // Tombol pertama opsional
    this.onPressed2, // Tombol kedua opsional
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            // Menampilkan judul
            SizedBox(height: 20),
            Text(
              title ?? '',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis,
              maxLines: 4,
              textAlign: TextAlign.center,
            ),
            // Menampilkan gambar pertama
            SizedBox(height: 20),
            if (imageUrl != null && imageUrl!.isNotEmpty) ...[
              SizedBox(height: 20),
              Image.asset(
                imageUrl!,
                height: 80, // Menambahkan batasan ukuran gambar
                fit: BoxFit
                    .cover, // Memastikan gambar menyesuaikan dengan ukuran
              ),
            ],
            SizedBox(height: 20),
            // Menampilkan subtitle
            Text(
              subtitle ?? '',
              style: TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
            // Menampilkan subtitle2 jika diisi
            if (subtitle2 != null && subtitle2!.isNotEmpty) ...[
              SizedBox(height: 10),
              Text(
                subtitle2!,
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            ],
            // Menampilkan gambar kedua jika ada
            if (imageUrl2 != null && imageUrl2!.isNotEmpty) ...[
              SizedBox(height: 20),
              Image.asset(
                imageUrl2!,
                fit: BoxFit
                    .cover, // Memastikan gambar menyesuaikan dengan ukuran
              ),
            ],
            // Menampilkan tombol jika ada salah satu yang disediakan
            if (onPressed1 != null || onPressed2 != null) ...[
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceBetween, // Tombol berada di ujung kiri dan kanan
                  crossAxisAlignment:
                  CrossAxisAlignment.center, // Vertikal tengah
                  children: [
                    if (onPressed1 !=
                        null) // Tombol pertama hanya ditampilkan jika onPressed1 ada
                      Expanded(
                        child: GlobalButton(
                          onPressed: onPressed1 ??
                                  () {
                                Nav.back();
                              }, // Gantikan dengan fungsi kosong jika null
                          color: Colors.white,
                          text: S.of(context).back,
                          textStyle: TextStyle(color: primaryColor),
                        ),
                      ),
                    if (onPressed1 != null && onPressed2 != null)
                      SizedBox(width: 10), // Jarak antar tombol
                    if (onPressed2 !=
                        null) // Tombol kedua hanya ditampilkan jika onPressed2 ada
                      Expanded(
                        child: GlobalButton(
                          onPressed: onPressed2 ??
                                  () {}, // Gantikan dengan fungsi kosong jika null
                          color: primaryColor,
                          text: textpress2 ?? S.of(context).next,
                          textStyle: TextStyle(color: Colors.white),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
