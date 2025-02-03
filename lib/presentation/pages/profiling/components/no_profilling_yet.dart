import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:flutter/material.dart';

class NoProfiling extends StatelessWidget {
  const NoProfiling({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: BlueColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Positioned(right: 10, child: Image.asset('images/ProfilingIcon.png')),
          ListTile(
            title: Text(
              S.of(context).no_profiling_yet,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              S.of(context).Fill_in_your_profile,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
