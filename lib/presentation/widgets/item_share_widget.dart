import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ItemShareWidget extends StatelessWidget {
  String? socialMedia;
  String? message;
  String? image;
  Function()? onShare;
  ItemShareWidget(
      {super.key, this.socialMedia, this.message, this.image, this.onShare});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onShare,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 32,
                child: Center(
                  child: Image.asset(
                    image ?? "",
                    width: 24,
                  ),
                ),
              ),
              Text(
                "$socialMedia",
                style: const TextStyle(fontSize: 10),
              )
            ],
          ),
        ));
  }
}
