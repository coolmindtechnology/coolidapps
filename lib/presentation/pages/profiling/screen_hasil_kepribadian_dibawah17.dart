import 'dart:async';
import 'package:coolappflutter/presentation/pages/profiling/results/result_under17.dart';
import 'package:coolappflutter/presentation/widgets/costum_floatingbutton.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:coolappflutter/data/helpers/check_language.dart';
import 'package:coolappflutter/data/provider/provider_profiling.dart';
import 'package:coolappflutter/data/response/profiling/res_list_profiling.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/brain/screen_brain_activition.dart';
import 'package:coolappflutter/presentation/pages/profiling/Tokoh/tokoh_page.dart';
import 'package:coolappflutter/presentation/pages/profiling/certificate_screen.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/widgets/GlobalButton.dart';
import 'package:coolappflutter/presentation/widgets/button_primary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
import 'package:coolappflutter/data/networks/endpoint/api_endpoint.dart';
import 'package:coolappflutter/data/response/profiling/res_detail_profiling.dart';
import 'package:coolappflutter/presentation/pages/profiling/results/dialog_download.dart';
import 'package:flutter/foundation.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../data/locals/preference_handler.dart';

class ScreenHasilKepribadianBawah17 extends StatefulWidget {
  final DataProfiling? data;
  const ScreenHasilKepribadianBawah17({super.key, this.data});

  @override
  State<ScreenHasilKepribadianBawah17> createState() =>
      _ScreenHasilKepribadianBawah17State();
}

class _ScreenHasilKepribadianBawah17State
    extends State<ScreenHasilKepribadianBawah17> {
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
        .getDetailProfiling(context, widget.data?.idLogResult.toString() ?? "");
    await context
        .read<ProviderProfiling>()
        .getShowProfiling(context, widget.data?.idLogResult.toString() ?? "");
  }

  @override
  void initState() {
    initLoad();
    flutterTts = FlutterTts();
    initSetting();
    _progress();
    // initSettings();

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
    return Consumer<ProviderProfiling>(builder: (context, value, child) {
      bool isLoading = value.isShowDetail == true || value.isDetail == true;
      return PopScope(
        onPopInvoked: (didPop) {
          _stop();
          // return Future.value(false);
        },
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              S.of(context).calculation_results,
              style: const TextStyle(color: Colors.white),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: primaryColor,
          ),
          body: Container(
            color: isLoading ? Colors.white : Color(0xFF93F1FB),
            child: SingleChildScrollView(
              child: isLoading
                  ? Column(
                      children: [
                        shimmerContainer(height: 250, width: double.infinity),
                        gapH20,
                        shimmerButton(),
                        gapH10,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(child: shimmerButton()),
                            gapW10,
                            Expanded(child: shimmerButton()),
                          ],
                        ),
                        gapH32,
                        shimmerButton(),
                        gapH10,
                        shimmerIconRow(),
                        gapH20,
                        shimmerButton(),
                        gapH32,
                        shimmerButton(),
                        gapH10,
                        shimmerIconRow(),
                        gapH20,
                        shimmerButton(),
                        gapH32,
                        shimmerButton(),
                        gapH10,
                        shimmerContainer(width: double.infinity, height: 200)
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          color: _getColorForContainer(
                              value.dataShowDetail?.result ?? ""),
                          child: Column(
                            children: [
                              gapH20,
                              Text(
                                value.dataShowDetail?.name ??
                                    "No Name", // Jika null, tampilkan default
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: _getColorForType(
                                      value.dataShowDetail?.result),
                                ),
                              ),
                              gapH20,
                              Container(
                                height: 130,
                                width: 130,
                                decoration: BoxDecoration(
                                    color: lightBlue,
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        color: _getColorForType(
                                            value.dataShowDetail?.result))),
                                child: Padding(
                                  padding: const EdgeInsets.all(3),
                                  child: Image.network(
                                    value.dataShowDetail?.imagetypebrain ?? "",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              gapH10,
                              Text(
                                S.of(context).pesan_selamat,
                                maxLines: 2,
                                style: TextStyle(fontSize: 14),
                              ),
                              gapH10,
                              Container(
                                decoration: BoxDecoration(
                                  color: _getColorForType(
                                      value.dataShowDetail?.result),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 120,
                                      left: 120,
                                      bottom: 10,
                                      top: 10),
                                  child: Text(
                                    value.dataShowDetail?.result ?? "",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              gapH20,
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                GlobalButton(
                                  onPressed: () async {
                                    String? isLanguage =
                                        await PreferenceHandler.retrieveId();
                                    String? isID = await PreferenceHandler
                                        .retrieveIdLanguage();
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
                                                widget.data?.idLogResult
                                                        .toString() ??
                                                    "",
                                                "$isLanguage=$isID"),
                                            name:
                                                "${widget.data?.profilingName}_CoolProfiling_Result.pdf",
                                          );
                                        });
                                  },
                                  color: primaryColor,
                                  text: S.of(context).download_result,
                                  icon: Image.asset(
                                    'images/icDownload.png',
                                    width: 30.sp,
                                  ),
                                ),
                                gapH20,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceEvenly, // Agar tombol rata
                                  children: [
                                    // Tombol Reset
                                    Expanded(
                                      child: GlobalButton(
                                        onPressed: () {
                                          Nav.to(CertificateScreen(
                                            data: widget.data,
                                            shareCode: value.dataShowDetail
                                                    ?.shareCode ??
                                                "",
                                            isUnder17: true,
                                          ));
                                        },
                                        color: Colors.green,
                                        text: S.of(context).certificate,
                                        icon: Image.asset(
                                            'images/icCerfificate.png'),
                                      ),
                                    ),

                                    SizedBox(width: 10), // Spasi antar tombol
                                    // Tombol Simpan
                                    Expanded(
                                      child: GlobalButton(
                                        onPressed: () {
                                          Nav.to(ScreenBrainActivation(
                                              widget.data,
                                              value.dataShowDetail?.idResult
                                                      .toString() ??
                                                  ""));
                                        },
                                        color: Colors.red,
                                        icon: Image.asset('images/icBrain.png'),
                                        text: S.of(context).brain,
                                      ),
                                    ),
                                  ],
                                ),
                                gapH20,
                                if (value.dataShowDetail?.consultationQuota ==
                                    'show')
                                  GlobalButton(
                                    onPressed: () {},
                                    color: Colors.white,
                                    text: S.of(context).free_consultation,
                                    textStyle: TextStyle(color: Colors.black),
                                    icon: Image.asset(
                                      'images/ickonsultasigratis.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        gapH20,
                        CostumeContainer(
                            containerColor: Colors.white,
                            title: S.of(context).ajakan_mengenal_diri,
                            titleColor: BlueColor),
                        gapH10,
                        Container(
                          color: Color(0xFF93F1FB),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CustomIconButton(
                                  onTap: () {
                                    Nav.to(ResultDetailUnder17(
                                      data: widget.data,
                                      type: 'tipeKaya',
                                    ));
                                  },
                                  imagePath: 'images/tipeKaya17.png',
                                  text: S.of(context).wealth_type,
                                ),
                                gapW10,
                                CustomIconButton(
                                  onTap: () {
                                    Nav.to(ResultDetailUnder17(
                                      data: widget.data,
                                      type: 'tipeOtak',
                                    ));
                                  },
                                  imagePath: 'images/tipeOtak17.png',
                                  text: S.of(context).brain_type,
                                ),
                                gapW10,
                                CustomIconButton(
                                  onTap: () {
                                    Nav.to(ResultDetailUnder17(
                                      data: widget.data,
                                      type: 'personality',
                                    ));
                                  },
                                  imagePath: 'images/personality17.png',
                                  text: S.of(context).personality,
                                ),
                              ],
                            ),
                          ),
                        ),
                        gapH32,
                        Container(
                          color: Colors.white,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                CostumeContainer(
                                  title: S.of(context).profil_mirip,
                                  containerColor: primaryColor,
                                  titleColor: Colors.white,
                                ),
                                gapH20,
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 100,
                                      child: Row(
                                        children: [
                                          ...List.generate(
                                            (value.detailProfiling?.publicFigure
                                                            ?.length ??
                                                        0) >
                                                    3
                                                ? 3
                                                : (value
                                                        .detailProfiling
                                                        ?.publicFigure
                                                        ?.length ??
                                                    0),
                                            (index) {
                                              PublicFigure publicFigure = value
                                                  .detailProfiling!
                                                  .publicFigure![index];
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .only(
                                                          right:
                                                              5), // Jarak antar elemen
                                                      child: CircleAvatar(
                                                        radius: 30,
                                                        backgroundColor:
                                                            Colors.white,
                                                        backgroundImage:
                                                            NetworkImage(
                                                                "${publicFigure.image}"),
                                                      ),
                                                    ),
                                                    gapH10,
                                                    SizedBox(
                                                        width: 80,
                                                        child: Text(
                                                          "${publicFigure.name}",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                              color: BlueColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ))
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                          // Ganti lingkaran ke-4 menjadi Container
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  if (value.detailProfiling
                                                              ?.publicFigure !=
                                                          null &&
                                                      value
                                                          .detailProfiling!
                                                          .publicFigure!
                                                          .isNotEmpty) {
                                                    Nav.to(TokohPage(
                                                      publicFigures: value
                                                          .detailProfiling!
                                                          .publicFigure!,
                                                      isUnder17: true,
                                                    ));
                                                  }
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15),
                                                  child: Container(
                                                    width:
                                                        65, // Ukuran sesuai kebutuhan
                                                    height: 65,
                                                    decoration: BoxDecoration(
                                                      color: Colors
                                                          .blue, // Warna latar belakang
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100), // Bisa diubah ke bentuk lain
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          ' ${value.detailProfiling?.publicFigure?.length.toString()}' +
                                                              ' +',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        Text(
                                                          S.of(context).figures,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 6,
                                              ),
                                              Text(S.of(context).see_all,
                                                  style: TextStyle(
                                                      color: BlueColor,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                  overflow:
                                                      TextOverflow.ellipsis)
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        gapH32,
                        CostumeContainer(
                            containerColor: Colors.white,
                            title: S.of(context).profil_mirip,
                            titleColor: BlueColor),
                        gapH20,
                        Center(
                          child: Container(
                            width: 350,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 8),
                                Table(
                                  border: TableBorder.all(
                                      color: Colors.grey.shade300),
                                  columnWidths: const {
                                    0: FlexColumnWidth(1.5),
                                    1: FlexColumnWidth(2),
                                  },
                                  children: [
                                    _buildTableRow(S.of(context).tipe_pola, S.of(context).kata_kunci,
                                        isHeader: true),
                                    _buildTableRow(
                                        S.of(context).motivasi,
                                        value.detailProfiling?.keyUnderAge
                                                ?.motivasi ??
                                            "kosong"),
                                    _buildTableRow(
                                        S.of(context).karakter,
                                        value.detailProfiling?.keyUnderAge
                                                ?.karakter ??
                                            "kosong"),
                                    _buildTableRow(
                                        S.of(context).kelebihan,
                                        value.detailProfiling?.keyUnderAge
                                                ?.kelebihan ??
                                            "kosong"),
                                    _buildTableRow(
                                        S.of(context).kelemahan,
                                        value.detailProfiling?.keyUnderAge
                                                ?.kelemahan ??
                                            "kosong"),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
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
                    onPress: () async {
                      // debugPrint("cek audio${value.textToSpeech}");
                      List<dynamic> languages = await flutterTts.getLanguages;
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
                  SizedBox(),
                ],
              ],
            ),
          ),
          floatingActionButton: const CustomFAB(),
        ),
      );
    });
  }

  Color _getColorForType(String type) {
    switch (type) {
      case 'EMOTION IN':
      case 'EMOTION OUT':
        return Colors.green;
      case 'LOGIC IN':
      case 'LOGIC OUT':
        return Colors.yellow;
      case 'MASTER':
        return Colors.black;
      case 'CREATIVE IN':
      case 'CREATIVE OUT':
        return Colors.orange;
      case 'ACTION IN':
      case 'ACTION OUT':
        return Colors.red;
      default:
        return Colors.grey; // Warna default jika type tidak cocok
    }
  }

  Color _getColorForContainer(String type) {
    switch (type) {
      case 'EMOTION IN':
      case 'EMOTION OUT':
        return Colors.green.shade100;
      case 'LOGIC IN':
      case 'LOGIC OUT':
        return Colors.yellow.shade100;
      case 'MASTER':
        return Colors.grey;
      case 'CREATIVE IN':
      case 'CREATIVE OUT':
        return Colors.orange.shade100;
      case 'ACTION IN':
      case 'ACTION OUT':
        return Colors.red.shade100;
      default:
        return Colors.grey; // Warna default jika type tidak cocok
    }
  }
}

class CustomIconButton extends StatelessWidget {
  final VoidCallback onTap;
  final String imagePath;
  final String text;

  const CustomIconButton({
    Key? key,
    required this.onTap,
    required this.imagePath,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Image.asset(imagePath),
          ),
          SizedBox(
              width: 80,
              child: Text(
                text,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 12.sp,
                    color: BlueColor,
                    fontWeight: FontWeight.bold),
              ))
        ],
      ),
    );
  }
}

Widget shimmerContainer({double height = 50, double width = double.infinity}) {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
    ),
  );
}

Widget shimmerButton() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}

Widget shimmerIconRow() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children:
        List.generate(4, (index) => shimmerContainer(height: 50, width: 50)),
  );
}

class CostumeContainer extends StatelessWidget {
  final Color containerColor;
  final String title;
  final Color titleColor;

  const CostumeContainer({
    Key? key,
    required this.containerColor,
    required this.title,
    required this.titleColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 40, left: 40),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: containerColor,
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Center(
            child: Text(
              title,
              style: TextStyle(color: titleColor),
            ),
          ),
        ),
      ),
    );
  }
}

TableRow _buildTableRow(String title, String value, {bool isHeader = false}) {
  return TableRow(
    decoration: BoxDecoration(
      color: isHeader ? Colors.lightBlue.shade200 : Colors.transparent,
    ),
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          title,
          style: TextStyle(
            fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          value,
        ),
      ),
    ],
  );
}
