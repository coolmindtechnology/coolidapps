import 'dart:io';
import 'package:cool_app/data/data_global.dart';
import 'package:cool_app/presentation/utils/nav_utils.dart';
import 'package:cool_app/presentation/utils/resources/notification.dart';
import 'package:dio/dio.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';

class FileDownload {
  Dio dio = Dio();
  bool isSuccess = false;
  CancelToken cancelToken = CancelToken();

  void startDownloading(BuildContext context, final Function okCallback,
      {required String url, required String name}) async {
    String path = await _getFilePath(name);

    try {
      await dio.download(
        url,
        path,
        cancelToken: cancelToken,
        options: Options(
          headers: {
            "Authorization": dataGlobal.token,
            "Content-Type": "multipart/form-data",
          },
        ),
        onReceiveProgress: (recivedBytes, totalBytes) {
          okCallback(recivedBytes, totalBytes, cancelToken);
        },
        deleteOnError: true,
      ).then((_) {
        isSuccess = true;
      });
    } catch (e) {
      print("Exception$e");
    }

    if (isSuccess) {
      Nav.back();
      PushNotifications.showSimpleNotification(
          title: 'Cool App', body: 'File berhasil didownload', payload: path);
      OpenFilex.open(path);
    }
  }

  Future<String> _getFilePath(String filename) async {
    Directory? dir;

    try {
      if (Platform.isIOS) {
        dir = await getApplicationDocumentsDirectory(); // untuk iOS
      } else {
        dir = Directory('/storage/emulated/0/Download/'); // untuk Android
        if (!await dir.exists()) dir = (await getExternalStorageDirectory())!;
      }
    } catch (err) {
      print("Tidak dapat mengambil path folder download: $err");
    }
    return "${dir?.path}/$filename";
  }
}
