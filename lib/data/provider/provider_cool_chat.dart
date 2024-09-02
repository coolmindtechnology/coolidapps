import 'dart:async';
import 'dart:io';
import 'package:cool_app/data/models/data_post.dart';
import 'package:cool_app/data/repositories/repo_cool_chat.dart';
import 'package:cool_app/data/response/cool_chat/res_cek_follow.dart';
import 'package:cool_app/data/response/cool_chat/res_cek_like.dart';
import 'package:cool_app/data/response/cool_chat/res_comment_post.dart';
import 'package:cool_app/data/response/cool_chat/res_creat_post.dart';
import 'package:cool_app/data/response/cool_chat/res_delete_post.dart';
import 'package:cool_app/data/response/cool_chat/res_followe_akun.dart';
import 'package:cool_app/data/response/cool_chat/res_get_follower.dart';
import 'package:cool_app/data/response/cool_chat/res_get_list_comment.dart';
import 'package:cool_app/data/response/cool_chat/res_get_share_code.dart';
import 'package:cool_app/data/response/cool_chat/res_get_total_count_by_post.dart';
import 'package:cool_app/data/response/cool_chat/res_list_post.dart';
import 'package:cool_app/data/response/cool_chat/res_post_reaction.dart';
import 'package:cool_app/data/response/cool_chat/res_search_content.dart';
import 'package:cool_app/presentation/theme/color_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:mime/mime.dart';

import '../../presentation/utils/nav_utils.dart';
import '../../presentation/utils/notification_utils.dart';
import '../../presentation/widgets/item_share_widget.dart';
import '../helpers/either.dart';
import '../helpers/failure.dart';
import '../response/cool_chat/res_list_cool_chat_byid.dart';
import '../response/profiling/res_get_user_profiling.dart';
import '../response/profiling/res_share_result_detail.dart';

class ProviderCoolChat extends ChangeNotifier {
  ProviderCoolChat();

  ProviderCoolChat.initById(BuildContext context,
      {String? idUser, int? idProfiling}) {
    if (kDebugMode) {
      print("id profiling $idProfiling");
    }
    if (idProfiling != 0) {
      if (kDebugMode) {
        print("OK");
      }
      getUserProfilingById(context, idProfiling: idProfiling);
    } else if (idProfiling == 0) {
      if (kDebugMode) {
        print("JANGAN");
      }
    }
    if (idUser != null) {
      if (kDebugMode) {
        print("id user cek $idUser");
      }
      getListPostByUserId(idUser);
      getCekFollowing(idUser);
      getFollower(idUser);
    }
  }

  Timer? timer;

  ProviderCoolChat.cekLikes({int? itemId}) {
    getCekLikes(itemId.toString());
  }

  ProviderCoolChat.initPost() {
    getListPost();
    title.addListener(() {
      timer?.cancel();
      timer = Timer(const Duration(milliseconds: 500), () {
        if (kDebugMode) {
          print("${image == null} && ${title.text.isEmpty}");
        }
        notifyListeners();
      });
    });
  }

  ProviderCoolChat.initDetailPost(BuildContext context, String id) {
    if (kDebugMode) {
      print("id item $id");
    }
    getListComment(context, id);
    getTotalCountByPost(id);
    getCekLikes(id);
  }

  bool isLoading = false;

  List<DataPost> listPostById = [], listTitle = [];
  RepoCoolChat repo = RepoCoolChat();

  Future<void> getListPostByUserId(String id) async {
    if (kDebugMode) {
      print("id user post by id $id");
    }
    isLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    Either<Failure, ResListCoolChatById> response =
        await repo.getListPostByUserId(id);

    isLoading = false;
    notifyListeners();

    response.when(
        error: (e) {},
        success: (res) async {
          if (res != null) {
            // listTitle = res.data ?? [];
            listPostById = res.data ?? [];
            // listPostById = listPostById
            //     .where((element) => element.multimedia?.isNotEmpty == true)
            //     .toList();

            notifyListeners();
          }
        });
    notifyListeners();
  }

  List<XFile>? image;
  get imageType => lookupMimeType(image?.first.path ?? "")?.split("/").first;

  String? extension;
  TextEditingController title = TextEditingController();

  VideoPlayerController? controller;
  void initVideo() {
    controller = VideoPlayerController.file(File(image!.first.path))
      ..initialize().then((_) {
        controller?.play();
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        notifyListeners();
      }).catchError((error) {
        if (kDebugMode) {
          print('Error initializing video player: $error');
        }
      });
    controller?.addListener(() {
      if (controller?.value.hasError == true) {
        if (kDebugMode) {
          print('Video player error: ${controller?.value.errorDescription}');
        }
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer?.cancel();
    controller?.dispose();
  }

  bool isPostChat = false;
  Future<void> createPostChat(BuildContext context, List<XFile>? imageUpload,
      {Function? onUpdate}) async {
    isPostChat = true;
    notifyListeners();

    // await VideoCompress.getFileThumbnail(imageType,
    //     quality: 50, // default(100)
    //     position: -1 // default(-1)
    //     );

    Either<Failure, ResCreatePost> response =
        await repo.addPost(title.text, "", imageUpload);

    isPostChat = false;
    notifyListeners();

    if (kDebugMode) {
      print("TEST ${response.isFailed}");
    }

    response.when(error: (e) {
      NotificationUtils.showSnackbar(e.message, backgroundColor: Colors.red);
    }, success: (res) async {
      if (kDebugMode) {
        print("ABC ${res.toJson()}");
      }
      if (res.success == true) {
        NotificationUtils.showSnackbar("${res.message}",
            backgroundColor: primaryColor);
        title.text = "";
        image = null;
        onUpdate!();
        notifyListeners();
      } else {
        NotificationUtils.showDialogError(context, () {
          Nav.back();
        },
            widget: Column(
              children: [
                Text(
                  res.message ?? "",
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(res.data?.blockWord?.join(', ') ?? "")
              ],
            ));
      }
    });
    notifyListeners();
  }

  bool isShareCode = false;
  Future<void> getShareCode(BuildContext context, int id,
      {Function? onShare}) async {
    isShareCode = true;
    notifyListeners();

    Either<Failure, ResGetPostShare> response = await repo.getShareCode(id);

    isShareCode = false;
    notifyListeners();

    response.when(error: (e) {
      NotificationUtils.showSnackbar(e.message, backgroundColor: Colors.red);
    }, success: (res) async {
      if (res.success == true) {
        await sharePost(context, res.data ?? "");
        notifyListeners();
      } else {}
    });
    notifyListeners();
  }

  Future<void> _launchUrlShare(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  final FlutterShareMe flutterShareMe = FlutterShareMe();
  Future<void> sharePost(BuildContext context, String shareCode) async {
    isLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    Either<Failure, ResShareResultDetail> response =
        await repo.sharePost(shareCode);

    isLoading = false;
    notifyListeners();

    response.when(error: (e) {
      NotificationUtils.showDialogError(context, () {
        Nav.back();
      },
          widget: Text(
            e.message,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ));
    }, success: (res) async {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: const EdgeInsets.all(8.0),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  res.data?.facebook != null
                      ? ItemShareWidget(
                          socialMedia: "Facebook",
                          image: "assets/icons/facebook-round-color-icon.png",
                          onShare: () async {
                            _launchUrlShare(res.data?.facebook ?? "");
                          })
                      : const SizedBox(),
                  res.data?.twitter != null
                      ? ItemShareWidget(
                          socialMedia: "Twitter",
                          image: "assets/icons/x-social-media-logo-icon.png",
                          onShare: () async {
                            _launchUrlShare(res.data?.twitter ?? "");
                          })
                      : const SizedBox(),
                  res.data?.linkedin != null
                      ? ItemShareWidget(
                          socialMedia: "Linkedin",
                          image: "assets/icons/linkedin-app-icon.png",
                          onShare: () async {
                            _launchUrlShare(res.data?.linkedin ?? "");
                          })
                      : const SizedBox(),
                  res.data?.telegram != null
                      ? ItemShareWidget(
                          socialMedia: "Telegram",
                          image: "assets/icons/telegram-icon.png",
                          onShare: () async {
                            _launchUrlShare(res.data?.telegram ?? "");
                          })
                      : const SizedBox(),
                  res.data?.whatsapp != null
                      ? ItemShareWidget(
                          socialMedia: "Whatsapp",
                          onShare: () {
                            _launchUrlShare(res.data?.whatsapp ?? "");
                          },
                          image: "assets/icons/whatsapp-color-icon.png",
                        )
                      : const SizedBox(),
                  res.data?.others != null
                      ? ItemShareWidget(
                          socialMedia: "Others",
                          onShare: () {
                            flutterShareMe.shareToSystem(
                                msg: res.data?.others ?? "");
                          },
                          image: "assets/icons/forward-arrow-icon.png",
                        )
                      : const SizedBox(),
                ],
              ),
            );
          });
      notifyListeners();
    });
    notifyListeners();
  }

  bool isFollower = false;
  DataFollower? dataFollower;

  Future<void> getFollower(String id) async {
    isFollower = true;
    notifyListeners();

    Either<Failure, ResGetFollower> response = await repo.getFollower(id);

    isFollower = false;
    notifyListeners();

    response.when(error: (e) {
      NotificationUtils.showSnackbar(e.message, backgroundColor: Colors.red);
    }, success: (res) async {
      if (res.success == true) {
        dataFollower = res.data;
        notifyListeners();
      } else {}
    });
    notifyListeners();
  }

  bool isListPost = false;
  List<DataPost> listPost = [];

  Future<void> getListPost() async {
    isListPost = true;
    notifyListeners();

    Either<Failure, ResListPost> response = await repo.getListPost();

    isListPost = false;
    notifyListeners();

    response.when(error: (e) {
      NotificationUtils.showSnackbar(e.message, backgroundColor: Colors.red);
    }, success: (res) async {
      if (res.success == true) {
        listPost = res.data?.data ?? [];
        // listPost = listPost
        //     .where((element) => element.multimedia?.isNotEmpty == true)
        //     .toList();

        // for (DataPost dataPost in listPost) {
        //   getTotalCountByPost(dataPost.id.toString());
        // }

        notifyListeners();
      } else {}
    });
    notifyListeners();
  }

  bool isGetListComment = false;
  List<DataListComment> listComment = [];
  Future<void> getListComment(BuildContext context, String id) async {
    isListPost = true;
    notifyListeners();

    Either<Failure, ResGetListComment> response = await repo.getListComment(id);

    isListPost = false;
    notifyListeners();

    response.when(error: (e) {
      // NotificationUtils.showSnackbar(e.message, backgroundColor: Colors.red);
      NotificationUtils.showDialogError(context, () {
        Nav.back();
      },
          widget: Column(
            children: [
              Text(
                e.message ?? "",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              // const SizedBox(
              //   height: 4,
              // ),
              // Text(res.data?.blockWord?.join(', ') ?? "")
            ],
          ));
    }, success: (res) async {
      if (kDebugMode) {
        print("komen ok ${res.message}");
      }
      listComment = res.data?.data ?? [];
    });
    notifyListeners();
  }

  bool isDeletePost = false;
  Future<void> deletePost(int id, {Function? onUpdate}) async {
    isDeletePost = true;
    notifyListeners();

    Either<Failure, ResDeletePost> response = await repo.deletePost(id);

    isDeletePost = false;
    notifyListeners();

    response.when(error: (e) {
      NotificationUtils.showSnackbar(e.message, backgroundColor: Colors.red);
    }, success: (res) async {
      NotificationUtils.showSnackbar(res.message ?? "",
          backgroundColor: Colors.red);
      Nav.back();
      Nav.back();
      onUpdate!();
    });
    notifyListeners();
  }

  bool isPostReaction = false;

  Future<void> postReaction(String id, {Function? onLike}) async {
    isPostReaction = true;
    notifyListeners();

    Either<Failure, ResPostReaction> response = await repo.getPostReactions(id);

    isPostReaction = false;
    notifyListeners();

    response.when(error: (e) {
      NotificationUtils.showSnackbar(e.message, backgroundColor: Colors.red);
    }, success: (res) async {
      if (kDebugMode) {
        print("hasil ${res.success}");
      }
      onLike!();
    });
    notifyListeners();
  }

  bool isGetTotalCountByPost = false;
  DataTotalCountByPost? dataTotalCountByPost;

  Future<void> getTotalCountByPost(String id) async {
    isGetTotalCountByPost = true;
    notifyListeners();

    Either<Failure, ResGetTotalCountByPost> response =
        await repo.getTotalCountByPost(id);

    isGetTotalCountByPost = false;
    notifyListeners();

    response.when(
        error: (e) {},
        success: (res) async {
          if (kDebugMode) {
            print("total count ${res.message}");
          }
          dataTotalCountByPost = res.data;
          // dataTotalCountByPost = dataTotalCountByPost.
        });
    notifyListeners();
  }

  bool isUserProfilingById = false;
  UserProfiling? userProfiling;
  Future<void> getUserProfilingById(BuildContext context,
      {int? idProfiling}) async {
    isUserProfilingById = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    Either<Failure, ResGetUserProfiling> response =
        await repo.getUserProfilingByIdProfiling(id: idProfiling);

    isUserProfilingById = false;
    notifyListeners();

    response.when(error: (e) {
      NotificationUtils.showDialogError(context, () {
        Nav.back();
      },
          widget: Text(
            e.message,
            textAlign: TextAlign.center,
          ));
    }, success: (res) async {
      if (res.success == true) {
        userProfiling = res.data;
        notifyListeners();
      }
    });
    notifyListeners();
  }

  bool followUnFollow = false;
  FollowAkun? infoFollowAkun;

  Future<void> followAkun(String id, {Function? onUpdate}) async {
    followUnFollow = true;
    notifyListeners();

    Either<Failure, ResFollowAkun> response = await repo.followUnFollow(id);

    followUnFollow = false;
    notifyListeners();

    response.when(error: (e) {
      NotificationUtils.showSnackbar(e.message, backgroundColor: Colors.red);
    }, success: (res) async {
      if (res.success == true) {
        infoFollowAkun = res.data;
        onUpdate!();
        NotificationUtils.showSnackbar(res.message ?? "",
            backgroundColor: primaryColor);
      }
    });
    notifyListeners();
  }

  bool isComment = false;
  TextEditingController etComment = TextEditingController();

  Future<void> commentPost(int idPost, String comment, int isAnonim,
      {Function? onUpdate}) async {
    isComment = true;
    notifyListeners();

    Either<Failure, ResCreateComment> response =
        await repo.commendPost(idPost, comment, isAnonim);

    isComment = false;
    notifyListeners();

    response.when(error: (e) {
      NotificationUtils.showSnackbar(e.message, backgroundColor: Colors.red);
    }, success: (res) async {
      if (res.success == true) {
        onUpdate!();
        etComment.text = "";
        // Nav.back();
        NotificationUtils.showSnackbar(res.message ?? "",
            backgroundColor: primaryColor);
      }
    });
    notifyListeners();
  }

  bool isCekFollowing = false;
  DataFollowing? dataFollowing;

  Future<void> getCekFollowing(String idUserFollowing) async {
    isCekFollowing = true;
    notifyListeners();

    Either<Failure, ResCekFollow> response =
        await repo.cekFollower(idUserFollowing);

    isCekFollowing = false;
    notifyListeners();

    response.when(error: (e) {
      NotificationUtils.showSnackbar(e.message, backgroundColor: Colors.red);
    }, success: (res) async {
      if (res.success == true) {
        dataFollowing = res.data;
        if (kDebugMode) {
          print("data follow ${dataFollowing?.toJson()}");
        }
        notifyListeners();
      }
    });
    notifyListeners();
  }

  ResSearchContent? resSearchContent;
  List<ProfilingDatum> profilingSearch = [];
  List<DataPost> postsSearch = [];

  int page = 1;
  bool hasMore = true;
  final int _limit = 10;

  bool isSearchContent = false;
  Future<void> searchAnything(
    BuildContext context,
    String query,
  ) async {
    isSearchContent = true;
    notifyListeners();

    Either<Failure, ResSearchContent> response =
        await repo.searchAnything(query, page);

    isSearchContent = false;
    notifyListeners();

    response.when(error: (e) {
      NotificationUtils.showDialogError(
        context,
        () {
          Nav.back();
        },
        widget: Text(
          e.message,
          textAlign: TextAlign.center,
        ),
      );
    }, success: (res) async {
      resSearchContent = res;
      int panjangDataPost = res.data?.posts?.data?.length ?? 0;
      int panjangDataProfiling = res.data?.profiling?.data?.length ?? 0;
      bool isLengthLessThanLimit =
          panjangDataPost < _limit || panjangDataProfiling < _limit;
      if (isLengthLessThanLimit) {
        hasMore = false;
      }

      postsSearch.addAll(res.data?.posts?.data ?? []);
      profilingSearch.addAll(res.data?.profiling?.data ?? []);

      page++;
      notifyListeners();
    });

    notifyListeners();
  }

  Future refreshSearchAnything(BuildContext context, String query) async {
    page = 1;

    postsSearch = [];
    profilingSearch = [];

    hasMore = true;
    await searchAnything(context, query);
    notifyListeners();
  }

  bool isCekLikes = false;
  DataCekList? cekLike;

  Future<void> getCekLikes(String idPost) async {
    isCekLikes = true;
    notifyListeners();

    Either<Failure, ResCekLike> response = await repo.cekLikes(idPost);

    isCekLikes = false;
    notifyListeners();

    response.when(error: (e) {
      NotificationUtils.showSnackbar(e.message, backgroundColor: Colors.red);
    }, success: (res) async {
      if (res.success == true) {
        cekLike = res.data;
        if (kDebugMode) {
          print('cek list $cekLike');
        }

        notifyListeners();
      }
    });
    notifyListeners();
  }
}
