import 'package:flutter/material.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';

class SaldoWidget extends StatelessWidget {
  final String saldo;
  final String title;
  final String subtitle;
  final double? sizeImage;
  final TextStyle? titleStyle;
  final TextStyle? saldoStyle;
  final Color backgroundColor;
  final String assetImage;
  final VoidCallback onTap;

  const SaldoWidget({
    super.key,
    required this.title,
    required this.subtitle,
    this.sizeImage,
    this.titleStyle,
    this.saldoStyle,
    required this.saldo,
    required this.backgroundColor,
    required this.assetImage,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: titleStyle ??
                        const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    saldo,
                    style: saldoStyle ??
                        const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                  ),
                ],
              ),
            ),
            Positioned.fill(
              left: 290,
              top: 10,
              bottom: 0,
              right: 0,
              child: FractionallySizedBox(
                alignment: Alignment.center,
                widthFactor: sizeImage ?? 0.9,
                heightFactor: sizeImage ?? 0.9,
                child: Image.asset(
                  assetImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 25,
              right: 15,
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      subtitle,
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
