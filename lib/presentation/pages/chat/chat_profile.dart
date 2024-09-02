import 'dart:async';
import 'package:cool_app/data/data_global.dart';
import 'package:cool_app/data/models/data_post.dart';
import 'package:cool_app/data/provider/provider_cool_chat.dart';
import 'package:cool_app/data/provider/provider_user.dart';
import 'package:cool_app/data/response/cool_chat/res_search_content.dart';
import 'package:cool_app/generated/l10n.dart';
import 'package:cool_app/presentation/pages/chat/screen_detail_postingan.dart';
import 'package:cool_app/presentation/theme/color_utils.dart';
import 'package:cool_app/presentation/utils/circular_progress_widget.dart';
import 'package:cool_app/presentation/utils/nav_utils.dart';
import 'package:cool_app/presentation/widgets/refresh_icon_widget.dart';
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
  final String? idUser;
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
            print(
                "prof ${ApiEndpoint.baseUrlImage}${valueChat.userProfiling?.image}");
          }
          return Scaffold(
            appBar: AppBar(
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
                                                  "${ApiEndpoint.baseUrlImage}${valueChat.userProfiling?.image}",
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
                                                      "${ApiEndpoint.baseUrlImage}${valueUser.dataUser?.image}",
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
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Image.network(
                                              "${ApiEndpoint.imageUrlPost}${data.multimedia?.elementAt(0).path}",
                                              height: 200,
                                              width: 200,
                                              fit: BoxFit.cover,
                                            ),
                                          )
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
