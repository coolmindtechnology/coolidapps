// ignore_for_file: depend_on_referenced_packages

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
import 'package:cool_app/data/response/cool_chat/res_list_cool_chat_byid.dart';
import 'package:cool_app/data/response/cool_chat/res_list_post.dart';
import 'package:cool_app/data/response/cool_chat/res_post_reaction.dart';
import 'package:cool_app/data/response/cool_chat/res_search_content.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import '../data_global.dart';
import '../helpers/either.dart';
import '../helpers/failure.dart';
import '../networks/dio_handler.dart';
import '../networks/endpoint/api_endpoint.dart';
import 'package:path/path.dart';
import 'package:mime/mime.dart';
import '../networks/error_handler.dart';
import '../response/profiling/res_get_user_profiling.dart';
import '../response/profiling/res_share_result_detail.dart';

class RepoCoolChat {
  Future<Either<Failure, ResListCoolChatById>> getListPostByUserId(
      String id) async {
    try {
      Response res = await dio.get(ApiEndpoint.listPostByUserId(id),
          options: Options(
            validateStatus: (status) {
              return status != 401;
            },
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization': dataGlobal.token},
          ));
      return Either.success(ResListCoolChatById.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResCreatePost>> addPost(
      String desc, String embedUrl, List<XFile>? files) async {
    try {
      Map<String, dynamic> gambar = {};
      gambar["id_user"] = "${dataGlobal.dataUser?.id}";
      gambar["title"] = "";
      gambar["description"] = desc;
      gambar["embed_url"] = embedUrl;
      gambar["is_comment"] = "1";

      for (int i = 0; i < (files?.length ?? 0); i++) {
        if (files?[i] == null) continue;
        final file = files![i];

        final typeFile = lookupMimeType(file.path)?.split("/").first;
        gambar["$typeFile[]"] = await MultipartFile.fromFile(file.path,
            filename: basename(file.path),
            contentType: MediaType.parse('video/mp4'));
      }
      Response res = await dio.post(ApiEndpoint.addPost,
          data: FormData.fromMap(gambar),
          options: Options(
            validateStatus: (status) {
              return status != 401;
            },
            responseType: ResponseType.json,
            contentType: Headers.jsonContentType,
            headers: {'Authorization': dataGlobal.token},
          ));
      return Either.success(ResCreatePost.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResGetPostShare>> getShareCode(int id) async {
    try {
      Response res = await dio.get(ApiEndpoint.apiGetShareCode(id),
          options: Options(
            validateStatus: (status) {
              return status != 401;
            },
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization': dataGlobal.token},
          ));
      return Either.success(ResGetPostShare.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResShareResultDetail>> sharePost(
      String? shareCode) async {
    try {
      Response res = await dio.post(ApiEndpoint.apiSharePost,
          data: {"share_code": shareCode},
          options: Options(
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization': dataGlobal.token},
          ));
      return Either.success(ResShareResultDetail.fromJson(res.data));
    } catch (e) {
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResGetFollower>> getFollower(String id) async {
    try {
      Response res = await dio.get(ApiEndpoint.apiGetFollower(id),
          options: Options(
            validateStatus: (status) {
              return status != 401;
            },
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization': dataGlobal.token},
          ));
      return Either.success(ResGetFollower.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResListPost>> getListPost() async {
    try {
      Response res = await dio.get(ApiEndpoint.apiGetPost,
          options: Options(
            validateStatus: (status) {
              return status != 401;
            },
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization': dataGlobal.token},
          ));
      return Either.success(ResListPost.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResGetListComment>> getListComment(String id) async {
    try {
      Response res = await dio.get(ApiEndpoint.chatGetListComment(id),
          options: Options(
            validateStatus: (status) {
              return status != 401;
            },
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization': dataGlobal.token},
          ));
      return Either.success(ResGetListComment.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResDeletePost>> deletePost(int id) async {
    try {
      Response res = await dio.get(ApiEndpoint.deletePost(id),
          options: Options(
            headers: {'Authorization': dataGlobal.token},
          ));
      return Either.success(ResDeletePost.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResPostReaction>> getPostReactions(String id) async {
    try {
      Response res = await dio.post(ApiEndpoint.postReaction,
          data: {"post_id": id},
          options: Options(
            validateStatus: (status) {
              return status != 401;
            },
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization': dataGlobal.token},
          ));
      return Either.success(ResPostReaction.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResGetTotalCountByPost>> getTotalCountByPost(
      String id) async {
    try {
      Response res = await dio.get(ApiEndpoint.totalCountByPost(id),
          options: Options(
            validateStatus: (status) {
              return status != 401;
            },
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization': dataGlobal.token},
          ));
      return Either.success(ResGetTotalCountByPost.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResGetUserProfiling>> getUserProfilingByIdProfiling(
      {int? id}) async {
    try {
      Response res =
          await dio.get(ApiEndpoint.getUserProfilingByIdProfiling(id),
              options: Options(
                // validateStatus: (_) => true,
                contentType: Headers.jsonContentType,
                responseType: ResponseType.json,
                headers: {'Authorization': dataGlobal.token},
              ));
      return Either.success(ResGetUserProfiling.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResFollowAkun>> followUnFollow(String userId) async {
    try {
      Response res = await dio.post(ApiEndpoint.followAkun,
          data: {"user_id": userId},
          options: Options(
            validateStatus: (status) {
              return status != 401;
            },
            headers: {'Authorization': dataGlobal.token},
          ));
      return Either.success(ResFollowAkun.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResCreateComment>> commendPost(
      int idPost, String comment, int isAnonim) async {
    try {
      Map<String, dynamic> data = {};
      data["id_post"] = idPost;
      data["comment"] = comment;
      data["is_anonim"] = isAnonim;

      Response res = await dio.post(ApiEndpoint.commentPost,
          data: data,
          options: Options(
            headers: {'Authorization': dataGlobal.token},
          ));
      return Either.success(ResCreateComment.fromJson(res.data));
    } on DioException catch (e) {
      return Either.error(ErrorHandler.handle(e).failure);
    } catch (e, st) {
      if (kDebugMode) {
        print(e.toString());
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResCekFollow>> cekFollower(
      String idUserFollowing) async {
    try {
      Response res = await dio.get(ApiEndpoint.cekHasFollow(idUserFollowing),
          options: Options(
            headers: {'Authorization': dataGlobal.token},
          ));
      return Either.success(ResCekFollow.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  //search anything
  Future<Either<Failure, ResSearchContent>> searchAnything(
      String query, int page) async {
    try {
      Response res = await dio.post("${ApiEndpoint.searchAnything}?page=$page",
          data: {"query": query},
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization': dataGlobal.token},
          ));
      return Either.success(ResSearchContent.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResCekLike>> cekLikes(String idPost) async {
    try {
      Response res = await dio.get(ApiEndpoint.cekHasLike(idPost),
          options: Options(
            headers: {'Authorization': dataGlobal.token},
          ));
      return Either.success(ResCekLike.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }
}
