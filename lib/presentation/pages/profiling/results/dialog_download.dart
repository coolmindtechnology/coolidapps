import 'package:cool_app/presentation/pages/profiling/results/file_download.dart';
import 'package:cool_app/presentation/theme/color_utils.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadProgressDialog extends StatefulWidget {
  final String url, name;
  const DownloadProgressDialog({
    Key? key,
    required this.name,
    required this.url,
  }) : super(key: key);
  @override
  State<DownloadProgressDialog> createState() => _DownloadProgressDialogState();
}

class _DownloadProgressDialogState extends State<DownloadProgressDialog> {
  double progress = 0.0;
  CancelToken cancelToken = CancelToken();

  @override
  void initState() {
    checkPermission();
    super.initState();
  }

  void _startDownload() {
    FileDownload().startDownloading(context,
        (recivedBytes, totalBytes, cancel) {
      setState(() {
        progress = recivedBytes / totalBytes;
        cancelToken = cancel;
      });
    }, url: widget.url, name: widget.name);
  }

  checkPermission() async {
    bool result = await _permissionRequest();
    if (result) {
      _startDownload();
    } else {
      print("No permission to read and write.");
    }
  }

  static Future<bool> _permissionRequest() async {
    PermissionStatus result;
    final plugin = DeviceInfoPlugin();
    final android = await plugin.androidInfo;

    final storageStatus = android.version.sdkInt < 33
        ? await Permission.storage.request()
        : PermissionStatus.granted;

    if (storageStatus == PermissionStatus.granted) {
      print("granted");
      return true;
    }
    if (storageStatus == PermissionStatus.denied) {
      print("denied");
      return false;
    }
    if (storageStatus == PermissionStatus.permanentlyDenied) {
      openAppSettings();
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    String downloadingProgress = (progress * 100).toInt().toString();
    return WillPopScope(
      onWillPop: () async {
        if (downloadingProgress != "100") {
          cancelToken.cancel();
          print('here');
        }
        return true;
      },
      child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/icons/download.png',
                        height: 20,
                        width: 20,
                      ),
                      const SizedBox(
                        width: 11,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: const Text(
                          "Downloading",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "$downloadingProgress %",
                  )
                ],
              ),
              LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey,
                color: primaryColor,
                minHeight: 5,
              ),
              // Align(
              //   alignment: Alignment.bottomRight,
              //   child: Text(
              //     "$downloadingProgress %",
              //   ),
              // )
            ],
          )),
    );
  }
}
