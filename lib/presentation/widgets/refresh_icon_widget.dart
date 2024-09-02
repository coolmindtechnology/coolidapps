import 'package:cool_app/presentation/theme/color_utils.dart';
import 'package:flutter/material.dart';

class RefreshIconWidget extends StatelessWidget {
  const RefreshIconWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.refresh_rounded,
      color: primaryColor,
      size: 30,
    );
  }
}
