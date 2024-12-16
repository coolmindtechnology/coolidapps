import 'dart:async';
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
  const ResultDetail({super.key, this.data});

  @override
  State<ResultDetail> createState() => _ResultDetailState();
}

class _ResultDetailState extends State<ResultDetail> {
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
        .getDetailProfiling(context, widget.data?.idLogResult.toString() ?? "");
  }

  @override
  void initState() {
    initLoad();
    initSetting();
    _progress();

    super.initState();
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
    return Consumer<ProviderProfiling>(
      builder: (context, value, child) {
        return PopScope(
          onPopInvoked: (didPop) {
            _stop();
            // return Future.value(false);
          },
          child: Scaffold(
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
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (value.detailProfiling?.tipeAura != null) ...[
                          _TipeAura(value: value),
                        ],
                        if (value.detailProfiling?.tipeOtak != null) ...[
                          _TipeOtak(value: value),
                        ],
                        if (value.detailProfiling?.tipeKaya != null) ...[
                          _TipeKaya(value: value),
                        ],
                        if (value.detailProfiling?.tipeDarah != null) ...[
                          _TipeDarah(value: value),
                        ],
                        if (value.detailProfiling?.personality != null) ...[
                          _Personality(value: value),
                        ],

                        // Center(
                        //   child: Image.asset(
                        //     "assets/images/cool-result-4.png",
                        //   ),
                        // ),
                        if (value.detailProfiling?.publicFigure != null) ...[
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 16),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    S.of(context).type_figure(
                                        value.detailProfiling?.character ?? ""),
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width - 48,
                                    child: GridView.builder(
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 5,
                                              mainAxisExtent: 100),
                                      itemCount: value.detailProfiling
                                          ?.publicFigure?.length,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        PublicFigure publicFigure = value
                                            .detailProfiling!
                                            .publicFigure![index];
                                        return InkWell(
                                          onTap: () {
                                            // Nav.to(const RelatedFigure());
                                          },
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              CircleAvatar(
                                                  radius: 30,
                                                  backgroundImage: NetworkImage(
                                                    "${publicFigure.image}",
                                                  )),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                "${publicFigure.name}",
                                                style: const TextStyle(
                                                  fontSize: 10,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ]),
                          ),
                        ]
                      ],
                    ),
                  ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 54,
                    child: ButtonPrimary(
                      isPlay
                          ? S.of(context).pause_audio
                          : S.of(context).play_audio,
                      onPress: () {
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
                              backgroundColor: greyColor.withOpacity(0.5),
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
                      height: 54,
                      child: ButtonPrimary(
                        S.of(context).download,
                        onPress: () async {
                          String? isLanguage =
                              await PreferenceHandler.retrieveId();
                          String? isID =
                              await PreferenceHandler.retrieveIdLanguage();
                          // showDialog(
                          //     context: context,
                          //     barrierDismissible: false,
                          //     builder: (dialogcontext) {
                          //       return DownloadProgressDialog(
                          //           url: ApiEndpoint.donwnloadDetailPdf(
                          //               widget.data?.idLogResult ?? ""),
                          //           name:
                          //               "${widget.data?.profilingName}_CoolProfiling_Result.pdf");
                          //     });
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
                                debugPrint(
                                    "url pdf ${ApiEndpoint.donwnloadDetailPdf(widget.data?.idLogResult.toString(), "$isLanguage=$isID")}");
                                return DownloadProgressDialog(
                                  url: ApiEndpoint.donwnloadDetailPdf(
                                      widget.data?.idLogResult.toString() ?? "",
                                      "$isLanguage=$isID"),
                                  name:
                                      "${widget.data?.profilingName}_CoolProfiling_Result.pdf",
                                );
                              });
                        },
                        expand: true,
                        negativeColor: true,
                        border: 1,
                        radius: 10,
                        imageLeft: Row(
                          children: [
                            Image.asset(
                              "assets/icons/download.png",
                              width: 24,
                            ),
                            const SizedBox(
                              width: 8,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
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
              style: TextStyle(color: brownColor, fontSize: 10),
            ),
          )),
          const VerticalDivider(),
          Expanded(
              child: Container(
            padding: const EdgeInsets.all(8),
            child: Text(
              "$kataKunci",
              style: TextStyle(color: brownColor, fontSize: 10),
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
        Center(
          child: Image.network(
            "${value.detailProfiling?.personality?.picture}",
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).personality,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              Text(
                value.detailProfiling?.personality?.description ?? "",
                textAlign: TextAlign.justify,
                style: TextStyle(color: greyColor, fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
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
        Center(
          child: Image.network(
            "${value.detailProfiling?.tipeOtak?.picture}",
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${S.of(context).brain_type} ",
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              Text(
                value.detailProfiling?.tipeOtak?.description ?? "",
                textAlign: TextAlign.justify,
                style: TextStyle(color: greyColor, fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
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
        Center(
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${S.of(context).aura_type}  - ${value.detailProfiling?.tipeAura?.tipe ?? ""}",
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              Text(
                value.detailProfiling?.tipeAura?.description ?? "",
                textAlign: TextAlign.justify,
                style: TextStyle(color: greyColor, fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
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
        Center(
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${S.of(context).rich_type} - ${value.detailProfiling?.tipeKaya?.tipe ?? ""}",
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              Text(
                value.detailProfiling?.tipeKaya?.description ?? "",
                textAlign: TextAlign.justify,
                style: TextStyle(color: greyColor, fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
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
        Center(
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${S.of(context).blood_type} - ${value.detailProfiling?.tipeDarah?.tipe ?? ""}",
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              Text(
                value.detailProfiling?.tipeDarah?.description ?? "",
                textAlign: TextAlign.justify,
                style: TextStyle(color: greyColor, fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
