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

class ResultDetailUnder17 extends StatefulWidget {
  final DataProfiling? data;
  final String? type;
  const ResultDetailUnder17({super.key, this.data, this.type});

  @override
  State<ResultDetailUnder17> createState() => _ResultDetailUnder17State();
}

class _ResultDetailUnder17State extends State<ResultDetailUnder17> {
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
                  color: Color(0xFF93F1FB),
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              _getImage(widget.type.toString()),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 30,right: 30),
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: primaryColor, // Warna bayangan
                                            offset: Offset(4, 6), // Bayangan ke kanan
                                            blurRadius: 2, // Efek blur
                                            spreadRadius: 4, // Ukuran bayangan
                                          ),
                                        ]),
                                    child: Center(
                                      child: _getText(widget.type.toString(),context),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          gapH20,
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: primaryColor, // Warna bayangan
                                    offset: Offset(4, 6), // Bayangan ke kanan
                                    blurRadius: 2, // Efek blur
                                    spreadRadius: 4, // Ukuran bayangan
                                  ),
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (widget.type == "tipeOtak" &&
                                      value.detailProfiling?.tipeOtak !=
                                          null) ...[
                                    _classtipe(
                                        data:
                                            value.detailProfiling?.tipeOtak),
                                  ],
                                  if (widget.type == "tipeKaya" &&
                                      value.detailProfiling?.tipeKaya !=
                                          null) ...[
                                    _classtipe(
                                      data: Personality(
                                        description: value.detailProfiling
                                            ?.tipeKaya?.description,
                                        picture: value.detailProfiling
                                            ?.tipeKaya?.picture,
                                      ),
                                    ),
                                  ],
                                  if (widget.type == "personality" &&
                                      value.detailProfiling?.personality !=
                                          null) ...[
                                    _classtipe(
                                        data: value
                                            .detailProfiling?.personality),
                                  ],
                                   if (widget.type == "karir" &&
                                      value.detailProfiling?.karir !=
                                          null) ...[
                                    _classtipe(
                                        data: value
                                            .detailProfiling?.karir),
                                  ],
                                   if (widget.type == "polaBahagia" &&
                                      value.detailProfiling?.polaBahagia !=
                                          null) ...[
                                    _classtipe(
                                        data: value
                                            .detailProfiling?.polaBahagia),
                                  ],
                                   if (widget.type == "polaInteraksi" &&
                                      value.detailProfiling?.polaInteraksi !=
                                          null) ...[
                                    _classtipe(
                                        data: value
                                            .detailProfiling?.polaInteraksi),
                                  ],
                                   if (widget.type == "family" &&
                                      value.detailProfiling?.family !=
                                          null) ...[
                                    _classtipe(
                                        data: value
                                            .detailProfiling?.family),
                                  ],
                                   if (widget.type == "polaHealing" &&
                                      value.detailProfiling?.polaHealing !=
                                          null) ...[
                                    _classtipe(
                                        data: value
                                            .detailProfiling?.polaHealing),
                                  ],
                                   if (widget.type == "kebutuhan" &&
                                      value.detailProfiling?.kebutuhan !=
                                          null) ...[
                                    _classtipe(
                                        data: value
                                            .detailProfiling?.kebutuhan),
                                  ],
                                   if (widget.type == "finansial" &&
                                      value.detailProfiling?.finansial !=
                                          null) ...[
                                    _classtipe(
                                        data: value
                                            .detailProfiling?.finansial),
                                  ],
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
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

class _classtipe extends StatelessWidget {
  const _classtipe({
    required this.data, // Langsung instance dari Personality
  });

  final Personality? data;

  @override
  Widget build(BuildContext context) {
    String formatKalimat(String text) {
      return text.replaceAllMapped(
        RegExp(r'\.\s+'), // cari titik diikuti spasi
            (match) => '.\n', // ganti dengan titik dan newline
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 160,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: data != null ? imageBlue : Colors.white,
          ),
          child: data?.picture != null
              ? Image.network("${data?.picture}")
              : const SizedBox(), // Placeholder jika gambar null
        ),
        gapH20,
        Center(
          child: IntrinsicWidth(
            // Agar lebar Container menyesuaikan teks
            child: IntrinsicHeight(
              // Agar tinggi menyesuaikan konten
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
                      mainAxisSize:
                          MainAxisSize.min, // Menyesuaikan ukuran konten
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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

Widget _getText(String type,context) {
  switch (type) {
    case 'tipeKaya':
      return Text(S.of(context).rich_type,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: BlueColor));
    case 'tipeOtak':
      return Text(S.of(context).tipe_otak,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: BlueColor));
    case 'personality':
      return Text(S.of(context).your_personality,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: BlueColor));
     case 'karir':
      return Text(S.of(context).career,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: BlueColor));
     case 'polaBahagia':
      return Text(S.of(context).happiness_pattern,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: BlueColor));
     case 'polaInteraksi':
      return Text(S.of(context).social_interaction_pattern,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: BlueColor));
    case 'polaHealing':
      return Text(S.of(context).healing_pattern,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: BlueColor));
     case 'family':
      return Text(S.of(context).family,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: BlueColor));
     case 'kebutuhan':
      return Text(S.of(context).kebutuhan,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: BlueColor));
     case 'finansial':
      return Text(S.of(context).financial,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: BlueColor));
    default:
      return Text(S.of(context).tipe_tidak_dikenali,
          style: TextStyle(fontSize: 18, color: Colors.red));
  }
}

Widget _getImage(String type) {
  switch (type) {
    case 'tipeKaya':
      return Image.asset('images/tipeKaya17.png', height: 100);
    case 'tipeOtak':
      return Image.asset('images/tipeOtak17.png', height: 100);
    case 'personality':
      return Image.asset('images/personality17.png', height: 100);
     case 'karir':
      return SizedBox();
     case 'polaBahagia':
       return SizedBox();
     case 'polaInteraksi':
       return SizedBox();
     case 'family':
       return SizedBox();
     case 'kebutuhan':
       return SizedBox();
     case 'polaHealing':
       return SizedBox();
     case 'finansial':
       return SizedBox();
    default:
      return SizedBox();
  }
}
