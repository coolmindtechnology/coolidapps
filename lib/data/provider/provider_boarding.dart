import 'dart:async';

import 'package:cool_app/data/helpers/either.dart';
import 'package:cool_app/data/helpers/failure.dart';
import 'package:cool_app/data/networks/endpoint/api_endpoint.dart';
import 'package:cool_app/data/repositories/repo_boarding.dart';
import 'package:cool_app/data/response/boarding/res_get_version_app.dart';
import 'package:cool_app/data/response/boarding/res_on_boarding.dart';
import 'package:cool_app/data/response/boarding/res_splash_screen.dart';
import 'package:cool_app/generated/l10n.dart';
import 'package:cool_app/presentation/pages/main/update_app_page.dart';
import 'package:cool_app/presentation/utils/nav_utils.dart';
import 'package:cool_app/presentation/utils/notification_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

// import 'package:new_version_plus/new_version_plus.dart';

class ProviderBoarding extends ChangeNotifier {
  ProviderBoarding();

  Future<void> init(BuildContext context) async {
    // await getSplashLogo(context);

    await getSOnBoarding(context);
  }

  bool isLoading = false;
  RepoBoarding repoBoarding = RepoBoarding();
  String? logoUrl = "";
  String? onBoardingLogoUrl = "";
  String? onBoardingImageUrl = "";

  String? get urlLogo => "${ApiEndpoint.baseUrlImage}$logoUrl";
  String? get urlLogoOnBoarding =>
      "${ApiEndpoint.baseUrlImage}$onBoardingLogoUrl";
  String? get urlImageOnBoarding =>
      "${ApiEndpoint.baseUrlImage}$onBoardingImageUrl";
  DataOnBoarding? dataOnBoarding;

  bool disposed = false;

  @override
  void dispose() {
    disposed = true;
    super.dispose();
  }

  Future<void> getSplashLogo(BuildContext context) async {
    if (!disposed) {
      isLoading = true;
      notifyListeners();
    }

    Either<Failure, ResSplashScreen> response =
        await repoBoarding.getSplashLogo();

    if (!disposed) {
      isLoading = false;
      notifyListeners();
    }

    response.when(error: (e) {
      NotificationUtils.showDialogError(context, () {
        Nav.back();
      },
          widget: Text(
            e.message,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
          textButton: S.of(context).back);
    }, success: (success) async {
      logoUrl = success.logo;
    });

    if (!disposed) {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getSOnBoarding(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    Either<Failure, ResOnBoarding> response =
        await repoBoarding.getOnBoarding();

    isLoading = false;
    notifyListeners();

    response.when(error: (e) {
      NotificationUtils.showDialogError(context, () {
        Nav.back();
      },
          widget: Text(
            e.message,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
          textButton: S.of(context).back);
    }, success: (success) async {
      dataOnBoarding = success.data;
      onBoardingLogoUrl = dataOnBoarding?.logo ?? "";
      onBoardingImageUrl = dataOnBoarding?.image ?? "";
    });
  }

  String _version = "";
  String get version => _version;

  // Asynchronously checks the version of the application by comparing it with the stable and incoming versions.
  // It returns a Future<bool> indicating whether the version matches any of the stable or incoming versions.
  Future<bool> checkingVersion(BuildContext context) async {
    final Completer<bool> completer = Completer<bool>(); // Tambahkan baris ini

    Either<Failure, ResGetVersionApp> response =
        await repoBoarding.getVersionApp();
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final String versionNumber = packageInfo.version;
    _version = versionNumber;
    notifyListeners();

    response.when(
      error: (failed) {
        // Handle error if needed
        completer.complete(false);
        NotificationUtils.showDialogError(context, () {
          Nav.back();
        },
            widget: Text(
              failed.message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            textButton: S.of(context).back);
      },
      success: (success) {
        if (versionNumber == success.data?.stableVersion ||
            versionNumber == success.data?.incomingVersion) {
          completer.complete(true);
        } else {
          if (kDebugMode) {
            print(
                "Versi aplikasi berbeda: $versionNumber (lokal) != ${success.data?.stableVersion} (stable version) || ${success.data?.incomingVersion} (incoming version)");
          }
          Nav.replace(
              UpdateAppPage(versionApp: success.data?.incomingVersion ?? ""));
          completer.complete(false);
        }
      },
    );

    return completer.future; // Ubah baris ini
  }
}
