// ignore_for_file: must_be_immutable

import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/widgets/button_primary.dart';
import 'package:coolappflutter/presentation/widgets/shimmer_loading.dart';
import 'package:flutter/material.dart';

class HeaderTopupWidget extends StatelessWidget {
  final String? title;
  final String? nominal;
  final Function()? onPress;
  final String? textButton;
  bool isLoading;
  HeaderTopupWidget({
    super.key,
    this.title,
    this.nominal,
    this.onPress,
    this.isLoading = false,
    this.textButton,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          border: Border.all(color: greyColor.withOpacity(0.2)),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title ?? ""),
              isLoading
                  ? const ShimmerLoadingWidget(
                      height: 20,
                      width: 100,
                    )
                  : Text(nominal ?? "")
            ],
          ),
          ButtonPrimary(
            textButton,
            onPress: onPress,
            elevation: 0.0,
            radius: 8.0,
            imageLeft: const Icon(
              Icons.add,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
