// ignore_for_file: library_private_types_in_public_api, deprecated_member_use

import 'dart:async';
import 'package:coolappflutter/data/data_global.dart';
import 'package:coolappflutter/data/models/subcribtion_brain_transaction_data_model.dart';
import 'package:coolappflutter/data/networks/endpoint/api_endpoint.dart';
import 'package:coolappflutter/data/provider/provider_brain_activation.dart';
import 'package:coolappflutter/data/response/brain_activation/res_list_brain_activation.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/utils/notification_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:music_visualizer/music_visualizer.dart';
import 'package:provider/provider.dart';

class PlayMusicScreen extends StatefulWidget {
  final Function? onAudio;
  final DataBrain? data;
  const PlayMusicScreen(this.data, {super.key, this.onAudio});

  @override
  _PlayMusicScreenState createState() => _PlayMusicScreenState();
}

class _PlayMusicScreenState extends State<PlayMusicScreen> {
  final prov = ProviderBrainActivation();
  StreamSubscription<Duration>? durationChangedStream;
  StreamSubscription<Duration>? positionChangedStream;

  /// for initialization last state
  bool isSought = false;
  int lastPlayedSecond = 0; // should save to session when stopped
  /// Daily maximum play in time
  int playedSecond = 0; // should save to session when stopped
  int maxPlaySecond = 60 * 5; // provided by api
  bool get shouldStop => playedSecond >= maxPlaySecond;

  /// Daily maximum play in a day
  int totalPlayedToday = 0; // provided by api
  int totalPlayMaximal = 50;
  bool get canPlayAgain => totalPlayedToday < totalPlayMaximal;

  bool isFree = false;

  late AudioPlayer _audioPlayer;

  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  final List<Color> colors = [
    Colors.red[900]!,
    Colors.green[900]!,
    Colors.blue[900]!,
    Colors.brown[900]!
  ];

  final List<int> duration = [900, 700, 600, 800, 500];
  bool isPlay = false;
  playOrPause() async {
    if (isPlay) {
      await pause();
    } else {
      await play();
    }
    setState(() {
      isPlay = !isPlay;
    });
  }

  play() {
    if (!canPlayAgain) {
      if (kDebugMode) {
        print("You have already reached maximum daily quota");
      }
      return;
    }

    /// to restore last session
    if (!isSought) {
      _audioPlayer.seek(Duration(seconds: lastPlayedSecond));
      isSought = true;
    }

    /// reset total played
    playedSecond = 0;

    /// increase number of played today
    totalPlayedToday++;

    _audioPlayer.play(UrlSource("${widget.data?.upload}"));
  }

  pause() {
    lastPlayedSecond = _position.inSeconds;
    _audioPlayer.pause();
  }

  setSource() async {
    await _audioPlayer.setSourceUrl("${widget.data?.upload}");
  }

  @override
  void initState() {
    _audioPlayer = AudioPlayer();
    setSource();
    context
        .read<ProviderBrainActivation>()
        .getCekDaily(context, widget.data?.logBrain?.id?.toInt() ?? 0);
    prov.getDurationAudio(context, widget.data?.logBrain?.id ?? 0);

    _audioPlayer.getDuration().then((d) {
      _duration = d ?? Duration.zero;
    });

    durationChangedStream = _audioPlayer.onDurationChanged.listen((Duration d) {
      setState(() {
        _duration = d;
      });
    });
    positionChangedStream = _audioPlayer.onPositionChanged.listen((Duration p) {
      _position = p;
      playedSecond = _position.inSeconds - lastPlayedSecond;
      if (shouldStop) {
        isPlay = false;
        pause();
        if (context
                .read<ProviderBrainActivation>()
                .cekDaily
                ?.limitAccessAudio
                .toString() ==
            "00:05:00") {
          // prov.getDurationAudio(context, widget.data?.logBrain?.id ?? 0);
          NotificationUtils.showSimpleDialogAudio(
              context, S.of(context).free_version_limit,
              textButton1: S.of(context).yes,
              textButton2: S.of(context).cancel, onPress2: () {
            Nav.back();
            Nav.back();
          }, onPress1: () async {
            //   // tambah disni
            Nav.back();
            var data = SubscribeBrainTransactionDataModel(
                idBrainActivations: [widget.data?.id ?? 0],
                idLogProfiling: int.parse(
                    widget.data?.logBrain?.idLogProfiling.toString() ?? "0"),
                discount:
                    double.parse(widget.data?.monthlyDiscount ?? "0").toInt(),
                transactionType: "monthly",
                subscriptionType: "single",
                idItemPayments: "3",
                price: double.parse(widget.data?.monthlyPrice ?? "0").toInt(),
                gateway: !dataGlobal.isIndonesia ? "paypal" : null);

            context
                .read<ProviderBrainActivation>()
                .subcribeBrainProfiling(context, data, onUpdate: () async {
              Nav.back();
              // Nav.back();
              await context.read<ProviderBrainActivation>().getListBrain(
                  context,
                  widget.data?.logBrain?.idLogProfiling.toString() ?? "0");
            });
          });
        }
      }

      setState(() {});
    });

    _audioPlayer.onPlayerComplete.listen((event) {
      isPlay = false;
      // prov.getDurationAudio(context, widget.data?.logBrain?.id ?? 0);
      setState(() {});
    });

    playMusic();
    super.initState();
  }

  playMusic() async {
    isPlay = true;
    await play();
    Timer(const Duration(seconds: 3), () async {
      isPlay = false;
      await pause();
      setState(() {});
    });

    setState(() {});
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    durationChangedStream?.cancel();
    positionChangedStream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderBrainActivation>(builder: (context, value, child) {
      return WillPopScope(
        onWillPop: () async {
          widget.onAudio!();
          Nav.back();
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              '${widget.data?.name}',
              style: TextStyle(color: whiteColor),
            ),
          ),
          body: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 54,
                ),
                Image.asset(
                  "assets/images/music_image.png",
                  width: 200,
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  "${widget.data?.name}",
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "Relaxing",
                  style: TextStyle(fontSize: 12, color: greyColor),
                ),
                const SizedBox(
                  height: 24,
                ),
                isPlay
                    ? MusicVisualizer(
                        barCount: 30,
                        colors: colors,
                        duration: duration,
                      )
                    : const SizedBox(),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: StreamBuilder(
                      stream: _audioPlayer.onPositionChanged,
                      builder: (context, snapshot) {
                        return ProgressBar(
                          progress: snapshot.data ?? const Duration(seconds: 0),
                          total: _duration,
                          onSeek: (duration) {
                            debugPrint("cek posisi1 ${_position.inSeconds}");
                            if (value.cekDaily?.limitAccessAudio.toString() ==
                                    "00:05:00" &&
                                (snapshot.data?.inSeconds == maxPlaySecond ||
                                    snapshot.data!.inSeconds > maxPlaySecond)) {
                              NotificationUtils.showSimpleDialog2(
                                  context, S.of(context).free_version_limit,
                                  textButton1: S.of(context).yes,
                                  textButton2: S.of(context).cancel,
                                  onPress2: () {
                                Nav.back();
                                Nav.back();
                              }, onPress1: () async {
                                //   // tambah disni
                                Nav.back();
                                Nav.back();
                                var data = SubscribeBrainTransactionDataModel(
                                    idBrainActivations: [widget.data?.id ?? 0],
                                    idLogProfiling: int.parse(widget
                                            .data?.logBrain?.idLogProfiling
                                            .toString() ??
                                        "0"),
                                    discount: double.parse(
                                            widget.data?.monthlyDiscount ?? "0")
                                        .toInt(),
                                    transactionType: "monthly",
                                    subscriptionType: "single",
                                    idItemPayments: "3",
                                    price: double.parse(
                                            widget.data?.monthlyPrice ?? "0")
                                        .toInt(),
                                    gateway: !dataGlobal.isIndonesia
                                        ? "paypal"
                                        : null);

                                context
                                    .read<ProviderBrainActivation>()
                                    .subcribeBrainProfiling(context, data,
                                        onUpdate: () async {
                                  Nav.back();
                                  // Nav.back();
                                  await context
                                      .read<ProviderBrainActivation>()
                                      .getListBrain(
                                          context,
                                          widget.data?.logBrain?.idLogProfiling
                                                  .toString() ??
                                              "0");
                                });
                              });
                            } else {
                              _audioPlayer.seek(duration);
                            }

                            setState(() {});
                          },
                          baseBarColor: greyColor.withOpacity(0.5),
                          progressBarColor: primaryColor,
                          thumbColor: primaryColor,
                        );
                      }),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 54, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    debugPrint("cek posisi4 ${_position.inSeconds}");
                    if (_position > Duration.zero) {
                      _audioPlayer
                          .seek(_position - const Duration(seconds: 10));
                    }
                  },
                  child: Image.asset(
                    "assets/icons/foundation_back.png",
                    width: 24,
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    debugPrint("cek posisi2 ${_position.inSeconds}");
                    if ((int.tryParse(value.cekDaily?.dailyCount.toString() ??
                                    "0") ??
                                0) !=
                            3 ||
                        value.timerPlay?.dailyCount != null) {
                      if (value.cekDaily?.limitAccessAudio.toString() ==
                              "00:05:00" &&
                          shouldStop) {
                        NotificationUtils.showSimpleDialog2(
                            context, S.of(context).free_version_limit,
                            textButton1: S.of(context).yes,
                            textButton2: S.of(context).cancel, onPress2: () {
                          Nav.back();
                          Nav.back();
                        }, onPress1: () async {
                          //   // tambah disni
                          Nav.back();
                          var data = SubscribeBrainTransactionDataModel(
                              idBrainActivations: [widget.data?.id ?? 0],
                              idLogProfiling: int.parse(widget
                                      .data?.logBrain?.idLogProfiling
                                      .toString() ??
                                  "0"),
                              discount: double.parse(
                                      widget.data?.monthlyDiscount ?? "0")
                                  .toInt(),
                              transactionType: "monthly",
                              subscriptionType: "single",
                              idItemPayments: "3",
                              price:
                                  double.parse(widget.data?.monthlyPrice ?? "0")
                                      .toInt(),
                              gateway:
                                  !dataGlobal.isIndonesia ? "paypal" : null);

                          context
                              .read<ProviderBrainActivation>()
                              .subcribeBrainProfiling(context, data,
                                  onUpdate: () async {
                            Nav.back();
                            // Nav.back();
                            await context
                                .read<ProviderBrainActivation>()
                                .getListBrain(
                                    context,
                                    widget.data?.logBrain?.idLogProfiling
                                            .toString() ??
                                        "0");
                          });
                        });
                      } else {
                        playOrPause();
                      }
                    } else {
                      if (isPlay == true) {
                        playOrPause();
                      } else {
                        // get check daily
                        // prov.getCekDaily(
                        //   context,
                        //   widget.data?.logBrain?.id ?? 0,
                        // );

                        NotificationUtils.showDialogError(context, () {
                          Nav.back();
                        },
                            widget: Text(
                              S.of(context).daily_limit_reached,
                              textAlign: TextAlign.center,
                            ));
                      }
                    }
                  },
                  child: Image.asset(
                    isPlay
                        ? "assets/icons/heroicons-outline_pause.png"
                        : "assets/icons/play.png",
                    color: blackColor,
                    width: 50,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    debugPrint("cek posisi3 ${_position.inSeconds}");
                    if (_position < _duration) {
                      _audioPlayer
                          .seek(_position + const Duration(seconds: 10));
                    }
                  },
                  child: Image.asset(
                    "assets/icons/foundation_next.png",
                    width: 24,
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
