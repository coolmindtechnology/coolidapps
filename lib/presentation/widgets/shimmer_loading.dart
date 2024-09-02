import 'package:cool_app/presentation/theme/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoadingWidget extends StatelessWidget {
  const ShimmerLoadingWidget(
      {super.key,
      required this.height,
      required this.width,
      this.borderRadius = 8.0});
  final double height;
  final double width;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: greyColor.withOpacity(0.2),
        highlightColor: whiteColor,
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: greyColor,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ));
  }
}
