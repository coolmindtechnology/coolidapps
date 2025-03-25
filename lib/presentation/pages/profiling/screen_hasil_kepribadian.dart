import 'dart:async';
import 'package:coolappflutter/presentation/widgets/costum_floatingbutton.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:coolappflutter/data/helpers/check_language.dart';
import 'package:coolappflutter/data/provider/provider_profiling.dart';
import 'package:coolappflutter/data/response/profiling/res_list_profiling.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/Normal_User/konsultasi_page.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/Normal_User/new_konsultasi.dart';
import 'package:coolappflutter/presentation/pages/brain/screen_brain_activition.dart';
import 'package:coolappflutter/presentation/pages/profiling/Tokoh/tokoh_page.dart';
import 'package:coolappflutter/presentation/pages/profiling/certificate_screen.dart';
import 'package:coolappflutter/presentation/pages/profiling/menu_Tentang_Profil.dart';
import 'package:coolappflutter/presentation/pages/profiling/results/result_detail.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/circular_progress_widget.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/widgets/GlobalButton.dart';
import 'package:coolappflutter/presentation/widgets/button_primary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
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
import 'package:shimmer/shimmer.dart';

import '../../../../data/locals/preference_handler.dart';

class ScreenHasilKepribadian extends StatefulWidget {
  final DataProfiling? data;
  const ScreenHasilKepribadian({super.key, this.data});

  @override
  State<ScreenHasilKepribadian> createState() => _ScreenHasilKepribadianState();
}

class _ScreenHasilKepribadianState extends State<ScreenHasilKepribadian> {
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
    return Consumer<ProviderProfiling>(
          builder: (context, value, child) {
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
                body: Padding(
                  padding: const EdgeInsets.only(
                      bottom: 20, top: 20, left: 20, right: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                      if (value.dataShowDetail != null)
                        isLoading ? shimmerContainer(height: 70) : Container(
                  height: 70,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: lightBlue,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: borderBlue),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image.asset(
                        //   'images/add_icon.png',
                        //   fit: BoxFit.cover,
                        //   height: 50,
                        // ),
                        // gapW20,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              value.dataShowDetail?.name ?? "No Name", // Jika null, tampilkan default
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Text(
                              value.dataShowDetail?.birthDate ?? "No Date", // Jika null, tampilkan default
                              style: TextStyle(color: Colors.black54),
                            ),
                          ],
                        ),
                        Spacer(),
                        // Text(
                        //   '12/01/2024',
                        //   style: TextStyle(color: Colors.black54),
                        // ),
                      ],
                    ),
                  ),
                )
                  else
                  SizedBox(), // Jika null, tampilkan widget kosong
              gapH20,
                        isLoading ? shimmerContainer(height: 130, width: 130) : Row(
                          children: [
                            Container(
                              height: 130,
                              width: 130,
                              decoration: BoxDecoration(
                                  color: lightBlue,
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: _getColorForType(value.dataShowDetail?.result))),
                              child: Padding(
                                padding: const EdgeInsets.all(3),
                                child: Image.network(value.dataShowDetail?.imagetypebrain ?? "",fit: BoxFit.cover,),
                              ),
                            ),
                            gapW20,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    S.of(context).congratulationsYou,
                                    maxLines: 2,
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  gapH10,
                                  Text(
                                    value.dataShowDetail?.result ?? "",
                                    style: TextStyle(
                                        color: _getColorForType(value.dataShowDetail?.result),
                                        fontWeight: FontWeight.bold,),
                                  ),
                                  gapH10,
                                  GlobalButton(
                                    onPressed : () async {
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
                                    color: primaryColor,
                                    text: S.of(context).download_result,
                                    icon: Image.asset('images/icDownload.png',width: 30.sp,),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        gapH32,
                        isLoading ? shimmerButton() : Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceEvenly, // Agar tombol rata
                          children: [
                            // Tombol Reset
                            Expanded(
                              child: GlobalButton(
                                onPressed: () {
                                  Nav.to(CertificateScreen(
                                      data: widget.data,
                                      shareCode: value.dataShowDetail?.shareCode ?? "",isUnder17: false,));
                                },
                                color: Colors.green,
                                text: S.of(context).certificate,
                                icon: Image.asset('images/icCerfificate.png'),
                              ),
                            ),

                            SizedBox(width: 10), // Spasi antar tombol
                            // Tombol Simpan
                            Expanded(
                              child: GlobalButton(
                                onPressed: () {
                                  Nav.to(ScreenBrainActivation(
                                      widget.data,
                                      value.dataShowDetail?.idResult.toString() ??
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
                        if (value.dataShowDetail?.consultationQuota == 'show')
                        isLoading ? shimmerButton() :InkWell(
                          onTap: () {
                            Nav.to(NewKonsultasi());
                          },
                          child: Row(
                            children: [
                              Image.asset(
                                'images/ickonsultasigratis.png',
                                fit: BoxFit.cover,
                                width: 50,
                              ),
                              gapW20,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    S.of(context).free_consultation,
                                    style: TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    width: 300,
                                    child: Text(
                                        S.of(context).free_consultation_details,maxLines: 2,overflow: TextOverflow.ellipsis,),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        gapH20,
                        Text(
                          S.of(context).about_your_profile,
                          style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        gapH10,
                        isLoading ? shimmerButton() : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomIconButton(
                              onTap: () {
                                Nav.to(ResultDetail(data: widget.data,type: 'tipeKaya',));
                              },
                              imagePath: 'images/profiling/icTipeKaya.png',
                              text: S.of(context).wealth_type,
                            ),
                            gapW10,
                            CustomIconButton(
                              onTap: () {
                                Nav.to(ResultDetail(data: widget.data,type: 'tipeOtak',));
                              },
                              imagePath: 'images/profiling/icTipeOtak.png',
                              text: S.of(context).brain_type,
                            ),
                            gapW10,
                            CustomIconButton(
                              onTap: () {Nav.to(ResultDetail(data: widget.data,type: 'personality',));},
                              imagePath: 'images/profiling/icPersonality.png',
                              text: S.of(context).personality,
                            ),
                            gapW10,
                            CustomIconButton(
                              onTap: () { Nav.to(ResultDetail(data: widget.data, type: 'family'));},
                              imagePath: 'images/profiling/icFamily.png',
                              text: S.of(context).family,
                            ),
                          ],
                        ),
                        gapH10,
                        isLoading ? shimmerButton(): Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomIconButton(
                              onTap: () {Nav.to(ResultDetail(data: widget.data, type: 'polaBahagia'));},
                              imagePath: 'images/profiling/icPolaBahagia.png',
                              text: S.of(context).happiness_pattern,
                            ),
                            gapW10,
                            CustomIconButton(
                              onTap: () {Nav.to(ResultDetail(data: widget.data, type: 'karir'));},
                              imagePath: 'images/profiling/icKarir.png',
                              text: S.of(context).career,
                            ),
                            gapW10,
                            CustomIconButton(
                              onTap: () {Nav.to(ResultDetail(data: widget.data, type: 'polaBahagia'));},
                              imagePath: 'images/profiling/icPolaInteraksi.png',
                              text: S.of(context).social_interaction_pattern,
                            ),
                            gapW10,
                            CustomIconButton(
                              onTap: () {Nav.to(MenuTentangProfil(data: widget.data,));},
                              imagePath: 'images/profiling/icLainnya.png',
                              text: S.of(context).others,
                            ),
                          ],
                        ),
                        gapH20,
                        Text(S.of(context).figures,style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                          gapH10,
                          InkWell(
                            onTap: () {
                              if (value.detailProfiling?.publicFigure != null &&
                              value.detailProfiling!.publicFigure!.isNotEmpty) {
                              Nav.to(TokohPage(publicFigures: value.detailProfiling!.publicFigure!,isUnder17: false,));
                              }
                              },
                            child: isLoading  ? shimmerIconRow() : Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 40,
                                  width: 70,// Sesuaikan dengan tinggi lingkaran
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: List.generate(
                                      (value.detailProfiling?.publicFigure?.length ?? 0) > 3
                                          ? 3
                                          : (value.detailProfiling?.publicFigure?.length ?? 0), // Ambil maksimal 3 data
                                          (index) {
                                        PublicFigure publicFigure =
                                        value.detailProfiling!.publicFigure![index];

                                        return Positioned(
                                          left: index * 15.0, // Mengatur jarak antar lingkaran
                                          child: CircleAvatar(
                                            radius: 15,
                                            backgroundColor: Colors.white,
                                            backgroundImage: NetworkImage("${publicFigure.image}"),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(child: Text(' ${value.detailProfiling?.publicFigure?.length.toString()}'+' '+S.of(context).figures_with_same_type,)),
                                Icon(CupertinoIcons.forward,)
                              ],
                            ),
                          ),

                        // Center(
                        //   child: Container(
                        //     alignment: Alignment.center,
                        //     height: 290,
                        //     width: 290,
                        //     decoration: BoxDecoration(
                        //       border: Border.all(
                        //           width: 20, color: primaryColor.withOpacity(0.6)),
                        //       shape: BoxShape.circle,
                        //     ),
                        //     child: Column(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       crossAxisAlignment: CrossAxisAlignment.center,
                        //       children: [
                        //         Text(
                        //           S.of(context).your_personality,
                        //           style: const TextStyle(
                        //             fontSize: 12,
                        //           ),
                        //         ),
                        //         value.isShowDetail
                        //             ? SizedBox(
                        //                 height: 60,
                        //                 child: Center(
                        //                   child: CircularProgressWidget(
                        //                     color: primaryColor,
                        //                   ),
                        //                 ),
                        //               )
                        //             : Text(
                        //                 "${value.dataShowDetail?.result}",
                        //                 textAlign: TextAlign.center,
                        //                 style: TextStyle(
                        //                     fontSize: 40,
                        //                     letterSpacing: 3,
                        //                     color: primaryColor,
                        //                     fontWeight: FontWeight.w600),
                        //               ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 15,
                        // ),
                        // Text(
                        //   "${S.of(context).congratulations} ${value.dataShowDetail?.name ?? ""}",
                        //   style: const TextStyle(
                        //     fontSize: 16,
                        //     fontWeight: FontWeight.w400,
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 25,
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 20),
                        //   child: SizedBox(
                        //     height: 54,
                        //     child: ButtonPrimary(
                        //       S.of(context).result_detail,
                        //       onPress: () {
                        //         Nav.to(ResultDetail(data: widget.data));
                        //       },
                        //       expand: true,
                        //       radius: 10,
                        //       border: 1,
                        //       elevation: 0,
                        //     ),
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 15,
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 20),
                        //   child: SizedBox(
                        //     height: 54,
                        //     child: ButtonPrimary(
                        //       S.of(context).brain_activation,
                        //       onPress: () {
                        //         Nav.to(ScreenBrainActivation(widget.data,
                        //             value.dataShowDetail?.idResult.toString() ?? ""));
                        //       },
                        //       expand: true,
                        //       radius: 10,
                        //       negativeColor: true,
                        //       border: 1,
                        //       elevation: 0,
                        //     ),
                        //   ),
                        // ),

                        // const SizedBox(
                        //   height: 16,
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 20),
                        //   child: SizedBox(
                        //     height: 54,
                        //     child: ButtonPrimary(
                        //       "${S.of(context).download} ${S.of(context).certificate}",
                        //       onPress: () {
                        //         Nav.to(CertificateScreen(
                        //             data: widget.data,
                        //             shareCode: value.dataShowDetail?.shareCode));
                        //       },
                        //       expand: true,
                        //       radius: 10,
                        //       negativeColor: true,
                        //       border: 1,
                        //       elevation: 0,
                        //     ),
                        //   ),
                        // )
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
          }
    );
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
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: lightBlue,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Image.asset(imagePath),
          ),
          SizedBox(
              width: 80,
              child: Text(text,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 12.sp),))
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
    children: List.generate(4, (index) => shimmerContainer(height: 50, width: 50)),
  );
}

