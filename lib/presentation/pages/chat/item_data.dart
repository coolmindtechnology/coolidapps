import 'package:coolappflutter/data/models/data_post.dart';
import 'package:coolappflutter/data/provider/provider_cool_chat.dart';
import 'package:coolappflutter/presentation/pages/chat/screen_detail_postingan.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/networks/endpoint/api_endpoint.dart';
import '../../../generated/l10n.dart';
import '../../theme/color_utils.dart';
import '../../utils/circular_progress_widget.dart';
import '../../utils/nav_utils.dart';
import 'chat_profile.dart';
import 'home_chat.dart';

class ItemCoolChat extends StatefulWidget {
  final Function? onLike, onUpdateLike;
  final DataPost? data;
  const ItemCoolChat(this.data, {super.key, this.onLike, this.onUpdateLike});

  @override
  State<ItemCoolChat> createState() => _ItemCoolChatState();
}

class _ItemCoolChatState extends State<ItemCoolChat> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return ProviderCoolChat.cekLikes(itemId: widget.data?.id);
      },
      child: Consumer<ProviderCoolChat>(
        builder: (BuildContext context, value, Widget? child) =>
            GestureDetector(
          onTap: () {
            Nav.to(ScreenDetailPostingan(
              data: widget.data,
              onUpdateLike: () {
                widget.onUpdateLike!();
              },
            ));
          },
          child: Container(
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border:
                    Border.all(width: 1, color: greyColor.withOpacity(0.1))),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Nav.to(ChatProfile(
                                idUser: widget.data?.idUser,
                                idprofiling: widget.data?.profiling?.idUser));
                          },
                          child: widget.data?.user?.image != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.network(
                                    "${widget.data?.user?.image}",
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.asset(
                                    "images/default_user.png",
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.cover,
                                    color: greyColor,
                                  ),
                                ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          "${widget.data?.user?.name ?? ""} .  ${widget.data?.createdAt?.hour} hours ago",
                          style: TextStyle(fontSize: 12, color: greyColor),
                        )
                      ],
                    ),
                    // Image.asset(
                    //   "images/chat/more.png",
                    //   width: 24,
                    //   height: 24,
                    // ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.data?.description ?? "-",
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      if (widget.data?.multimedia?.isNotEmpty == true) ...[
                        if (widget.data?.multimedia
                                    ?.elementAt(0)
                                    .path
                                    ?.contains(".jpg") ==
                                true ||
                            widget.data?.multimedia
                                    ?.elementAt(0)
                                    .path
                                    ?.contains(".PNG") ==
                                true ||
                            widget.data?.multimedia
                                    ?.elementAt(0)
                                    .path
                                    ?.contains(".webp") ==
                                true) ...[
                          Container(
                              alignment: Alignment.center,
                              height: 150,
                              width: MediaQuery.of(context).size.width,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  "${widget.data?.multimedia![0].path ?? ""}",
                                  height: 150,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.fitWidth,
                                ),
                              ))
                        ] else if (widget.data?.multimedia
                                ?.elementAt(0)
                                .path
                                ?.contains(".mp4") ==
                            true) ...[
                          PlayVideoPost(widget.data)
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
                      Row(
                        children: [
                          value.isPostReaction == true
                              ? CircularProgressWidget(
                                  color: primaryColor,
                                )
                              : GestureDetector(
                                  onTap: () async {
                                    await value.postReaction(
                                        widget.data?.id?.toString() ?? "",
                                        onLike: () async {
                                      value.getCekLikes(
                                          widget.data?.id?.toString() ?? "");
                                      widget.onLike!();

                                      // value.getTotalCountByPost(
                                      //     widget.data?.id.toString() ?? "");
                                    });
                                    // setState(() {
                                    //   isLike = !isLike;
                                    // });
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
                            "${widget.data?.likes ?? 0}+",
                            style: TextStyle(
                                color: greyColor.withOpacity(0.5),
                                fontSize: 12),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Image.asset(
                            "images/chat/chat.png",
                            width: 20,
                            height: 20,
                            color:
                                // isComment == true
                                //     ? primaryColor
                                //     :
                                greyColor,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          GestureDetector(
                            onTap: () {
                              value.commentPost(
                                  widget.data?.id ?? 0, value.etComment.text, 1,
                                  onUpdate: () {
                                value.getListPost();
                              });
                            },
                            child: Text(
                              "${widget.data?.comment}+",
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 12),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          GestureDetector(
                            onTap: () {
                              value.getShareCode(
                                context,
                                widget.data?.id ?? 0,
                              );
                              // setState(() {
                              //   isShare = !isShare;
                              // });
                            },
                            child: Image.asset(
                              "images/chat/share.png",
                              width: 20,
                              height: 20,
                              color:
                                  // isShare == true
                                  //     ? primaryColor
                                  //     :
                                  greyColor,
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            "${widget.data?.shareCount ?? 0}+",
                            style: const TextStyle(
                                color: Colors.black, fontSize: 12),
                          ),
                        ],
                      )
                    ],
                  ),
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
                            hintStyle:
                                TextStyle(color: greyColor.withOpacity(0.5)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none),
                            contentPadding: EdgeInsets.zero),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          value.isComment
                              ? CircularProgressWidget(
                                  color: primaryColor,
                                )
                              : SizedBox(
                                  height: 28,
                                  child: MaterialButton(
                                    elevation: 0,
                                    minWidth: 75,
                                    height: 28,
                                    color: primaryColor,
                                    textColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4)),
                                    onPressed: () {
                                      value.commentPost(
                                          widget.data?.id ?? 0,
                                          value.etComment.text,
                                          1, onUpdate: () {
                                        value.getListPost();
                                      });
                                    },
                                    child: Text(S.of(context).posting),
                                  ),
                                )
                        ],
                      )
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
