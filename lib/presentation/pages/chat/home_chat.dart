// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:io';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart' as player_state;
import 'package:cool_app/data/data_global.dart';
import 'package:cool_app/data/provider/provider_cool_chat.dart';
import 'package:cool_app/data/provider/provider_user.dart';
import 'package:cool_app/generated/l10n.dart';
import 'package:cool_app/presentation/pages/chat/audio_player.dart';
import 'package:cool_app/presentation/pages/chat/item_data.dart';
import 'package:cool_app/presentation/pages/chat/search_page.dart';
import 'package:cool_app/presentation/pages/chat/take_video_and12.dart';
import 'package:cool_app/presentation/theme/color_utils.dart';
import 'package:cool_app/presentation/utils/circular_progress_widget.dart';
import 'package:cool_app/presentation/utils/nav_utils.dart';
import 'package:cool_app/presentation/utils/notification_utils.dart';
import 'package:cool_app/presentation/utils/takeVideo_utils.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import '../../../data/models/data_post.dart';
import '../../../data/networks/endpoint/api_endpoint.dart';
import '../../utils/takeimage_utils.dart';
import '../../widgets/shimmer_loading.dart';
import 'alert_audio_vn.dart';
import 'chat_profile.dart';
import 'package:device_info_plus/device_info_plus.dart';

class HomeChat extends StatefulWidget {
  const HomeChat({super.key, required this.klickTab, required});
  final Function(int) klickTab;

  @override
  State<HomeChat> createState() => _HomeChatState();
}

class _HomeChatState extends State<HomeChat> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  bool isShare = false, isLike = false, isComment = false;

  // Future<void> pickImageWithPermission() async {
  //   PermissionStatus cameraPermissionStatus = await Permission.camera.status;
  //   PermissionStatus storagePermissionStatus = await Permission.storage.status;
  //
  //   if (cameraPermissionStatus.isGranted && storagePermissionStatus.isGranted) {
  //     // Permissions are already granted, proceed to pick file
  //   } else {
  //     Map<Permission, PermissionStatus> permissionStatuses = await [
  //       Permission.camera,
  //       Permission.storage,
  //     ].request();
  //
  //     if (permissionStatuses[Permission.camera]!.isGranted &&
  //         permissionStatuses[Permission.storage]!.isGranted) {
  //       // Permissions granted, proceed to pick file
  //     } else {
  //       // Permissions denied, handle accordingly (show an error message, request again, or emit your bloc state.)
  //       // ...
  //     }
  //   }
  // }

  String _androidVersion = 'Unknown';

  XFile? res;
  @override
  void initState() {
    // pickImageWithPermission();
    super.initState();
    _fetchAndroidVersion();
    showPlayer1 = false;
    // pickImageWithPermission();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _pengecekanIsProfiling();
    });
  }

  Future<void> _fetchAndroidVersion() async {
    String version = await getAndroidVersion();
    setState(() {
      _androidVersion = version;
    });
    print("and ver $_androidVersion");
  }

  void _pengecekanIsProfiling() async {
    context.read<ProviderUser>().getUser(context);
    if (context.read<ProviderUser>().dataUser?.isProfiling != "1") {
      NotificationUtils.showDialogError(
        context,
        () {
          widget.klickTab(0);
          Nav.back();
        },
        widget: Text(
          S.of(context).complete_profile_before_joining,
          textAlign: TextAlign.center,
        ),
        textButton: "Oke",
      );
    }
  }

  bool showPlayer1 = false;
  String? audioPath;

  @override
  void dispose() {
    super.dispose();
    // recorder.closeRecorder();
  }

  Future<String> getAndroidVersion() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo
          .version.release; // This returns the version as a string, e.g., "12"
    }
    return 'Unknown';
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return ProviderCoolChat.initPost();
      },
      child: Consumer<ProviderCoolChat>(
          builder: (BuildContext context, value, Widget? child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Coolchat".toUpperCase(),
              style: const TextStyle(color: Colors.white),
            ),
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: primaryColor,
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Nav.to(const SearchPage());
                      },
                      child: Image.asset(
                        "images/chat/search.png",
                        width: 24,
                        height: 24,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    GestureDetector(
                      onTap: () {
                        Nav.to(ChatProfile(
                          idUser: dataGlobal.dataUser?.id.toString() ?? "",
                          isMe: true,
                        ));
                      },
                      child: Image.asset(
                        "images/menu/profile.png",
                        width: 24,
                        height: 24,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          body: CustomMaterialIndicator(
            key: _refreshIndicatorKey,
            onRefresh: () {
              Provider.of<ProviderUser>(context, listen: false)
                  .getUser(context);
              value.getListPost();
              return Future<void>.delayed(const Duration(seconds: 1));
            },
            indicatorBuilder:
                (BuildContext context, IndicatorController controller) {
              return Icon(
                Icons.ac_unit,
                color: primaryColor,
                size: 30,
              );
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Card(
                    elevation: 0,
                    color: Colors.white,
                    child: Container(
                      margin: const EdgeInsets.all(12),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: greyColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          width: 1,
                          color: greyColor.withOpacity(0.2),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            controller: value.title,
                            decoration: InputDecoration(
                                hintText: S.of(context).what_to_discuss,
                                hintStyle: TextStyle(
                                    color: greyColor.withOpacity(0.5)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none)),
                          ),
                          audioPath != null
                              ? AudioPlayerVoiceNote(
                                  source: audioPath ?? "",
                                  onDelete: () {
                                    setState(() => showPlayer1 = false);
                                    audioPath = null;
                                  },
                                )
                              : const SizedBox(
                                  height: 0,
                                  width: 0,
                                ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              value.image == null
                                  ? const SizedBox(
                                      height: 0,
                                      width: 0,
                                    )
                                  : (value.imageType == "image")
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: SizedBox(
                                              width: 100,
                                              height: 100,
                                              child: Image.file(
                                                File(value.image![0].path),
                                                height: 150,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                              )),
                                        )
                                      : (value.imageType == "video") &&
                                              (value.controller?.value
                                                      .isInitialized ==
                                                  true)
                                          ? Row(
                                              children: [
                                                SizedBox(
                                                  width: 200,
                                                  height: 200,
                                                  child: AspectRatio(
                                                    aspectRatio: value
                                                        .controller!
                                                        .value
                                                        .aspectRatio,
                                                    child: VideoPlayer(
                                                        value.controller!),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      (value.controller?.value
                                                                  .isPlaying ==
                                                              true)
                                                          ? value.controller
                                                              ?.pause()
                                                          : value.controller
                                                              ?.play();
                                                    });
                                                  },
                                                  child: Icon(
                                                    (value.controller?.value
                                                                .isPlaying ==
                                                            true)
                                                        ? Icons.pause
                                                        : Icons.play_arrow,
                                                  ),
                                                ),
                                              ],
                                            )
                                          : value.image != null ||
                                                  value.title.text.isNotEmpty
                                              ? IconButton(
                                                  onPressed: () {
                                                    //ddddd
                                                    setState(() {
                                                      value.title.text = "";
                                                      value.image = null;
                                                      audioPath = null;
                                                    });
                                                  },
                                                  icon: const Icon(Icons.close))
                                              : const SizedBox(
                                                  height: 0,
                                                  width: 0,
                                                ),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      await showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertVoiceNote(
                                                onVn: (audio, showPlayer) {
                                              setState(() {
                                                audioPath = audio;
                                                showPlayer1 = showPlayer;
                                              });
                                              print("audioooo $audioPath");

                                              final res = XFile(audioPath!);
                                              value.image = [res];
                                              value.extension =
                                                  File(value.image![0].path)
                                                      .path
                                                      .split('.')
                                                      .last
                                                      .toLowerCase();
                                            });
                                          });
                                      // if (recorder.isRecording) {
                                      //   await stop();
                                      // } else {
                                      //   await record();
                                      // }
                                      setState(() {});
                                    },
                                    child: Image.asset(
                                      "images/chat/vn.png",
                                      width: 24,
                                      height: 24,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      // pickImageWithPermission();
                                      var res = await takeVideo(context, androidVersion: _androidVersion);
                                      print("res video $res");
                                      if (res != null) {
                                        // Mendapatkan ukuran file
                                        File videoFile = File(res.path);
                                        int fileSizeInBytes =
                                            await videoFile.length();
                                        double fileSizeInKB = fileSizeInBytes /
                                            1024; // Konversi ke KB
                                        double fileSizeInMB = fileSizeInKB /
                                            1024; // Konversi ke MB

                                        if (fileSizeInMB > 30) {
                                          NotificationUtils.showDialogError(
                                            context,
                                            () {
                                              Nav.back();
                                            },
                                            widget: Text(
                                              S
                                                  .of(context)
                                                  .the_file_is_too_large_please_upload_a_file_with_a_size_of_less_than_30_mb,
                                              textAlign: TextAlign.center,
                                            ),
                                          );
                                        } else {
                                          setState(() {
                                            value.image = [res];
                                            value.initVideo();
                                          });

                                          value.extension =
                                              File(value.image![0].path)
                                                  .path
                                                  .split('.')
                                                  .last
                                                  .toLowerCase();
                                        }

                                        print("TIPE ${value.imageType}");

                                        if (kDebugMode) {
                                          print("extension ${value.extension}");
                                        }

                                        print(
                                            'Ukuran file video: $fileSizeInBytes bytes, $fileSizeInKB KB, $fileSizeInMB MB');
                                        // await providerUser.updateProfileUser(
                                        //     context, providerUser.image!);
                                      }
                                    },
                                    child: Image.asset(
                                      "images/chat/video.png",
                                      width: 24,
                                      height: 24,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      // pickImageWithPermission();
                                      var res = await takeImage(context);
                                      if (res != null) {
                                        setState(() {
                                          value.image = [res];
                                          value.extension =
                                              File(value.image![0].path)
                                                  .path
                                                  .split('.')
                                                  .last
                                                  .toLowerCase();
                                          print("TIPE ${value.imageType}");
                                        });
                                        // await providerUser.updateProfileUser(
                                        //     context, providerUser.image!);
                                      }
                                    },
                                    child: Image.asset(
                                      "images/chat/gambar.png",
                                      width: 24,
                                      height: 24,
                                    ),
                                  )
                                ],
                              ),
                              // value.isPostChat == true
                              //     ? MaterialButton(
                              //         elevation: 0,
                              //         minWidth: 75,
                              //         height: 28,
                              //         color: Colors.white,
                              //         textColor: primaryColor,
                              //         shape: RoundedRectangleBorder(
                              //             borderRadius:
                              //                 BorderRadius.circular(8),
                              //             side: BorderSide(
                              //                 color: primaryColor, width: 1)),
                              //         onPressed: () async {
                              //           setState(() {
                              //             value.isPostChat = false;
                              //           });
                              //         },
                              //         child: Text(S.of(context).close),
                              //       )
                              //     : const SizedBox(
                              //         height: 0,
                              //         width: 0,
                              //       ),
                              const SizedBox(
                                width: 10,
                              ),
                              value.isPostChat == true
                                  ? const CircularProgressWidget(
                                      color: Colors.white,
                                    )
                                  : MaterialButton(
                                      elevation: 0,
                                      minWidth: 75,
                                      height: 28,
                                      color: value.image == null &&
                                              value.title.text.isEmpty
                                          ? greyColor
                                          : primaryColor,
                                      textColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      onPressed: value.title.text.isEmpty
                                          ? null
                                          : () async {
                                              // if (value.extension == "mp4") {
                                              await value.createPostChat(
                                                  context, value.image,
                                                  onUpdate: () {
                                                value.getListPost();
                                                audioPath = null;
                                              });
                                              // } else {
                                              // await value.createPostChat(
                                              //     value.image!, value.video!);
                                              // }
                                            },
                                      child: Text(S.of(context).posting),
                                    )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 3,
                    color: greyColor.withOpacity(0.1),
                  ),
                  // value.listPost.isNotEmpty
                  //     ? const Center(
                  //         child: Text("Belum ada postingan"),
                  //       )
                  //     :
                  if (value.isListPost) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      child: ShimmerLoadingWidget(
                          height: 200,
                          width: MediaQuery.of(context).size.width),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      child: ShimmerLoadingWidget(
                          height: 200,
                          width: MediaQuery.of(context).size.width),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      child: ShimmerLoadingWidget(
                          height: 200,
                          width: MediaQuery.of(context).size.width),
                    ),
                    const SizedBox(
                      height: 16,
                    )
                  ] else ...[
                    ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          DataPost data = value.listPost[index];

                          return ItemCoolChat(
                            data,
                            onLike: () {
                              value.getListPost();
                            },
                            onUpdateLike: () {
                              value.getListPost();
                            },
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Padding(
                              padding: EdgeInsets.only(bottom: 2));
                        },
                        itemCount: value.listPost.length)
                  ]
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

class PlayVideoPost extends StatefulWidget {
  final DataPost? data;
  const PlayVideoPost(this.data, {super.key});

  @override
  State<PlayVideoPost> createState() => _PlayVideoPostState();
}

class _PlayVideoPostState extends State<PlayVideoPost> {
  late VideoPlayerController controller;

  void initVideo() {
    Uri? url = Uri.tryParse(
        "${ApiEndpoint.imageUrlPost}${widget.data?.multimedia?.elementAt(0).path?.replaceAll("//", "/")}");

    print("uriii $url");
    controller = VideoPlayerController.networkUrl(url!)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
        ();
        controller.addListener(listenerPosition);
      });
  }

  void listenerPosition() {
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initVideo();
  }

  StreamSubscription<Duration>? durationChangedStream;
  StreamSubscription<Duration>? positionChangedStream;

  bool playVid = false;
  playOrPause() async {
    if (playVid) {
      await pause();
    } else {
      await play();
    }
    setState(() {
      playVid = !playVid;
    });
  }

  pause() {
    controller.pause();
  }

  play() {
    controller.play();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.removeListener(listenerPosition);
    controller.dispose();
    durationChangedStream?.cancel();
    positionChangedStream?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 200,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          SizedBox(
            width: 200,
            height: 100,
            child: AspectRatio(
              aspectRatio: controller.value.aspectRatio,
              child: VideoPlayer(controller),
            ),
          ),
          IconButton(
              onPressed: () {
                playOrPause();
                print("oi $playVid");
              },
              icon: playVid == true
                  ? const Icon(Icons.pause)
                  : const Icon(Icons.play_arrow)),
          FutureBuilder(
            future: controller.position,
            builder: (context, snapshot) {
              final totalDuration = controller.value.duration.inSeconds;
              return ProgressBar(
                progress: Duration(seconds: snapshot.data?.inSeconds ?? 0),
                total: Duration(seconds: totalDuration),
                onSeek: (duration) {
                  controller.seekTo(duration);
                },
                baseBarColor: Colors.grey.withOpacity(0.5),
                progressBarColor: primaryColor, // Adjust colors as needed
                thumbColor: Colors.blue,
              );
            },
          ),
        ],
      ),
    );
  }
}

class PlayAudio extends StatefulWidget {
  final DataPost? data;
  const PlayAudio(this.data, {super.key});

  @override
  State<PlayAudio> createState() => _PlayAudioState();
}

enum CustomAudioPlayerState {
  paused,
  playing,
  stopped,
  completed,
}

class _PlayAudioState extends State<PlayAudio> {
  player_state.AudioPlayer audioPlayer = player_state.AudioPlayer();

  bool isPlaying = false;

  String audioPlayerStatePlaying = 'playing';
  String audioPlayerStatePaused = 'paused';
  String audioPlayerStateStopped = 'stopped';
  String audioPlayerStateCompleted = 'completed';

  String? audioPlayerState;

  int timeProgress = 0;
  int audioDuration = 0;

  Widget slider() {
    return SizedBox(
      // width: 300.0,
      child: Slider.adaptive(
          value: timeProgress.toDouble(),
          max: audioDuration.toDouble(),
          onChanged: (value) {
            seekToSec(value.toInt());
          }),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    audioPlayerState = audioPlayerStatePaused;
    // audioPlayer.onPlayerStateChanged.listen((state) {
    //   setState(() {
    //     audioState = state;
    //   });
    // });

    /// Optional
    Uri? url = Uri.tryParse(
        "${ApiEndpoint.imageUrlPost}${widget.data?.multimedia?.elementAt(0).path?.replaceAll("//", "/")}");

    print("uri mp3 $url");
    audioPlayer.setSourceUrl(
        "${ApiEndpoint.imageUrlPost}${widget.data?.multimedia?.elementAt(0).path?.replaceAll("//", "/")}");
    audioPlayer.onDurationChanged.listen((Duration duration) {
      setState(() {
        audioDuration = duration.inSeconds;
      });
    });
    audioPlayer.onPositionChanged.listen((Duration position) async {
      setState(() {
        timeProgress = position.inSeconds;
      });
    });
  }

  @override
  void dispose() {
    // audioPlayer.release();
    // audioPlayer.dispose();
    super.dispose();
  }

  /// Compulsory
  playMusic() async {
    // Add the parameter "isLocal: true" if you want to access a local file
    await audioPlayer.play(player_state.UrlSource(
        "${ApiEndpoint.imageUrlPost}${widget.data?.multimedia?.elementAt(0).path?.replaceAll("//", "/")}"));
    setState(() {
      audioPlayerState = audioPlayerStatePlaying;
    });
  }

  /// Compulsory
  pauseMusic() async {
    await audioPlayer.pause();
    setState(() {
      audioPlayerState = audioPlayerStatePaused;
    });
  }

  /// Optional
  void seekToSec(int sec) {
    Duration newPos = Duration(seconds: sec);
    audioPlayer
        .seek(newPos); // Jumps to the given position within the audio file
  }

  /// Optional
  String getTimeString(int seconds) {
    String minuteString =
        '${(seconds / 60).floor() < 10 ? 0 : ''}${(seconds / 60).floor()}';
    String secondString = '${seconds % 60 < 10 ? 0 : ''}${seconds % 60}';
    return '$minuteString:$secondString'; // Returns a string with the format mm:ss
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(child: slider()),
            Text(
              getTimeString(audioDuration),
              style: const TextStyle(fontSize: 12),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  audioPlayerState == audioPlayerStatePlaying
                      ? pauseMusic()
                      : playMusic();
                });
              },
              child: Icon(audioPlayerState == audioPlayerStatePlaying
                  ? Icons.pause_rounded
                  : Icons.play_arrow_rounded),
            ),
          ],
        ));
  }
}
//
//
//
// String formatTime(Duration duration) async {
//
// }
