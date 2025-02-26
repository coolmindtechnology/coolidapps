import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  final VoidCallback onTap;

  const CustomButton({
    Key? key,
    required this.icon,
    required this.text,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(color: primaryColor, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 8),
            Text(text, style: TextStyle(color: color)),
          ],
        ),
      ),
    );
  }
}
