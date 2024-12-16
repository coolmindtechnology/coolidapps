import 'dart:async';

import 'package:android_intent_plus/android_intent.dart';
import 'package:coolappflutter/presentation/pages/profiling/results/file_download.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadProgressDialog extends StatefulWidget {
  final String url, name;
  const DownloadProgressDialog({
    super.key,
    required this.name,
    required this.url,
  });

  @override
  State<DownloadProgressDialog> createState() => _DownloadProgressDialogState();
}

class _DownloadProgressDialogState extends State<DownloadProgressDialog> {
  double progress = 0.0;
  bool isComplete = false;
  bool runInBackground = false;
  late String filePath; // Path for the downloaded file
  CancelToken cancelToken = CancelToken();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _initNotification();
    checkPermission();
  }

  void _initNotification() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/launcher_icon');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {
        if (notificationResponse.payload != null) {
          final intent = AndroidIntent(
            action: 'action_view',
            data: Uri.file(notificationResponse.payload!).toString(),
            type: 'application/pdf',
            flags: <int>[0x10000000],
          );
          await intent
              .launch(); // Meluncurkan intent untuk membuka aplikasi PDF
        }
      },
    );
  }

  void _showNotification(int progress,
      {bool isComplete = false, String? filePath}) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics;

    if (isComplete && filePath != null) {
      androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'download_channel',
        'Downloads',
        channelDescription: 'Notifications for download progress',
        importance: Importance.max,
        priority: Priority.high,
        showProgress: true,
        maxProgress: 100,
        progress: 100,
        onlyAlertOnce: true,
        autoCancel: true,
        visibility: NotificationVisibility.public,
        playSound: true,
      );

      NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);

      await flutterLocalNotificationsPlugin.show(
        0,
        'Download Complete',
        'Tap to open ${widget.name}',
        platformChannelSpecifics,
        payload: filePath, // Menambahkan filePath sebagai payload
      );
    } else {
      androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'download_channel',
        'Downloads',
        channelDescription: 'Notifications for download progress',
        importance: Importance.max,
        priority: Priority.high,
        showProgress: true,
        maxProgress: 100,
        progress: progress,
        onlyAlertOnce: true,
        ongoing: true,
        visibility: NotificationVisibility.public,
        playSound: true,
      );

      NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);

      await flutterLocalNotificationsPlugin.show(
        0,
        'Downloading ${widget.name}',
        'Progress: $progress%',
        platformChannelSpecifics,
      );
    }
  }
  // void _showNotification(int progress,
  //     {bool isComplete = false, String? filePath}) async {
  //   final intent = AndroidIntent(
  //     action: 'action_view',
  //     data: Uri.file(filePath.toString()).toString(),
  //     type: 'application/pdf',
  //     // flags: <int>[AndroidIntent.FLAG_ACTIVITY_NEW_TASK],
  //   );
  //   AndroidNotificationDetails androidPlatformChannelSpecifics =
  //       AndroidNotificationDetails(
  //     'download_channel',
  //     'Downloads',
  //     channelDescription: 'Notifications for download progress',
  //     importance: Importance.max,
  //     priority: Priority.high,
  //     showProgress: true,
  //     maxProgress: 100,
  //     progress: isComplete ? 100 : progress,
  //     onlyAlertOnce: true,
  //     ongoing: true,
  //     // autoCancel: isComplete,
  //     visibility: NotificationVisibility.public,
  //     playSound: true,
  //   );

  //   NotificationDetails platformChannelSpecifics =
  //       NotificationDetails(android: androidPlatformChannelSpecifics);

  //   await flutterLocalNotificationsPlugin.show(
  //     0,
  //     isComplete ? 'Download Complete' : 'Downloading ${widget.name}',
  //     'Progress: 100%',
  //     platformChannelSpecifics,
  //     payload: filePath,
  //   );

  //   if (isComplete) {
  //     await intent.launch();
  //     // await flutterLocalNotificationsPlugin.cancel(0);
  //   }
  // }

  Future<void> _startDownload() async {
    final directory = await getApplicationDocumentsDirectory();
    filePath = '${directory.path}/${widget.name}.pdf';
    try {
      FileDownload().startDownloading(context,
          (receivedBytes, totalBytes, cancel) {
        debugPrint("folder1 $directory");
        progress = 1.0;
        progress++;
        if (totalBytes > 0) {
          setState(() {
            progress = (receivedBytes / totalBytes).clamp(0.0, 1.0);
            cancelToken = cancel;
          });
          _showNotification((progress * 100).toInt());
        }
      }, url: widget.url, name: widget.name);
      //

      Timer.periodic(const Duration(milliseconds: 100), (timer) {
        debugPrint("folder2 $directory");
        if (progress >= 1.0) {
          timer.cancel();
          setState(() {
            isComplete = true;
          });
          _showNotification(100,
              isComplete: true,
              filePath: filePath); // Final notification with completion status
        }
      });
    } catch (e) {
      if (e is TimeoutException) {
        // Tangani jika terjadi timeout
        debugPrint("Error: ${e.message}");
        _showErrorNotification('Gagal: Unduhan melebihi batas waktu.');
      } else {
        // Tangani error lainnya
        debugPrint("Error: $e");
        _showErrorNotification('Gagal: Terjadi kesalahan.');
      }
    }
  }

  void _showErrorNotification(String message) {
    // Menampilkan snackbar dengan pesan error
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  // void _startDownload() {
  //   FileDownload().startDownloading(context,
  //       (receivedBytes, totalBytes, cancel) {
  //     setState(() {
  //       progress = (receivedBytes / totalBytes)
  //           .clamp(0.0, 1.0); // Batasi di antara 0.0 dan 1.0
  //       cancelToken = cancel;
  //     });
  //     _showNotification((progress * 100).toInt());
  //   }, url: widget.url, name: widget.name);

  //   Timer.periodic(const Duration(milliseconds: 100), (timer) {
  //     if (progress >= 1.0) {
  //       // timer.cancel();
  //       _showNotification(100, isComplete: true);
  //     } else if (!runInBackground && !mounted) {
  //       // timer.cancel();
  //       // cancelToken.cancel();
  //     }
  //   });
  // }

  checkPermission() async {
    bool result = await _permissionRequest();
    if (result) {
      _startDownload();
    } else {
      print("No permission to read and write.");
    }
  }

  static Future<bool> _permissionRequest() async {
    final plugin = DeviceInfoPlugin();
    final android = await plugin.androidInfo;

    final storageStatus = android.version.sdkInt < 33
        ? await Permission.storage.request()
        : PermissionStatus.granted;

    if (storageStatus == PermissionStatus.granted) {
      return true;
    }
    if (storageStatus == PermissionStatus.denied) {
      return false;
    }
    if (storageStatus == PermissionStatus.permanentlyDenied) {
      openAppSettings();
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    int downloadingProgress =
        (progress <= 0.0 ? (progress / -10000) : (progress * 100).clamp(0, 100))
            .toInt();
    var resultDownload = downloadingProgress > 100
        ? 100
        : downloadingProgress.toInt().toString(); // Batasi antara 0 dan 100

    return WillPopScope(
      onWillPop: () async {
        // if (downloadingProgress != 100) {
        //   cancelToken.cancel();
        // }
        return true;
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
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
                        const SizedBox(width: 11),
                        const Text(
                          "Downloading",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Text(
                      "${resultDownload.toString()} %",
                    ),
                  ],
                ),
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey,
                  color: primaryColor,
                  minHeight: 5,
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      runInBackground = !runInBackground;
                    });
                    Navigator.pop(context);
                  },
                  child: Text(runInBackground
                      ? "Run in Foreground"
                      : "Run in Background"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



// class DownloadProgressDialog extends StatefulWidget {
//   final String url, name;
//   const DownloadProgressDialog({
//     super.key,
//     required this.name,
//     required this.url,
//   });
//   @override
//   State<DownloadProgressDialog> createState() => _DownloadProgressDialogState();
// }

// class _DownloadProgressDialogState extends State<DownloadProgressDialog> {
//   double progress = 0.0;
//   CancelToken cancelToken = CancelToken();

//   @override
//   void initState() {
//     checkPermission();
//     super.initState();
//   }

//   void _startDownload() {
//     FileDownload().startDownloading(context,
//         (recivedBytes, totalBytes, cancel) {
//       setState(() {
//         progress = recivedBytes / totalBytes;
//         cancelToken = cancel;
//       });
//     }, url: widget.url, name: widget.name);
//   }

//   checkPermission() async {
//     bool result = await _permissionRequest();
//     if (result) {
//       _startDownload();
//     } else {
//       print("No permission to read and write.");
//     }
//   }

//   static Future<bool> _permissionRequest() async {
//     PermissionStatus result;
//     final plugin = DeviceInfoPlugin();
//     final android = await plugin.androidInfo;

//     final storageStatus = android.version.sdkInt < 33
//         ? await Permission.storage.request()
//         : PermissionStatus.granted;

//     if (storageStatus == PermissionStatus.granted) {
//       print("granted");
//       return true;
//     }
//     if (storageStatus == PermissionStatus.denied) {
//       print("denied");
//       return false;
//     }
//     if (storageStatus == PermissionStatus.permanentlyDenied) {
//       openAppSettings();
//     }
//     return false;
//   }

//   @override
//   Widget build(BuildContext context) {
//     int downloadingProgress =
//         (progress <= 0.0 ? (progress / -10000) : (progress * 100).clamp(0, 100))
//             .toInt();
//     var resultDownload = downloadingProgress > 100
//         ? 100
//         : downloadingProgress.toInt().toString();

//     // String downloadingProgress = (progress * 100).toInt().toString();
//     return WillPopScope(
//       onWillPop: () async {
//         if (downloadingProgress != "100") {
//           print('here $progress');
//           cancelToken.cancel();
//         }
//         return true;
//       },
//       child: Container(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               downloadingProgress < 10
//                   ? Row(
//                       children: [
//                         const SizedBox(
//                             height: 20,
//                             width: 20,
//                             child: CircularProgressIndicator()),
//                         const SizedBox(
//                           width: 20,
//                         ),
//                         Text('${S.of(context).process} ..............'),
//                       ],
//                     )
//                   : Container(),
//               if (downloadingProgress < 10)
//                 const SizedBox(
//                   height: 10,
//                 ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Image.asset(
//                         'assets/icons/download.png',
//                         height: 20,
//                         width: 20,
//                       ),
//                       const SizedBox(
//                         width: 11,
//                       ),
//                       Container(
//                         margin: const EdgeInsets.symmetric(vertical: 10),
//                         child: const Text(
//                           "Downloading",
//                           style: TextStyle(
//                               fontSize: 14, fontWeight: FontWeight.w600),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Text(
//                     "${resultDownload.toString()} %",
//                   )
//                 ],
//               ),
//               LinearProgressIndicator(
//                 value: progress,
//                 backgroundColor: Colors.grey,
//                 color: primaryColor,
//                 minHeight: 5,
//               ),
//               // Align(
//               //   alignment: Alignment.bottomRight,
//               //   child: Text(
//               //     "$downloadingProgress %",
//               //   ),
//               // )
//             ],
//           )),
//     );
//   }
// }
