// import 'dart:io';
// import 'package:coolappflutter/data/networks/dio_handler.dart';
// import 'package:coolappflutter/presentation/theme/color_utils.dart';
// import 'package:coolappflutter/presentation/utils/circular_progress_widget.dart';
// import 'package:coolappflutter/presentation/utils/nav_utils.dart';
// import 'package:coolappflutter/presentation/utils/notification_utils.dart';
// import 'package:coolappflutter/presentation/utils/resources/notification.dart';
// import 'package:dio/dio.dart';
// import 'package:open_filex/open_filex.dart';
// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart' as path;
// import 'package:percent_indicator/linear_percent_indicator.dart';
// import 'package:permission_handler/permission_handler.dart';

// import '../../../../data/data_global.dart';
// import 'package:flutter_file_downloader/flutter_file_downloader.dart';

// class PdfDownloadBottom extends StatefulWidget {
//   final String url;
//   final String name;

//   const PdfDownloadBottom(this.url, this.name, {Key? key}) : super(key: key);

//   @override
//   State<PdfDownloadBottom> createState() => _PdfDownloadBottomState();
// }

// class _PdfDownloadBottomState extends State<PdfDownloadBottom> {
//   late String fullPath;
//   double? progress = 0.0;
//   double persen = 0.0;
//   bool loading = false;

//   late int _downloadId;
//   Future<void> downloadPdf() async {
//     await getPermission();
//     if (Platform.isIOS) {
//       fullPath =
//           "${(await path.getApplicationDocumentsDirectory()).path}/${widget.name}";
//     } else {
//       fullPath = "/storage/emulated/0/Download/${widget.name}";
//     }

//     setState(() {
//       loading = true;
//     });

//     dio.downloadUri(
//       Uri.parse(widget.url),
//       fullPath,
//       options: Options(
//         headers: {
//           "Authorization": dataGlobal.token,
//           "Content-Type": "multipart/form-data",
//           "Accept": "application/json",
//           "Connection": "keep-alive",
//         },
//       ),
//       onReceiveProgress: (rec, total) {
//         setState(() {
//           progress = rec / total;
//         });
//       },
//     );
//     // FileDownloader.downloadFile(
//     //   url: widget.url,
//     //   name: widget.name,
//     //   downloadDestination: DownloadDestinations.publicDownloads,
//     //   headers: {
//     //     "Authorization": dataGlobal.token,
//     //     "Content-Type": "multipart/form-data",
//     //     "Accept": "application/json",
//     //     "Connection": "keep-alive",
//     //   },
//     //   onProgress: (String? fileName, double progressDownload) {
//     //     setState(() {
//     //       progress = progressDownload / 100;
//     //       persen = progressDownload;
//     //     });
//     //   },
//     //   onDownloadRequestIdReceived: (id) {
//     //     setState(() => _downloadId = id);
//     //   },
//     //   onDownloadCompleted: (String path) {
//     //     Nav.back();
//     //     PushNotifications.showSimpleNotification(
//     //         title: 'Cool App', body: 'File berhasil didownload', payload: path);
//     //     OpenFilex.open(path);
//     //   },
//     //   onDownloadError: (String error) {
//     //     NotificationUtils.showDialogError(context, () {
//     //       Nav.back();
//     //     },
//     //         widget: Text(
//     //           error,
//     //           textAlign: TextAlign.center,
//     //           style: const TextStyle(fontSize: 16),
//     //         ));
//     //   },
//     // );
//   }

//   Future<void> getPermission() async {
//     await Permission.storage.request();
//   }

//   @override
//   void initState() {
//     if (loading) return;
//     downloadPdf();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         if (loading) {
//           final canceled = await FileDownloader.cancelDownload(_downloadId);
//           print('Canceled: $canceled');
//           if (canceled) {
//             setState(() {
//               loading = false;
//             });
//           }
//         }
//         return true;
//       },
//       child: Container(
//         height: 75,
//         decoration: const BoxDecoration(
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(25),
//             topRight: Radius.circular(25),
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 32),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             mainAxisSize: MainAxisSize.max,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     children: [
//                       Image.asset(
//                         'assets/icons/download.png',
//                         height: 20,
//                         width: 20,
//                       ),
//                       const SizedBox(
//                         width: 11,
//                       ),
//                       const Text(
//                         'Menyimpan file ke Ponsel',
//                         style: TextStyle(
//                             fontSize: 12, fontWeight: FontWeight.w600),
//                       )
//                     ],
//                   ),
//                   Text('${persen.toStringAsFixed(0)}%')
//                 ],
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               progress == 0.0
//                   ? Center(
//                       child: SizedBox(
//                         height: 25,
//                         width: 25,
//                         child: CircularProgressWidget(
//                           color: primaryColor,
//                         ),
//                       ),
//                     )
//                   : LinearPercentIndicator(
//                       animation: true,
//                       animateFromLastPercent: true,
//                       lineHeight: 5.0,
//                       barRadius: const Radius.circular(10),
//                       percent: progress ?? 0.0,
//                       animationDuration: 500,
//                       backgroundColor: const Color(0xFFF2F2F2),
//                       progressColor: Colors.blue,
//                     ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
