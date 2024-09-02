// ignore_for_file: deprecated_member_use

import 'package:cool_app/data/data_global.dart';
import 'package:cool_app/data/models/data_post.dart';
import 'package:cool_app/presentation/pages/chat/home_chat.dart';
import 'package:cool_app/presentation/theme/color_utils.dart';
import 'package:cool_app/presentation/utils/date_util.dart';
import 'package:cool_app/presentation/utils/nav_utils.dart';
import 'package:cool_app/presentation/utils/notification_utils.dart';
import 'package:cool_app/presentation/widgets/refresh_icon_widget.dart';
import 'package:cool_app/presentation/widgets/shimmer_loading.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import '../../../data/networks/endpoint/api_endpoint.dart';
import '../../../data/provider/provider_cool_chat.dart';
import '../../../generated/l10n.dart';
import '../../utils/circular_progress_widget.dart';

class ScreenDetailPostingan extends StatefulWidget {
  final DataPost? data;
  final Function? onUpdate, onUpdateLike;
  final String? idUser;
  const ScreenDetailPostingan(
      {super.key, this.onUpdate, this.data, this.idUser, this.onUpdateLike});

  @override
  State<ScreenDetailPostingan> createState() => _ScreenDetailPostinganState();
}

class _ScreenDetailPostinganState extends State<ScreenDetailPostingan> {
  bool isShare = false, isLike = false, isComment = false;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  TextEditingController title = TextEditingController();

  VideoPlayerController? controller;
  void initVideo() {
    if (widget.data?.multimedia != null &&
        widget.data!.multimedia!.isNotEmpty) {
      Uri? url = Uri.tryParse(
          "${ApiEndpoint.imageUrlPost}${widget.data!.multimedia!.elementAt(0).path?.replaceAll("//", "/")}");
      controller = VideoPlayerController.networkUrl(url!)
        ..initialize().then((_) {
          setState(() {});
        });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initVideo();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // await widget.onUpdateLike!();
        Nav.back();
        return false;
      },
      child: ChangeNotifierProvider(
          create: (BuildContext context) {
            return ProviderCoolChat.initDetailPost(
                context, widget.data?.id.toString() ?? "");
          },
          child: Consumer<ProviderCoolChat>(
            builder: (BuildContext context, value, Widget? child) => Scaffold(
              appBar: AppBar(
                actions: "${widget.idUser ?? widget.data?.profiling?.idUser}" ==
                        "${dataGlobal.dataUser?.id}"
                    ? [
                        PopupMenuButton(
                          onSelected: (val) {
                            if (val == "hapus") {
                              NotificationUtils.showSimpleDialog2(context,
                                  "Anda yakin mau menghapus postingan ini?",
                                  textButton1: "Yes",
                                  textButton2: "No", onPress1: () async {
                                await value.deletePost(widget.data?.id ?? 0,
                                    onUpdate: () {
                                  widget.onUpdate!();
                                });
                              }, onPress2: () {
                                Nav.back();
                              });
                            }
                          },
                          itemBuilder: (BuildContext bc) {
                            return const [
                              PopupMenuItem(
                                value: 'hapus',
                                child: Text("Hapus"),
                              ),
                            ];
                          },
                        )
                      ]
                    : [],
              ),
              body: CustomMaterialIndicator(
                key: _refreshIndicatorKey,
                onRefresh: () {
                  value.getListComment(
                      context, widget.data?.id.toString() ?? "");
                  value.getTotalCountByPost(widget.data?.id.toString() ?? "");
                  return Future<void>.delayed(const Duration(seconds: 1));
                },
                indicatorBuilder:
                    (BuildContext context, IndicatorController controller) {
                  return const RefreshIconWidget();
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(children: [
                      //please dont remove this first checking
                      if (widget.data?.multimedia?.isNotEmpty ?? false) ...[
                        if (widget.data?.multimedia != null &&
                                widget.data?.multimedia
                                        ?.elementAt(0)
                                        .path
                                        ?.contains(".jpg") ==
                                    true ||
                            widget.data?.multimedia
                                    ?.elementAt(0)
                                    .path
                                    ?.contains(".PNG") ==
                                true) ...[
                          Container(
                              alignment: Alignment.center,
                              height: 150,
                              width: MediaQuery.of(context).size.width,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  "${ApiEndpoint.imageUrlPost}${widget.data?.multimedia?.elementAt(0).path?.replaceAll("//", "/") ?? ""}",
                                  height: 150,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.fitWidth,
                                ),
                              ))
                        ] else if (widget.data?.multimedia != null &&
                            widget.data?.multimedia
                                    ?.elementAt(0)
                                    .path
                                    ?.contains(".mp4") ==
                                true) ...[
                          PlayVideoPost(widget.data),
                          // Container(
                          //   decoration: const BoxDecoration(
                          //       color: Colors.red,
                          //       image: DecorationImage(
                          //           image: AssetImage(
                          //         "images/chat/play.png",
                          //       ))),
                          //   child: SizedBox(
                          //     width: 200,
                          //     height: 200,
                          //     child: AspectRatio(
                          //       aspectRatio: controller!.value.aspectRatio,
                          //       child: VideoPlayer(controller!),
                          //     ),
                          //   ),
                          // ),
                          // GestureDetector(
                          //   onTap: () {
                          //     setState(() {
                          //       (controller?.value.isPlaying == true)
                          //           ? controller?.pause()
                          //           : controller?.play();
                          //     });
                          //   },
                          //   child: Icon(
                          //     (controller?.value.isPlaying == true)
                          //         ? Icons.pause
                          //         : Icons.play_arrow,
                          //   ),
                          // ),
                        ] else if (widget.data?.multimedia
                                ?.elementAt(0)
                                .path
                                ?.contains(".m4a") ==
                            true) ...[
                          PlayAudio(widget.data)
                        ] else if ((widget.data?.multimedia
                                    ?.elementAt(0)
                                    .path
                                    ?.contains(".mp3") ==
                                true) ||
                            (widget.data?.multimedia
                                    ?.elementAt(0)
                                    .path
                                    ?.contains(".m4a") ==
                                true)) ...[
                          PlayAudio(widget.data),
                        ],
                      ],
                      const SizedBox(
                        height: 12,
                      ),
                      if (value.isGetListComment ||
                          value.isGetTotalCountByPost) ...[
                        ShimmerLoadingWidget(
                            height: 50,
                            width: MediaQuery.of(context).size.width),
                        const SizedBox(
                          height: 10,
                        ),
                        ShimmerLoadingWidget(
                            height: 50,
                            width: MediaQuery.of(context).size.width)
                      ] else ...[
                        Text("${widget.data?.description}"),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            value.isPostReaction == true
                                ? CircularProgressWidget(
                                    color: primaryColor,
                                  )
                                : GestureDetector(
                                    onTap: () async {
                                      await value.postReaction(
                                          widget.data?.id.toString() ?? "0",
                                          onLike: () {
                                        value.getCekLikes(
                                            widget.data?.id.toString() ?? "0");
                                        value.getTotalCountByPost(
                                            widget.data?.id.toString() ?? "");
                                      });

                                      setState(() {
                                        isLike = !isLike;
                                      });
                                      // await value.getTotalCountByPost(
                                      //     widget.data?.id.toString() ?? "0");
                                    },
                                    child: Image.asset(
                                      "images/chat/like.png",
                                      width: 20,
                                      height: 20,
                                      color: value.cekLike != null
                                          ? primaryColor
                                          : greyColor,
                                    ),
                                  ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              "${value.dataTotalCountByPost?.likes ?? 0}",
                              style: TextStyle(
                                  color: greyColor.withOpacity(0.5),
                                  fontSize: 12),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                value.commentPost(widget.data?.id ?? 0,
                                    value.etComment.text, 1, onUpdate: () {
                                  value.getListPostByUserId(
                                      widget.data?.id.toString() ?? "");
                                  value.getTotalCountByPost(
                                      widget.data?.id.toString() ?? "");
                                });
                                // setState(() {
                                //   isComment = !isComment;
                                // });
                              },
                              child: Image.asset(
                                "images/chat/chat.png",
                                width: 20,
                                height: 20,
                                color: isComment == true
                                    ? primaryColor
                                    : greyColor,
                              ),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              "${value.dataTotalCountByPost?.comment ?? 0}",
                              style: TextStyle(
                                  color: greyColor.withOpacity(0.5),
                                  fontSize: 12),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: GestureDetector(
                                onTap: () {
                                  value.getShareCode(
                                      context, widget.data?.id ?? 0,
                                      onShare: () {
                                    value.getTotalCountByPost(
                                        widget.data?.id.toString() ?? "");
                                  });
                                  // setState(() {
                                  //   isShare = !isShare;
                                  // });
                                },
                                child: Image.asset("images/chat/share.png",
                                    width: 20,
                                    height: 20,
                                    color: isShare == true
                                        ? primaryColor
                                        : greyColor),
                              ),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              "${value.dataTotalCountByPost?.share ?? 0}",
                              style: TextStyle(
                                  color: greyColor.withOpacity(0.5),
                                  fontSize: 12),
                            ),
                          ],
                        ),
                        ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 4,
                            );
                          },
                          shrinkWrap: true,
                          itemCount: value.listComment.length,
                          itemBuilder: (BuildContext context, int index) {
                            final comment = value.listComment[index];

                            return ListTile(
                                title: Text(comment.comment ?? ""),
                                trailing: Text(
                                    DateUtil.formatTimeAgo(comment.createdAt)));
                          },
                        ),
                        Divider(
                          thickness: 1,
                          color: greyColor.withOpacity(0.1),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
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
                                controller: value.etComment,
                                decoration: InputDecoration(
                                    hintText: S.of(context).what_to_discuss,
                                    hintStyle: TextStyle(
                                        color: greyColor.withOpacity(0.5)),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide.none)),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Row(
                                  //   children: [
                                  //     Image.asset(
                                  //       "images/chat/vn.png",
                                  //       width: 24,
                                  //       height: 24,
                                  //     ),
                                  //     const SizedBox(
                                  //       width: 8,
                                  //     ),
                                  //     Image.asset(
                                  //       "images/chat/video.png",
                                  //       width: 24,
                                  //       height: 24,
                                  //     ),
                                  //     const SizedBox(
                                  //       width: 8,
                                  //     ),
                                  //     Image.asset(
                                  //       "images/chat/gambar.png",
                                  //       width: 24,
                                  //       height: 24,
                                  //     )
                                  //   ],
                                  // ),
                                  value.isComment
                                      ? CircularProgressWidget(
                                          color: primaryColor,
                                        )
                                      : MaterialButton(
                                          elevation: 0,
                                          minWidth: 75,
                                          height: 28,
                                          color: primaryColor,
                                          textColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          onPressed: () {
                                            value.commentPost(
                                                widget.data?.id ?? 0,
                                                value.etComment.text,
                                                1, onUpdate: () {
                                              value.getListComment(
                                                  context,
                                                  widget.data?.id?.toString() ??
                                                      "");
                                              value.getTotalCountByPost(
                                                  widget.data?.id.toString() ??
                                                      "");
                                            });
                                          },
                                          child: Text(S.of(context).posting),
                                        )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ]),
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
