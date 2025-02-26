import 'dart:async';

import 'package:coolappflutter/data/helpers/check_language.dart';
import 'package:coolappflutter/presentation/widgets/GlobalButton.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart'; // Ganti library PDF
import 'package:coolappflutter/data/data_global.dart';
import 'package:coolappflutter/data/networks/endpoint/api_endpoint.dart';
import 'package:coolappflutter/data/provider/provider_profiling.dart';
import 'package:coolappflutter/data/response/profiling/res_list_profiling.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/profiling/results/dialog_download.dart';
import 'package:coolappflutter/presentation/pages/profiling/results/pdf_download.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/widgets/button_primary.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CertificateScreen extends StatefulWidget {
  final DataProfiling? data;
  final String? shareCode;
  const CertificateScreen({super.key, this.data, this.shareCode});

  @override
  State<CertificateScreen> createState() => _CertificateScreenState();
}

class _CertificateScreenState extends State<CertificateScreen> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey =
      GlobalKey<SfPdfViewerState>();
  bool _isLoading = true;
  String? pdfUrl;

  Future<void> getPdf() async {
    pdfUrl = ApiEndpoint.sertifikatProfiling(widget.data?.idLogResult);
    setState(() {
      _isLoading = false;
    });
  }

  String language = "id-ID";

  late StreamController<Duration> progressController;

  FlutterTts flutterTts = FlutterTts();
  bool isPlay = false;
  int end = 0;
  int start = 0;

  void initSetting() async {
    await flutterTts.getLanguages;
    await flutterTts.setVolume(1.0);
    await flutterTts.setLanguage(await LocaleChecker().cekLocaleV2());
    await flutterTts.isLanguageAvailable(await LocaleChecker().cekLocaleV2());
  }

  void _speak(String text) async {
    setState(() {
      isPlay = true;
    });

    await flutterTts.speak(text);

    _complete();
  }

  void _pause() async {
    await flutterTts.pause();
    setState(() {
      isPlay = false;
    });
  }

  void _stop() async {
    await flutterTts.stop();
    setState(() {
      isPlay = false;
    });
  }

  void _complete() async {
    flutterTts.setCompletionHandler(() {
      setState(() {
        isPlay = false;
      });
    });
  }

  void _progress() async {
    flutterTts.setProgressHandler(
        (String text, int startOffset, int endOffset, String word) {
      setState(() {
        end = endOffset;
        start = startOffset;
        if (kDebugMode) {
          print(startOffset);
          print(formatDuration(Duration(seconds: end ~/ 4000)));
        }
      });
    });
  }

  initLoad() async {
    await context
        .read<ProviderProfiling>()
        .getShowProfiling(context, widget.data?.idLogResult.toString() ?? "");
  }

  @override
  void initState() {
    super.initState();
    getPdf();
    flutterTts = FlutterTts();
    initLoad();
    initSetting();
    _progress();
  }

  @override
  dispose() {
    flutterTts.stop();
    super.dispose();
  }

  /// Mengembalikan string yang diformat untuk Durasi yang diberikan [d] menjadi MM:SS
  static String formatDuration(Duration d) {
    var minutes = d.inMinutes.remainder(Duration.minutesPerHour);
    var seconds = d.inSeconds.remainder(Duration.secondsPerMinute);

    // Mengonversi nilai menjadi string dengan format 00:00
    final String formattedMinutes = minutes.toString().padLeft(2, '0');
    final String formattedSeconds = seconds.toString().padLeft(2, '0');

    return '$formattedMinutes:$formattedSeconds';
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return ProviderProfiling();
      },
      child: Consumer<ProviderProfiling>(builder: (context, value, child) {
        return PopScope(
            onPopInvoked: (didPop) {
              _stop();
              // return Future.value(false);
            },
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  S.of(context).certificate,
                  style: TextStyle(color: whiteColor),
                ),
                actions: [
                  InkWell(
                    child: Image.asset(
                      "assets/icons/upload.png",
                      width: 24,
                      color: whiteColor,
                    ),
                    onTap: () {
                      value.shareCertificate(context, widget.shareCode ?? "");
                    },
                  ),
                  const SizedBox(
                    width: 24,
                  )
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    Center(
                      child: _isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : SizedBox(
                              height: 400,
                              child: SfPdfViewer.network(
                                pdfUrl!,
                                key: _pdfViewerKey,
                                headers: {"Authorization": dataGlobal.token},
                              ),
                            ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    GlobalButton(
                      onPressed: () {
                        showModalBottomSheet(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25),
                            ),
                          ),
                          isDismissible: false,
                          context: context,
                          builder: (context) {
                            return DownloadProgressDialog(
                              url: ApiEndpoint.donwnloadCertificatrPdf(
                                  widget.data?.idLogResult ?? ""),
                              name:
                                  "${widget.data?.profilingName}_CoolProfiling_Certificate.pdf",
                            );
                          },
                        );
                      },
                      color: Colors.white,
                      text: S.of(context).download,
                      textStyle: TextStyle(color: primaryColor),
                      icon: Icon(
                        Icons.file_download_outlined,
                        color: primaryColor,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
              // bottomNavigationBar: Padding(
              //   padding: const EdgeInsets.all(24.0),
              //   child: Column(
              //     mainAxisSize: MainAxisSize.min,
              //     children: [
              //       Flexible(
              //         child: ButtonPrimary(
              //           isPlay ? S.of(context).pause_audio : S.of(context).play_audio,
              //           onPress: () async {
              //             isPlay ? _pause() : _speak(value.textToSpeech);
              //             setState(() {});
              //           },
              //           expand: true,
              //           radius: 10,
              //           imageLeft: Row(
              //             children: [
              //               Image.asset(
              //                 isPlay ? "assets/icons/heroicons-outline_pause.png" : "assets/icons/play.png",
              //                 width: 24,
              //                 color: whiteColor,
              //               ),
              //               const SizedBox(width: 8),
              //             ],
              //           ),
              //         ),
              //       ),
              //       if (isPlay) ...[
              //         const SizedBox(height: 8),
              //         Flexible(
              //           child: LinearProgressIndicator(
              //             backgroundColor: whiteColor.withOpacity(0.5),
              //             valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
              //             value: end / value.textToSpeech.length,
              //           ),
              //         ),
              //       ],
              //     ],
              //   ),
              // ),


            ));
      }),
    );
  }
}

// // import 'package:advance_pdf_viewer_fork/advance_pdf_viewer_fork.dart';
// import 'package:advance_pdf_viewer2/advance_pdf_viewer.dart';
// import 'package:coolappflutter/data/data_global.dart';
// import 'package:coolappflutter/data/networks/endpoint/api_endpoint.dart';
// import 'package:coolappflutter/data/provider/provider_profiling.dart';
// import 'package:coolappflutter/data/response/profiling/res_list_profiling.dart';
// import 'package:coolappflutter/generated/l10n.dart';
// import 'package:coolappflutter/presentation/pages/profiling/results/dialog_download.dart';
// import 'package:coolappflutter/presentation/pages/profiling/results/pdf_download.dart';
// import 'package:coolappflutter/presentation/theme/color_utils.dart';
// import 'package:coolappflutter/presentation/widgets/button_primary.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class CertificateScreen extends StatefulWidget {
//   final DataProfiling? data;
//   final String? shareCode;
//   const CertificateScreen({super.key, this.data, this.shareCode});

//   @override
//   State<CertificateScreen> createState() => _CertificateScreenState();
// }

// class _CertificateScreenState extends State<CertificateScreen> {
//   bool _isLoading = true;
//   PDFDocument? doc;

//   Future<void> getPdf() async {
//     doc = await PDFDocument.fromURL(
//         ApiEndpoint.sertifikatProfiling(widget.data?.idLogResult),
//         headers: {"Authorization": dataGlobal.token});
//     setState(() {
//       _isLoading = false;
//     });
//   }

//   @override
//   void initState() {
//     getPdf();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (BuildContext context) {
//         return ProviderProfiling();
//       },
//       child: Consumer<ProviderProfiling>(builder: (context, value, child) {
//         return Scaffold(
//           appBar: AppBar(
//             title: Text(
//               S.of(context).certificate,
//               style: TextStyle(color: whiteColor),
//             ),
//             actions: [
//               InkWell(
//                 child: Image.asset(
//                   "assets/icons/upload.png",
//                   width: 24,
//                   color: whiteColor,
//                 ),
//                 onTap: () {
//                   value.shareCertificate(context, widget.shareCode ?? "");
//                   // Provider.of<ProviderProfiling>(context, listen: false)
//                   //     .shareCertificate(context, widget.shareCode ?? "");
//                 },
//               ),
//               const SizedBox(
//                 width: 24,
//               )
//             ],
//           ),
//           body: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 24),
//             child: Column(
//               children: [
//                 const SizedBox(
//                   height: 16,
//                 ),
//                 Center(
//                     child: _isLoading
//                         ? const Center(child: CircularProgressIndicator())
//                         : SizedBox(
//                             height: 200, child: PDFViewer(document: doc!))),
//                 const SizedBox(
//                   height: 16,
//                 ),
//                 SizedBox(
//                   height: 54,
//                   child: ButtonPrimary(
//                     S.of(context).download,
//                     onPress: () {
//                       showModalBottomSheet(
//                           shape: const RoundedRectangleBorder(
//                             borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(25),
//                               topRight: Radius.circular(25),
//                             ),
//                           ),
//                           isDismissible: false,
//                           context: context,
//                           builder: (context) {
//                             return DownloadProgressDialog(
//                                 url: ApiEndpoint.donwnloadCertificatrPdf(
//                                     widget.data?.idLogResult ?? ""),
//                                 name:
//                                     "${widget.data?.profilingName}_CoolProfiling_Certificate.pdf");
//                           });
//                     },
//                     expand: true,
//                     radius: 10,
//                     imageLeft: Row(
//                       children: [
//                         Image.asset(
//                           "assets/icons/download.png",
//                           width: 24,
//                           color: whiteColor,
//                         ),
//                         const SizedBox(
//                           width: 8,
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 16,
//                 ),
//               ],
//             ),
//           ),
//         );
//       }),
//     );
//   }
// }
