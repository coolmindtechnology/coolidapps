import 'package:flutter/material.dart';
import 'package:coolappflutter/presentation/pages/user/Setting/Report/Report_Page.dart';

class CustomFAB extends StatefulWidget {
  const CustomFAB({super.key});

  @override
  _CustomFABState createState() => _CustomFABState();
}

class _CustomFABState extends State<CustomFAB> {
  // Posisi awal FAB di kanan bawah
  double _posX = 16;
  double _posY = 80; // Sesuaikan dengan BottomNavigationBar

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          right: _posX, // Gunakan right agar posisi default tetap
          bottom: _posY,
          child: GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                // Update posisi berdasarkan geseran user
                _posX -= details.delta.dx;
                _posY -= details.delta.dy;
              });
            },
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReportPage()),
                );
              },
              backgroundColor: Colors.white,
              child: Image.asset('images/konsultasi/mark.png'),
              shape: const CircleBorder(),
            ),
          ),
        ),
      ],
    );
  }
}
