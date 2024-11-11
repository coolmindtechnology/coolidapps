import 'dart:io';

import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/widgets/button_primary.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class UpdateAppPage extends StatefulWidget {
  const UpdateAppPage({super.key, required this.versionApp});
  final String versionApp;

  @override
  State<UpdateAppPage> createState() => _UpdateAppPageState();
}

class _UpdateAppPageState extends State<UpdateAppPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              S.of(context).update_available,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              S.of(context).the_latest_version_off_the_app_is_available,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: greyColor,
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              height: 54,
              child: ButtonPrimary(
                S.of(context).update_app,
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                elevation: 0.0,
                radius: 10,
                onPress: () {
                  launchUrlString(
                      "https://play.google.com/store/apps/details?id=mycool.tech.com&pli=1");
                },
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                exit(0);
              },
              child: Text(
                S.of(context).not_now_thankyou,
                style: TextStyle(
                  fontSize: 16,
                  color: primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
