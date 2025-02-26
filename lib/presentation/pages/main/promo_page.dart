import 'package:coolappflutter/generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:flutter/material.dart';

import '../../widgets/Container/container_promo.dart';

class PromoPopup extends StatefulWidget {
  const PromoPopup({super.key});

  @override
  _PromoPopupState createState() => _PromoPopupState();
}

class _PromoPopupState extends State<PromoPopup> {
  final PageController _pageController = PageController();

  List<Map<String, dynamic>> promoContent = [];
  // Daftar konten promo dengan onPressed2 yang dapat disesuaikan

  Future<void> _setPromoStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isPromoDisplayed', true); // Menandakan promo sudah ditampilkan
  }

  void _goToNextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );

    _setPromoStatus();
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
        'title': S.of(context).Know_deeper, // Menggunakan context di sini
        'imageUrl': 'promo/Brain_Emoji.png',
        'subtitle': S.of(context).Consult_based_personality,
        'imageUrl2': 'Frame1.png',
      },
      {
        'title': S.of(context).Free_3_times,
        'imageUrl': 'promo/free_emoji.png',
        'subtitle': S.of(context).Free_consult_3_days,
        'imageUrl2': 'Frame2.png',
      },
      {
        'title': S.of(context).Open_all_topics_now,
        'imageUrl': 'promo/un_lock.png',
        'subtitle': S.of(context).Open_all_topics,
        'imageUrl2': 'Frame3.png',
      },
    ];

    return SizedBox(
      height: 400, // Adjust the height as needed for better view
      child: PageView.builder(
        controller: _pageController,
        itemCount: promoContent.length,
        itemBuilder: (context, index) {
          final item = promoContent[index];
          return ContainerPromo(
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
