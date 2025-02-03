import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContainerYellowHome extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final IconData icon;
  final Color iconColor;

  const ContainerYellowHome({
    Key? key,
    required this.onTap,
    required this.title,
    required this.icon,
    this.iconColor = Colors.blue, // Warna default untuk ikon
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          height: 40.h, // Responsif tinggi
          decoration: BoxDecoration(
            color: Color(0xFFFBF008),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                icon,
                size: 24.sp,
                color: iconColor,
              ),
              Flexible(
                child: Text(
                  title,
                  style: TextStyle(
                    color: iconColor,
                    fontSize: 10.sp,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
