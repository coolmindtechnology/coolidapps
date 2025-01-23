import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/Konsultasi_Page.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';

import 'package:flutter/material.dart';

import 'components/Container_Promo.dart';

class WarningPopup extends StatefulWidget {
  const WarningPopup({super.key});

  @override
  _WarningPopupState createState() => _WarningPopupState();
}

class _WarningPopupState extends State<WarningPopup> {
  final PageController _pageController = PageController();

  List<Map<String, dynamic>> promoContent = [];
  // Daftar konten promo dengan onPressed2 yang dapat disesuaikan

  void _goToNextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
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
        'title': S.of(context).Start_Session, // Menggunakan context di sini
        'subtitle': S.of(context).Cannot_Leave_Session,
      },
      {
        'title': S.of(context).CANNOT_LEAVE_SESSION,
        'subtitle': S.of(context).Complete_Session_First,
      },
    ];

    return SizedBox(
        height: 400, // Adjust the height as needed for better view
        child: Expanded(
          child: PageView.builder(
            controller: _pageController,
            itemCount: promoContent.length,
            itemBuilder: (context, index) {
              final item = promoContent[index];
              return ContainerPromo(
                title: item['title'],
                imageUrl: 'konsultasi/Danger.png',
                subtitle: item['subtitle'],
                onPressed1: () {
                  _goBackPage();
                },
                onPressed2: index == 2
                    ? () {
                        Nav.to(const KonsultasiPage());
                      }
                    : () {
                        _goToNextPage();
                      },
              );
            },
          ),
        ));
  }
}
