import 'package:coolappflutter/data/data_global.dart';
import 'package:coolappflutter/data/helpers/either.dart';
import 'package:coolappflutter/data/helpers/failure.dart';
import 'package:coolappflutter/data/networks/dio_handler.dart';
import 'package:coolappflutter/data/networks/endpoint/api_endpoint.dart';
import 'package:coolappflutter/data/networks/error_handler.dart';
import 'package:coolappflutter/data/response/user/res_check_profile.dart';
import 'package:coolappflutter/data/response/user/res_get_total_saldo.dart';
import 'package:coolappflutter/data/response/user/res_get_user.dart';
import 'package:coolappflutter/data/response/user/res_update_photo_user.dart';
import 'package:coolappflutter/data/response/user/res_update_user.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

import '../response/user/res_get_location_member.dart';
import 'package:path/path.dart';

class RepoUser {
  //update user
  Future<Either<Failure, ResUpdateUser>> updateUser({
    required String name,
    required String email,
    required String phoneNumber,
    required String idCardNumber,
    required String address,
  }) async {
    Response res = await dio.post(ApiEndpoint.updateUser,
        data: {
          'name': name,
          'email': email,
          'phone_number': phoneNumber,
          'id_card_number': idCardNumber,
          'address': address,
        },
        options: Options(
          validateStatus: (status) {
            return status == 200 || status == 400;
          },
          headers: {
            'Authorization': dataGlobal.token,
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ));
    debugPrint("cek settings");

    try {
      debugPrint("cek settings s");
      return Either.success(ResUpdateUser.fromJson(res.data));
    } catch (e, st) {
      debugPrint("cek settings $e");
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  //get user

  Future<Either<Failure, ResGetUser>> getUser({String? token}) async {
    try {
      Response res = await dio.post(ApiEndpoint.getUser,
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization': dataGlobal.token},
          ));

      return Either.success(ResGetUser.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResMemberArea>> cekMemberArea() async {
    try {
      Response res = await dio.get(ApiEndpoint.cekAsalMember,
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization': dataGlobal.token},
          ));
      return Either.success(ResMemberArea.fromJson(res.data));
    } catch (e, st) {
      debugPrint("cek settingsss $e");
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResUpdateProfile>> updatePhotoUser(XFile image) async {
    Map<String, dynamic> data = {};
    data["id_user"] = "${dataGlobal.dataUser?.id}";
    data["image"] = await MultipartFile.fromFile(
      image.path,
      filename: basename(image.path),
    );
    Response res = await dio.post(ApiEndpoint.updatePhotoUser,
        data: FormData.fromMap(data),
        options: Options(
          validateStatus: (status) {
            return status == 200 || status == 400;
          },
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
          headers: {'Authorization': dataGlobal.token},
        ));
    try {
      return Either.success(ResUpdateProfile.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResCheckProfile>> checkProfile() async {
    try {
      Response res = await dio.get(ApiEndpoint.checkProfile,
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization': dataGlobal.token},
          ));
      return Either.success(ResCheckProfile.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResGetTotalSaldo>> getTotalSaldo(
      bool isIndonesia) async {
    try {
      Response res = await dio.get(ApiEndpoint.getTotalSaldo,
          queryParameters: {"is_abroad": isIndonesia ? "0" : "1"},
          options: Options(
            headers: {'Authorization': dataGlobal.token},
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
          ));
      return Either.success(ResGetTotalSaldo.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(
          st,
        );
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }
}
