import 'dart:async';
import 'package:coolappflutter/data/apps/app_assets.dart';
import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:coolappflutter/data/helpers/check_language.dart';
import 'package:coolappflutter/data/networks/endpoint/api_endpoint.dart';
import 'package:coolappflutter/data/provider/provider_profiling.dart';
import 'package:coolappflutter/data/response/profiling/res_detail_profiling.dart';
import 'package:coolappflutter/data/response/profiling/res_list_profiling.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/profiling/results/dialog_download.dart';

import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/circular_progress_widget.dart';
import 'package:coolappflutter/presentation/widgets/button_primary.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';

import '../../../../data/locals/preference_handler.dart';

class ResultDetail extends StatefulWidget {
  final DataProfiling? data;
  final String? type;
  const ResultDetail({super.key, this.data, this.type});

  @override
  State<ResultDetail> createState() => _ResultDetailState();
}

class _ResultDetailState extends State<ResultDetail> {
  String language = "id-ID";
  // List<dynamic> languages = [
  //   "id_ID",
  //   "en-US",
  //   "ar_AR",
  //   "zh_CN",
  //   "es_ES",
  //   "ms_MY",
  //   "ru_RU",
  //   "tr_TR"
  // ];
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
  // Future<void> _speak(String text) async {
  //   if (text.isEmpty) return;

  //   setState(() {
  //     isPlay = true;
  //   });

  //   await flutterTts.speak(text);

  //   flutterTts.setCompletionHandler(() {
  //     setState(() {
  //       isPlay = false;
  //     });
  //   });
  // }

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
        .getDetailProfiling(context, widget.data?.idLogResult.toString() ?? "");
  }

  @override
  void initState() {
    flutterTts = FlutterTts();
    initLoad();
    initSetting();
    _progress();
    // initSettings();

    super.initState();
  }

  // Future<void> initSettings() async {
  //   // Mendapatkan daftar bahasa yang tersedia
  //   languages = await flutterTts.getLanguages;

  //   // Menggunakan bahasa default sistem jika tersedia
  //   String defaultLanguage = await flutterTts.getDefaultVoice;
  //   language = defaultLanguage;

  //   // Memeriksa ketersediaan bahasa dan menetapkan bahasa
  //   bool isAvailable = await flutterTts.isLanguageAvailable(language);
  //   if (!isAvailable) {
  //     language =
  //         "en-US"; // Default fallback ke Inggris jika bahasa default tidak tersedia
  //   }

  //   await flutterTts.setLanguage(language);
  //   await flutterTts.setVolume(1.0);

  //   setState(() {});
  // }

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
    return Consumer<ProviderProfiling>(
      builder: (context, value, child) {
        return PopScope(
          onPopInvoked: (didPop) {
            _stop();
            // return Future.value(false);
          },
          child: Scaffold(
            backgroundColor: const Color(0xff5cc6ee),
            appBar: AppBar(
              title: Text(
                S.of(context).result_detail,
                style: TextStyle(color: whiteColor),
              ),
              surfaceTintColor: Colors.transparent,
              iconTheme: IconThemeData(color: whiteColor),
              actionsIconTheme: IconThemeData(color: whiteColor),
              centerTitle: true,
              backgroundColor: primaryColor,
              actions: [
                InkWell(
                  onTap: () {
                    value.shareResultDetail(context);
                  },
                  child: Image.asset(
                    "assets/icons/upload.png",
                    width: 24,
                    color: whiteColor,
                  ),
                ),
                const SizedBox(
                  width: 24,
                )
              ],
            ),
            body: value.isDetail
                ? CircularProgressWidget(
                    color: primaryColor,
                  )
                : Container(
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: primaryColor),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (widget.type == "tipeAura" &&
                                    value.detailProfiling?.tipeAura !=
                                        null) ...[
                                  _TipeAura(value: value),
                                ],
                                if (widget.type == "tipeOtak" &&
                                    value.detailProfiling?.tipeOtak !=
                                        null) ...[
                                  _TipeOtak(value: value),
                                ],
                                if (widget.type == "tipeKaya" &&
                                    value.detailProfiling?.tipeKaya !=
                                        null) ...[
                                  _TipeKaya(value: value),
                                ],
                                if (widget.type == "tipeDarah" &&
                                    value.detailProfiling?.tipeDarah !=
                                        null) ...[
                                  _TipeDarah(value: value),
                                ],
                                if (widget.type == "personality" &&
                                    value.detailProfiling?.personality !=
                                        null) ...[
                                  _Personality(value: value),
                                ],
                                if (widget.type == "karir" &&
                                    value.detailProfiling?.karir != null) ...[
                                  _classtipe(
                                      data: value.detailProfiling?.karir,judul: S.of(context).career,),
                                ],
                                if (widget.type == "polaBahagia" &&
                                    value.detailProfiling?.polaBahagia !=
                                        null) ...[
                                  _classtipe(
                                      data: value.detailProfiling?.polaBahagia,judul: S.of(context).happiness_pattern),
                                ],
                                if (widget.type == "polaInteraksi" &&
                                    value.detailProfiling?.polaInteraksi !=
                                        null) ...[
                                  _classtipe(
                                      data:
                                          value.detailProfiling?.polaInteraksi,judul: S.of(context).social_interaction_pattern),
                                ],
                                if (widget.type == "family" &&
                                    value.detailProfiling?.family != null) ...[
                                  _classtipe(
                                      data: value.detailProfiling?.family,judul: S.of(context).family),
                                ],
                                if (widget.type == "polaHealing" &&
                                    value.detailProfiling?.polaHealing !=
                                        null) ...[
                                  _classtipe(
                                      data: value.detailProfiling?.polaHealing,judul: S.of(context).healing_pattern),
                                ],
                                if (widget.type == "kebutuhan" &&
                                    value.detailProfiling?.kebutuhan !=
                                        null) ...[
                                  _classtipe(
                                      data: value.detailProfiling?.kebutuhan,judul: S.of(context).kebutuhan),
                                ],
                                if (widget.type == "finansial" &&
                                    value.detailProfiling?.finansial !=
                                        null) ...[
                                  _classtipe(
                                      data: value.detailProfiling?.finansial,judul: S.of(context).financial),
                                ],

                                // Center(
                                //   child: Image.asset(
                                //     "assets/images/cool-result-4.png",
                                //   ),
                                // ),
                                // if (value.detailProfiling?.publicFigure != null) ...[
                                //   Padding(
                                //     padding: const EdgeInsets.symmetric(
                                //         horizontal: 24, vertical: 16),
                                //     child: Column(
                                //         crossAxisAlignment: CrossAxisAlignment.start,
                                //         children: [
                                //           Text(
                                //             S.of(context).type_figure(
                                //                 value.detailProfiling?.character ?? ""),
                                //             style: TextStyle(
                                //                 fontSize: 16, color: whiteColor),
                                //           ),
                                //           const SizedBox(
                                //             height: 16,
                                //           ),
                                //           SizedBox(
                                //             width:
                                //                 MediaQuery.of(context).size.width - 48,
                                //             child: GridView.builder(
                                //               gridDelegate:
                                //                   const SliverGridDelegateWithFixedCrossAxisCount(
                                //                       crossAxisCount: 5,
                                //                       mainAxisExtent: 100),
                                //               itemCount: value.detailProfiling
                                //                   ?.publicFigure?.length,
                                //               shrinkWrap: true,
                                //               physics:
                                //                   const NeverScrollableScrollPhysics(),
                                //               itemBuilder: (context, index) {
                                //                 PublicFigure publicFigure = value
                                //                     .detailProfiling!
                                //                     .publicFigure![index];
                                //                 return InkWell(
                                //                   onTap: () {
                                //                     // Nav.to(const RelatedFigure());
                                //                   },
                                //                   child: Column(
                                //                     crossAxisAlignment:
                                //                         CrossAxisAlignment.center,
                                //                     mainAxisAlignment:
                                //                         MainAxisAlignment.center,
                                //                     children: [
                                //                       CircleAvatar(
                                //                           radius: 30,
                                //                           backgroundImage: NetworkImage(
                                //                             "${publicFigure.image}",
                                //                           )),
                                //                       const SizedBox(
                                //                         height: 8,
                                //                       ),
                                //                       Text(
                                //                         "${publicFigure.name}",
                                //                         style: TextStyle(
                                //                           color: whiteColor,
                                //                           fontSize: 10,
                                //                         ),
                                //                         overflow: TextOverflow.ellipsis,
                                //                       ),
                                //                     ],
                                //                   ),
                                //                 );
                                //               },
                                //             ),
                                //           ),
                                //         ]),
                                //   ),
                                // ]
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
            bottomNavigationBar: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(S.of(context).akandidengar),
                        Text(
                          value.dataShowDetail?.result ?? "",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                    gapH10,
                    SizedBox(
                      height: 54,
                      child: ButtonPrimary(
                        isPlay
                            ? S.of(context).pause_audio
                            : S.of(context).play_audio,
                        onPress: () async {
                          // debugPrint("cek audio${value.textToSpeech}");
                          List<dynamic> languages =
                              await flutterTts.getLanguages;
                          print("Bahasa yang didukung: $languages");

                          isPlay ? _pause() : _speak(value.textToSpeech);
                          setState(() {});
                        },
                        expand: true,
                        radius: 10,
                        imageLeft: Row(
                          children: [
                            Image.asset(
                              isPlay
                                  ? "assets/icons/heroicons-outline_pause.png"
                                  : "assets/icons/play.png",
                              width: 24,
                              color: whiteColor,
                            ),
                            const SizedBox(
                              width: 8,
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    if (isPlay) ...[
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                              alignment: Alignment.topCenter,
                              child: LinearProgressIndicator(
                                backgroundColor: whiteColor.withOpacity(0.5),
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(primaryColor),
                                value: end / value.textToSpeech.length,
                              )),
                          const SizedBox(
                            height: 8,
                          ),
                        ],
                      )
                    ] else ...[
                      SizedBox(
                          // height: 54,
                          // child: ButtonPrimary(
                          //   S.of(context).download,
                          //   onPress: () async {
                          //     String? isLanguage =
                          //         await PreferenceHandler.retrieveId();
                          //     String? isID =
                          //         await PreferenceHandler.retrieveIdLanguage();
                          //     // showDialog(
                          //     //     context: context,
                          //     //     barrierDismissible: false,
                          //     //     builder: (dialogcontext) {
                          //     //       return DownloadProgressDialog(
                          //     //           url: ApiEndpoint.donwnloadDetailPdf(
                          //     //               widget.data?.idLogResult ?? ""),
                          //     //           name:
                          //     //               "${widget.data?.profilingName}_CoolProfiling_Result.pdf");
                          //     //     });
                          //     showModalBottomSheet(
                          //         shape: const RoundedRectangleBorder(
                          //           borderRadius: BorderRadius.only(
                          //             topLeft: Radius.circular(25),
                          //             topRight: Radius.circular(25),
                          //           ),
                          //         ),
                          //         isDismissible: false,
                          //         context: context,
                          //         builder: (context) {
                          //           debugPrint(
                          //               "url pdf ${ApiEndpoint.donwnloadDetailPdf(widget.data?.idLogResult.toString(), "$isLanguage=$isID")}");
                          //           return DownloadProgressDialog(
                          //             url: ApiEndpoint.donwnloadDetailPdf(
                          //                 widget.data?.idLogResult.toString() ?? "",
                          //                 "$isLanguage=$isID"),
                          //             name:
                          //                 "${widget.data?.profilingName}_CoolProfiling_Result.pdf",
                          //           );
                          //         });
                          //   },
                          //   expand: true,
                          //   negativeColor: true,
                          //   border: 1,
                          //   radius: 10,
                          //   imageLeft: Row(
                          //     children: [
                          //       Image.asset(
                          //         "assets/icons/download.png",
                          //         width: 24,
                          //       ),
                          //       const SizedBox(
                          //         width: 8,
                          //       )
                          //     ],
                          //   ),
                          // ),
                          ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  IntrinsicHeight itemPola({String? tipePola, String? kataKunci}) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Container(
            padding: const EdgeInsets.all(8),
            child: Text(
              "$tipePola",
              style: TextStyle(color: whiteColor, fontSize: 10),
            ),
          )),
          const VerticalDivider(),
          Expanded(
              child: Container(
            padding: const EdgeInsets.all(8),
            child: Text(
              "$kataKunci",
              style: TextStyle(color: whiteColor, fontSize: 10),
            ),
          ))
        ],
      ),
    );
  }
}

class _Personality extends StatelessWidget {
  const _Personality({
    required this.value,
  });
  final ProviderProfiling value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 160,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: value.detailProfiling?.tipeDarah == null
                ? imageBlue
                : Colors.white,
          ),
          child: Image.network(
            "${value.detailProfiling?.personality?.picture}",
          ),
        ),
        gapH20,
        Center(
          child: IntrinsicWidth( // Agar lebar Container menyesuaikan teks
            child: IntrinsicHeight( // Agar tinggi menyesuaikan konten
              child: Stack(
                children: [
                  // Background Container dengan logo sebagai watermark
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    child: Opacity(
                      opacity: 0.4, // Atur transparansi gambar
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Center(
                          child: Image.asset(
                            AppAsset.imgNewCoolLogo2, // Ganti dengan path logo
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Konten utama (teks)
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min, // Menyesuaikan ukuran konten
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).personality,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        gapH10,
                        Text(
                          value.detailProfiling?.personality?.description ?? "",
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )

      ],
    );
  }
}

class _classtipe extends StatelessWidget {
  const _classtipe({
    required this.data,
    required this.judul// Langsung instance dari Personality
  });

  final Personality? data;
  final dynamic judul;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 160,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: data?.picture != null
              ? Padding(
                padding: const EdgeInsets.all(35),
                child: Image.network("${data?.picture}"),
              )
              : const SizedBox(), // Placeholder jika gambar null
        ),
        gapH20,
        Center(
          child: IntrinsicWidth( // Agar lebar Container menyesuaikan teks
            child: IntrinsicHeight( // Agar tinggi menyesuaikan konten
              child: Stack(
                children: [
                  // Background Container dengan logo sebagai watermark
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    child: Opacity(
                      opacity: 0.4, // Atur transparansi gambar
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Center(
                          child: Image.asset(
                            AppAsset.imgNewCoolLogo2, // Ganti dengan path logo
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Konten utama (teks)
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min, // Menyesuaikan ukuran konten
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                         judul,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        gapH10,
                        Text(
                          data?.description ?? "Deskripsi tidak tersedia",
                          textAlign: TextAlign.justify,
                          style: const TextStyle(fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )

      ],
    );
  }
}

class _TipeOtak extends StatelessWidget {
  const _TipeOtak({
    required this.value,
  });
  final ProviderProfiling value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 160,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: value.detailProfiling?.tipeDarah == null
                ? imageBlue
                : Colors.white,
          ),
          child: Image.network(
            "${value.detailProfiling?.tipeOtak?.picture}",
          ),
        ),
        gapH20,
        Center(
          child: IntrinsicWidth( // Agar lebar Container menyesuaikan teks
            child: IntrinsicHeight( // Agar tinggi menyesuaikan konten
              child: Stack(
                children: [
                  // Background Container dengan logo sebagai watermark
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    child: Opacity(
                      opacity: 0.4, // Atur transparansi gambar
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Center(
                          child: Image.asset(
                            AppAsset.imgNewCoolLogo2,// Ganti dengan path logo
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Konten utama (teks)
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min, // Menyesuaikan ukuran konten
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${S.of(context).brain_type} ",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        gapH10,
                        Text(
                          value.detailProfiling?.tipeOtak?.description ?? "",
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )

      ],
    );
  }
}

class _TipeAura extends StatelessWidget {
  const _TipeAura({
    required this.value,
  });
  final ProviderProfiling value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 160,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: value.detailProfiling?.tipeDarah == null
                ? imageBlue
                : Colors.white,
          ),
          child: Image.network(
            "${value.detailProfiling?.tipeAura?.picture}",
            loadingBuilder: (BuildContext context, Widget image,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) return image;
              return Center(
                child: CircularProgressWidget(
                  color: primaryColor,
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
          ),
        ),
        gapH20,
        Center(
          child: IntrinsicWidth( // Agar lebar Container menyesuaikan teks
            child: IntrinsicHeight( // Agar tinggi menyesuaikan konten
              child: Stack(
                children: [
                  // Background Container dengan logo sebagai watermark
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    child: Opacity(
                      opacity: 0.4, // Atur transparansi gambar
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Center(
                          child: Image.asset(
                            AppAsset.imgNewCoolLogo2, // Ganti dengan path logo
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Konten utama (teks)
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min, // Menyesuaikan ukuran konten
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${S.of(context).aura_type} - ${value.detailProfiling?.tipeAura?.tipe ?? ""}",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        gapH10,
                        Text(
                          value.detailProfiling?.tipeAura?.description ?? "",
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )

      ],
    );
  }
}

class _TipeKaya extends StatelessWidget {
  const _TipeKaya({
    required this.value,
  });
  final ProviderProfiling value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).rich_type,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Center(
          child: Container(
            height: 160,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: value.detailProfiling?.tipeDarah == null
                    ? imageBlue
                    : Colors.white,),
            child: Image.network(
              "${value.detailProfiling?.tipeKaya?.picture}",
              loadingBuilder: (BuildContext context, Widget image,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return image;
                return Center(
                  child: CircularProgressWidget(
                    color: primaryColor,
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
            ),
          ),
        ),
        gapH20,
        Center(
          child: IntrinsicWidth( // Agar lebar Container menyesuaikan teks
            child: IntrinsicHeight( // Agar tinggi menyesuaikan konten
              child: Stack(
                children: [
                  // Background Container dengan logo sebagai watermark
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    child: Opacity(
                      opacity: 0.4, // Atur transparansi gambar
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Center(
                          child: Image.asset(
                            AppAsset.imgNewCoolLogo2,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Konten utama (teks)
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min, // Menyesuaikan ukuran konten
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${S.of(context).rich_type} - ${value.detailProfiling?.tipeKaya?.tipe ?? ""}",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        gapH10,
                        Text(
                          value.detailProfiling?.tipeKaya?.description ?? "",
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )


      ],
    );
  }
}

class _TipeDarah extends StatelessWidget {
  const _TipeDarah({
    required this.value,
  });
  final ProviderProfiling value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 160,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: value.detailProfiling?.tipeDarah == null
                ? imageBlue
                : Colors.white,
          ),
          child: Image.network(
            "${value.detailProfiling?.tipeDarah?.picture}",
            loadingBuilder: (BuildContext context, Widget image,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) return image;
              return Center(
                child: CircularProgressWidget(
                  color: primaryColor,
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
          ),
        ),
        gapH20,
        Center(
          child: IntrinsicWidth( // Agar lebar Container menyesuaikan teks
            child: IntrinsicHeight( // Agar tinggi menyesuaikan konten
              child: Stack(
                children: [
                  // Background Container dengan logo sebagai watermark
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    child: Opacity(
                      opacity: 0.4, // Atur transparansi gambar
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Center(
                          child: Image.asset(
                            AppAsset.imgNewCoolLogo2, // Ganti dengan path logo
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Konten utama (teks)
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min, // Menyesuaikan ukuran konten
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${S.of(context).blood_type} - ${value.detailProfiling?.tipeDarah?.tipe ?? ""}",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        gapH10,
                        Text(
                          value.detailProfiling?.tipeDarah?.description ?? "",
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
