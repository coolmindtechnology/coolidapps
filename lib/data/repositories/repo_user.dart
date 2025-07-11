import 'dart:io';

import 'package:coolappflutter/data/data_global.dart';
import 'package:coolappflutter/data/helpers/either.dart';
import 'package:coolappflutter/data/helpers/failure.dart';
import 'package:coolappflutter/data/networks/dio_handler.dart';
import 'package:coolappflutter/data/networks/endpoint/api_endpoint.dart';
import 'package:coolappflutter/data/networks/error_handler.dart';
import 'package:coolappflutter/data/response/user/res_address.dart';
import 'package:coolappflutter/data/response/user/res_category_bug.dart';
import 'package:coolappflutter/data/response/user/res_check_profile.dart';
import 'package:coolappflutter/data/response/user/res_get_deetail_report.dart';
import 'package:coolappflutter/data/response/user/res_get_log_report.dart';
import 'package:coolappflutter/data/response/user/res_get_massage.dart';
import 'package:coolappflutter/data/response/user/res_get_total_saldo.dart';
import 'package:coolappflutter/data/response/user/res_get_user.dart';
import 'package:coolappflutter/data/response/user/res_post_close_massage.dart';
import 'package:coolappflutter/data/response/user/res_report_bug.dart';
import 'package:coolappflutter/data/response/user/res_send_massage.dart';
import 'package:coolappflutter/data/response/user/res_update_photo_user.dart';
import 'package:coolappflutter/data/response/user/res_update_user.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../response/user/res_get_location_member.dart';
import 'package:path/path.dart';

class RepoUser {
  //update user
  Future<Either<Failure, ResUpdateUser>> updateUser({
    String? name,
    String? email,
    String? phoneNumber,
    String? idCardNumber,
    String? address,
    String? country,
    String? state,
    String? city,
    String? district,
    String? longtitude,
    String? latitude,
  }) async {
    final dataBody = {
      'name': name,
      'email': email,
      'phone_number': phoneNumber,
      'id_card_number': idCardNumber,
      'address': address,
      'country': country,
      'state': state,
      'city': city,
      'district': district,
      'longtitude': longtitude,
      'latitude': latitude,
    };

    // Hapus field yang bernilai null
    dataBody.removeWhere((key, value) => value == null || value.toString().trim().isEmpty);

    Response res = await dio.post(
      ApiEndpoint.updateUser,
      data: dataBody,
      options: Options(
        validateStatus: (status) => status == 200 || status == 400,
        headers: {
          'Authorization': dataGlobal.token,
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    try {
      return Either.success(ResUpdateUser.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        debugPrint("Parsing error: $e");
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }


//get address user
  Future<Either<Failure, AddressResponse>> getAddress() async {
    try {
      Response res = await dio.get(ApiEndpoint.getAddress,
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization': dataGlobal.token},
          ));

      return Either.success(AddressResponse.fromJson(res.data));
    } catch (e, st) {
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

  Future<Either<Failure, ResGetCategory>> getCategoryBug() async {
    try {
      Response res = await dio.get(ApiEndpoint.getCategoryBug,
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            headers: {'Authorization': dataGlobal.token},
          ));

      return Either.success(ResGetCategory.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResReportBug>> ReportBugByUser(
      List<int> categories, String body, File? media) async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final String versionNumber = packageInfo.version;
    Map<String, dynamic> data = {};
    data["category_id"] = categories; // Pastikan categories adalah array
    data["app_version"] = versionNumber; // Pastikan categories adalah array
    data["body"] = body;
    if (media != null) {
      data["media"] = await MultipartFile.fromFile(
        media.path,
        filename: basename(media.path),
      );
    }
    try {
      Response res = await dio.post(
        ApiEndpoint.ReportBugByUser,
        data: FormData.fromMap(data),
        options: Options(
          validateStatus: (status) {
            return status == 200 || status == 400;
          },
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
          headers: {'Authorization': dataGlobal.token},
        ),
      );

      return Either.success(ResReportBug.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResGetLogReport>> getLogReport() async {
    try {
      Response res = await dio.get(ApiEndpoint.ReportBugByUser,
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            headers: {'Authorization': dataGlobal.token},
          ));

      return Either.success(ResGetLogReport.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

 Future<Either<Failure, ResGetDetailLogReport>> getDetailLogReport(String? id) async {
    try {
      Response res = await dio.get(ApiEndpoint.ReportBugByUser+'?report_id=$id',
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            headers: {
              'Authorization': dataGlobal.token
            },
          ));

      return Either.success(ResGetDetailLogReport.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }


  Future<Either<Failure, ResGetMassageReport>> getMassageRepot(String? id_log) async {
    try {
      Response res = await dio.get(ApiEndpoint.getMassageReport,
          data: {
            "id_log": id_log,
          },
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
          ));

      return Either.success(ResGetMassageReport.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }


  Future<Either<Failure, ResGetMassage>> sendMassageReport({
    required String idLog,
    required String idReceiver,
    required String message,
    required File? image, // nullable, kalau tidak upload file
  }) async {
    try {
      // Buat FormData
      FormData formData = FormData.fromMap({
        "id_log": idLog,
        "id_receiver": idReceiver,
        "message": message,
        if (image != null)
          "image": await MultipartFile.fromFile(
            image.path,
            filename: image.path.split('/').last,
          ),
      });

      Response res = await dio.post(
        ApiEndpoint.sendMassageReport,
        data: formData,
        options: Options(
          validateStatus: (status) => status == 200 || status == 400,
          headers: {'Authorization': dataGlobal.token},
        ),
      );

      return Either.success(ResGetMassage.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }


  Future<Either<Failure, ResPostCloseMassage>> closeMassageRepot(String? id) async {
    try {
      Response res = await dio.post(ApiEndpoint.closeMassageReport(id),
          data: {
            "close" : true
          },
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            headers: {
              'Authorization': dataGlobal.token
            },
          ));

      return Either.success(ResPostCloseMassage.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }











}
