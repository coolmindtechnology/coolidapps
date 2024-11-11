import 'dart:io';
import 'package:coolappflutter/data/data_global.dart';
import 'package:coolappflutter/data/networks/dio_handler.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/notification_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class RepoDownload {
  late String localPath;
  late bool permissionReady;
  TargetPlatform? platform;

  int id = 0;

  Future<bool> checkPermission() async {
    if (platform == TargetPlatform.android) {
      final status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        final result = await Permission.storage.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  Future<void> prepareSaveDir() async {
    localPath = (await _findLocalPath())!;

    if (kDebugMode) {
      print(localPath);
    }
    final savedDir = Directory(localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
  }

  Future<String?> _findLocalPath() async {
    if (Platform.isAndroid) {
      return "/storage/emulated/0/Download/CoolApp/";
    } else {
      var directory = await getApplicationDocumentsDirectory();
      return '${directory.path}${Platform.pathSeparator}Download';
    }
  }

  Future<void> downloadFile(String? pathUrl, String? pathSave) async {
    permissionReady = await checkPermission();

    if (permissionReady) {
      await prepareSaveDir();
      if (kDebugMode) {
        print(localPath);
      }
      if (kDebugMode) {
        print("Downloading");
      }
      try {
        await dio.download("$pathUrl", "$localPath$pathSave.pdf",
            options: Options(headers: {"Authorization": dataGlobal.token}));
        NotificationUtils.showSnackbar("Berhasil download file",
            backgroundColor: primaryColor);
        if (kDebugMode) {
          print("Download Completed.");
        }
      } catch (e) {
        NotificationUtils.showSnackbar("Gagal download file",
            backgroundColor: Colors.red);
        if (kDebugMode) {
          print("Download Failed.\n\n$e");
        }
      }
    }
  }
}
