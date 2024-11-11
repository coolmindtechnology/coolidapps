import 'dart:async';
import 'package:coolappflutter/data/data_global.dart';
import 'package:coolappflutter/data/models/data_post.dart';
import 'package:coolappflutter/data/provider/provider_cool_chat.dart';
import 'package:coolappflutter/data/provider/provider_user.dart';
import 'package:coolappflutter/data/response/cool_chat/res_search_content.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/chat/home_chat.dart';
import 'package:coolappflutter/presentation/pages/chat/screen_detail_postingan.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/circular_progress_widget.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/widgets/refresh_icon_widget.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/networks/endpoint/api_endpoint.dart';
import '../../../data/provider/provider_profiling.dart';
import '../../../main.dart';

class ChatProfile extends StatefulWidget {
  // final Profiling? data;
  final String? etSearch;
  final dynamic idUser;
  final String? idprofiling;
  final bool isMe;
  final bool fromSearch;
  final ProfilingDatum? dataProfiling;
  const ChatProfile({
    super.key,
    this.idUser,
    this.idprofiling,
    this.isMe = false,
    this.fromSearch = false,
    this.dataProfiling,
    this.etSearch,
  });

  @override
  State<ChatProfile> createState() => _ChatProfileState();
}

class _ChatProfileState extends State<ChatProfile> {
  bool isFolow = false;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  StreamSubscription? eventBalanceStream;

  @override
  void dispose() {
    eventBalanceStream?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  init() {
    Future.microtask(() {
      initById();
      getMe();
    });
  }

  initById() {
    if (widget.idUser != null && widget.idprofiling != null) {
      context.read<ProviderCoolChat>().getListPostByUserId(widget.idUser!);
      if (!widget.isMe) {
        context.read<ProviderCoolChat>().getCekFollowing(widget.idUser!);
      }

      context.read<ProviderCoolChat>().getFollower(widget.idUser!);
      context.read<ProviderCoolChat>().getUserProfilingById(context,
          idProfiling: int.parse(widget.idprofiling ?? "0"));
    } else if (widget.idUser != null) {
      context.read<ProviderCoolChat>().getListPostByUserId(widget.idUser!);
      context.read<ProviderCoolChat>().getCekFollowing(widget.idUser!);
      context.read<ProviderCoolChat>().getFollower(widget.idUser!);
    } else if (widget.idprofiling != null) {
      context.read<ProviderCoolChat>().getUserProfilingById(context,
          idProfiling: int.parse(widget.idprofiling ?? "0"));
    }
  }

  getMe() {
    if (widget.isMe) {
      context.read<ProviderUser>().getUser(context);
      context.read<ProviderProfiling>().getUserProfiling(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderCoolChat>(
      builder: (BuildContext context, valueChat, Widget? child) =>
          Consumer<ProviderUser>(
        builder: (BuildContext context, valueUser, Widget? child) =>
            Consumer<ProviderProfiling>(builder:
                (BuildContext context, valueUserProfiling, Widget? child) {
          eventBalanceStream ??= eventBalance.listen(onChanges: () {
            valueChat
                .getListPostByUserId(valueUser.dataUser?.id.toString() ?? "");
            valueChat.getCekFollowing(valueUser.dataUser?.id.toString() ?? "");
          });
          if (kDebugMode) {
            print(valueUser.dataUser?.name);
          }
          if (kDebugMode) {
            print("prof ${valueChat.userProfiling?.image}");
          }
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "${valueUser.dataUser?.name.toString()}",
                style: const TextStyle(color: Colors.white),
              ),
              centerTitle: true,
              iconTheme: const IconThemeData(color: Colors.white),
              backgroundColor: primaryColor,
            ),
            body: valueChat.isLoading
                ? CircularProgressWidget(
                    color: primaryColor,
                  )
                : CustomMaterialIndicator(
                    key: _refreshIndicatorKey,
                    onRefresh: () {
                      initById();
                      getMe();
                      return Future.delayed(const Duration(seconds: 1));
                    },
                    indicatorBuilder: (context, controller) {
                      return const RefreshIconWidget();
                    },
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      Positioned(
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 71 / 2,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Center(
                                        child: widget.etSearch != null
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                child: Image.network(
                                                  "${valueChat.userProfiling?.image}",
                                                  width: 80,
                                                  height: 80,
                                                  fit: BoxFit.cover,
                                                ),
                                              )
                                            : valueUser.dataUser?.image != null
                                                ? ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    child: Image.network(
                                                      "${valueUser.dataUser?.image}",
                                                      width: 80,
                                                      height: 80,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  )
                                                : ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    child: Image.asset(
                                                      "images/default_user.png",
                                                      color: greyColor,
                                                      width: 80,
                                                      height: 80,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    "${widget.isMe ? valueUser.dataUser?.name : widget.dataProfiling != null ? widget.dataProfiling?.dataProfile?.name : valueChat.userProfiling?.name}",
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    widget.dataProfiling != null
                                        ? "${widget.dataProfiling?.resultName?.name ?? "-"} • ${widget.dataProfiling?.dataProfile?.domicile ?? "-"} • ${widget.dataProfiling?.dataProfile?.bloodType ?? "-"}"
                                        : widget.isMe
                                            ? "${valueUserProfiling.userProfiling?.character ?? "-"} • ${valueUserProfiling.userProfiling?.domicile ?? "-"} • ${valueUserProfiling.userProfiling?.bloodType ?? "-"}"
                                            : "${valueChat.userProfiling?.character ?? "-"} • ${valueChat.userProfiling?.domicile ?? "-"} • ${valueChat.userProfiling?.bloodType ?? "-"}",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: greyColor.withOpacity(0.5)),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "${valueChat.dataFollower?.post ?? "-"}",
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            S.of(context).post,
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color:
                                                    greyColor.withOpacity(0.5)),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 48,
                                        child: VerticalDivider(
                                          thickness: 1,
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "${valueChat.dataFollower?.following ?? "-"}",
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            S.of(context).following,
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color:
                                                    greyColor.withOpacity(0.5)),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 48,
                                        child: VerticalDivider(
                                          thickness: 1,
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "${valueChat.dataFollower?.follower ?? "-"}",
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            S.of(context).followers,
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color:
                                                    greyColor.withOpacity(0.5)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  "${widget.idUser}" ==
                                          "${dataGlobal.dataUser?.id}"
                                      ? const SizedBox(
                                          height: 25,
                                        )
                                      : const SizedBox(
                                          height: 0,
                                          width: 0,
                                        ),
                                  "${widget.idUser}" ==
                                          "${dataGlobal.dataUser?.id}"
                                      ? const SizedBox(
                                          height: 0,
                                          width: 0,
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: valueChat.followUnFollow ==
                                                  true
                                              ? CircularProgressWidget(
                                                  color: primaryColor,
                                                )
                                              : MaterialButton(
                                                  elevation: 0,
                                                  height: 45,
                                                  minWidth:
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    side: valueChat
                                                                .dataFollowing ==
                                                            null
                                                        ? BorderSide.none
                                                        : BorderSide(
                                                            width: 1,
                                                            color:
                                                                primaryColor),
                                                  ),
                                                  color:
                                                      valueChat.dataFollowing ==
                                                              null
                                                          ? primaryColor
                                                          : Colors.white,
                                                  textColor:
                                                      valueChat.dataFollowing ==
                                                              null
                                                          ? Colors.white
                                                          : primaryColor,
                                                  onPressed: () {
                                                    valueChat.followAkun(
                                                        widget.idUser ??
                                                            valueUserProfiling
                                                                .userProfiling
                                                                ?.idUser ??
                                                            "", onUpdate: () {
                                                      valueChat.getCekFollowing(
                                                          widget.idUser ??
                                                              valueUserProfiling
                                                                  .userProfiling
                                                                  ?.idUser ??
                                                              "");
                                                      valueChat.getFollower(
                                                          widget.idUser ?? "");
                                                    });
                                                    // follow();
                                                  },
                                                  child: Text(valueChat
                                                              .dataFollowing ==
                                                          null
                                                      ? S.of(context).follow
                                                      : S.of(context).unfollow),
                                                ),
                                        )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Divider(
                            thickness: 3,
                            color: greyColor.withOpacity(0.1),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      childAspectRatio: 1 / 1),
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                DataPost data = valueChat.listPostById[index];
                                return Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        10,
                                      ),
                                      border: Border.all(
                                          width: 1, color: primaryColor)),
                                  margin: const EdgeInsets.only(
                                      left: 10, bottom: 10, right: 10),
                                  alignment: Alignment.center,
                                  height: 200,
                                  width: 200,
                                  child: GestureDetector(
                                    onTap: () {
                                      Nav.to(ScreenDetailPostingan(
                                        data: data,
                                        idUser: widget.idUser,
                                        onUpdate: () {
                                          valueChat.getListPostByUserId(
                                              widget.idUser ?? "");
                                        },
                                      ));
                                    },
                                    child: data.multimedia?.isNotEmpty == true
                                        ? data.multimedia
                                                    ?.elementAt(0)
                                                    .path
                                                    ?.contains(".webp") ==
                                                true
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: Image.network(
                                                  "${data.multimedia?.elementAt(0).path}",
                                                  height: 200,
                                                  width: 200,
                                                  fit: BoxFit.cover,
                                                ),
                                              )
                                            // Column(
                                            //     children: [
                                            //     if (data.multimedia?.isNotEmpty ??
                                            //         false) ...[
                                            //       if (data.multimedia != null &&
                                            //               data.multimedia
                                            //                       ?.elementAt(0)
                                            //                       .path
                                            //                       ?.contains(
                                            //                           ".jpg") ==
                                            //                   true ||
                                            //           data.multimedia?.elementAt(0).path?.contains(".PNG") ==
                                            //               true ||
                                            //           data.multimedia
                                            //                   ?.elementAt(0)
                                            //                   .path
                                            //                   ?.contains(
                                            //                       ".webp") ==
                                            //               true) ...[
                                            //         ClipRRect(
                                            //           borderRadius:
                                            //               BorderRadius.circular(
                                            //                   15),
                                            //           child: Image.network(
                                            //             "${data.multimedia?.elementAt(0).path}",
                                            //             height: 200,
                                            //             width: 200,
                                            //             fit: BoxFit.cover,
                                            //           ),
                                            //         )
                                            //       ] else if (data.multimedia != null &&
                                            //           data.multimedia
                                            //                   ?.elementAt(0)
                                            //                   .path
                                            //                   ?.contains(
                                            //                       ".mp4") ==
                                            //               true) ...[
                                            //         // SizedBox(
                                            //         //     height: 200,
                                            //         //     width: 200,
                                            //         //     child:
                                            //         //         PlayVideoPost(data)),
                                            //         // Container(
                                            //         //   decoration: const BoxDecoration(
                                            //         //       color: Colors.red,
                                            //         //       image: DecorationImage(
                                            //         //           image: AssetImage(
                                            //         //         "images/chat/play.png",
                                            //         //       ))),
                                            //         //   child: SizedBox(
                                            //         //     width: 200,
                                            //         //     height: 200,
                                            //         //     child: AspectRatio(
                                            //         //       aspectRatio: controller!.value.aspectRatio,
                                            //         //       child: VideoPlayer(controller!),
                                            //         //     ),
                                            //         //   ),
                                            //         // ),
                                            //         // GestureDetector(
                                            //         //   onTap: () {
                                            //         //     setState(() {
                                            //         //       (controller?.value.isPlaying == true)
                                            //         //           ? controller?.pause()
                                            //         //           : controller?.play();
                                            //         //     });
                                            //         //   },
                                            //         //   child: Icon(
                                            //         //     (controller?.value.isPlaying == true)
                                            //         //         ? Icons.pause
                                            //         //         : Icons.play_arrow,
                                            //         //   ),
                                            //         // ),
                                            //       ] else if (data.multimedia
                                            //               ?.elementAt(0)
                                            //               .path
                                            //               ?.contains(".m4a") ==
                                            //           true) ...[
                                            //         // SizedBox(
                                            //         //     height: 200,
                                            //         //     width: 200,
                                            //         //     child: PlayAudio(data))
                                            //       ] else if ((data.multimedia
                                            //                   ?.elementAt(0)
                                            //                   .path
                                            //                   ?.contains(".mp3") ==
                                            //               true) ||
                                            //           (data.multimedia?.elementAt(0).path?.contains(".m4a") == true)) ...[
                                            //         // SizedBox(
                                            //         //     width: 200,
                                            //         //     height: 200,
                                            //         //     child: PlayAudio(data)),
                                            //       ],
                                            //     ],
                                            //   ],
                                            // )
                                            // ClipRRect(
                                            //     borderRadius:
                                            //         BorderRadius.circular(15),
                                            //     child: Image.network(
                                            //       "${data.multimedia?.elementAt(0).path}",
                                            //       height: 200,
                                            //       width: 200,
                                            //       fit: BoxFit.cover,
                                            //     ),
                                            //   )
                                            : data.multimedia
                                                        ?.elementAt(0)
                                                        .path
                                                        ?.contains(".mp3") ==
                                                    true
                                                ? const Center(
                                                    child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(Icons.music_note),
                                                      Text(
                                                        "Tap To play audio",
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ],
                                                  ))
                                                : data.multimedia
                                                            ?.elementAt(0)
                                                            .path
                                                            ?.contains(
                                                                ".mp4") ==
                                                        true
                                                    ? const Center(
                                                        child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(Icons
                                                              .video_call_sharp),
                                                          Text(
                                                            "Tap To play video",
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ],
                                                      ))
                                                    : Center(
                                                        child: Text(
                                                        "${data.description}",
                                                        textAlign:
                                                            TextAlign.center,
                                                      ))
                                        : Center(
                                            child: Text(
                                            "${data.description}",
                                            textAlign: TextAlign.center,
                                          )),
                                  ),
                                );
                              },
                              itemCount: valueChat.listPostById.length)
                        ],
                      ),
                    ),
                  ),
          );
        }),
      ),
    );
  }
}
