import 'package:coolappflutter/data/data_global.dart';
import 'package:coolappflutter/data/helpers/failure.dart';
import 'package:coolappflutter/data/networks/dio_handler.dart';
import 'package:coolappflutter/data/networks/endpoint/api_endpoint.dart';
import 'package:coolappflutter/data/networks/error_handler.dart';
import 'package:coolappflutter/data/response/consultant/res_approval_by_consultant.dart';
import 'package:coolappflutter/data/response/consultant/res_approval_summary.dart';
import 'package:coolappflutter/data/response/consultant/res_check_session.dart';
import 'package:coolappflutter/data/response/consultant/res_dashboard_consultant.dart';
import 'package:coolappflutter/data/response/consultant/res_get_comissen.dart';
import 'package:coolappflutter/data/response/consultant/res_get_participant.dart';
import 'package:coolappflutter/data/response/consultant/res_get_term.dart';
import 'package:coolappflutter/data/response/consultant/res_regist_consultant.dart';
import 'package:coolappflutter/data/response/consultant/res_update_status.dart';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../helpers/either.dart';

class RepoConsultant {
  Future<Either<Failure, ResRegistConsultant>> registerconsultant({
    required List<String>
        title_experience, // Menggunakan List untuk title_experience
    required List<String>
        description_experience, // Menggunakan List untuk description_experience
    required List<String> documents, // Menggunakan List untuk document
  }) async {
    try {
      // Membuat FormData untuk mengirim data
      FormData formData = FormData();

      // Menambahkan title dan description
      formData.fields
          .add(MapEntry('title_experience', title_experience.join(',')));
      formData.fields.add(
          MapEntry('description_experience', description_experience.join(',')));

      // Menambahkan semua dokumen ke formData
      for (String document in documents) {
        formData.files.add(
            MapEntry('document[]', await MultipartFile.fromFile(document)));
      }

      // Mengirim data ke server
      Response res = await dio.post(
        ApiEndpoint.registerConsultant,
        data: formData,
        options: Options(
          validateStatus: (status) {
            return status == 200 || status == 400;
          },
          headers: {
            'Authorization': dataGlobal.token,
            'Accept': 'application/json',
            // Content-Type tidak perlu ditentukan di sini, dio akan mengatur otomatis
          },
        ),
      );

      if (res.statusCode == 200) {
        return Either.success(ResRegistConsultant.fromJson(res.data));
      } else {
        return Either.error(ErrorHandler.handle(res).failure);
      }
    } catch (e, st) {
      debugPrint("Error: $e");
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResApprovalConsultant>> getSummary(
      {String? token}) async {
    try {
      Response res = await dio.get(ApiEndpoint.getSummaryApproval,
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            headers: {'Authorization': dataGlobal.token},
          ));

      return Either.success(ResApprovalConsultant.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResHomeConsultant>> getHomeConsultant(
      {String? token}) async {
    try {
      Response res = await dio.get(ApiEndpoint.getHomeConsultant,
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            headers: {'Authorization': dataGlobal.token},
          ));

      return Either.success(ResHomeConsultant.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResGetParticipant>> getListParticipant(
      {String? parameter}) async {
    try {
      // Membentuk URL dengan menambahkan parameter category ke query string jika parameter tidak null
      String url =
          '${ApiEndpoint.getParticipant}?category=${parameter ?? 'archive'}';

      // Melakukan request GET
      Response res = await dio.get(
        url,
        options: Options(
          validateStatus: (status) {
            return status == 200 || status == 400;
          },
          headers: {
            'Authorization': dataGlobal.token, // Header Authorization
          },
        ),
      );

      // Mengembalikan hasil response dari API
      return Either.success(ResGetParticipant.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st); // Menampilkan error jika ada
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResGetTerm>> getTermCondition({String? token}) async {
    try {
      Response res = await dio.get(ApiEndpoint.getTermConsultant,
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            headers: {'Authorization': dataGlobal.token},
          ));

      return Either.success(ResGetTerm.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResGetComissen>> getComissen({String? token}) async {
    try {
      Response res = await dio.get(ApiEndpoint.getHistoryCommission,
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            headers: {'Authorization': dataGlobal.token},
          ));

      return Either.success(ResGetComissen.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResUpdateStatus>> updateStatus(int Status) async {
    try {
      Response res = await dio.post(
          ApiEndpoint.updateAvailable(dataGlobal.dataConsultant?.id),
          data: {
            "available_status": Status,
          },
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            headers: {'Authorization': dataGlobal.token},
          ));

      return Either.success(ResUpdateStatus.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResApproveByConsultant>> ApproveByConsultant(
      int consultationId, String status,
      {String? note}) async {
    try {
      final data = {
        "consultation_id": consultationId,
        "status_approval": status,
        if (note != null)
          "note_consultant": note, // Menambahkan hanya jika note tidak null
      };

      Response res = await dio.post(
        ApiEndpoint.approveByConsultant,
        data: data,
        options: Options(
          validateStatus: (status) {
            return status == 200 || status == 400;
          },
          headers: {'Authorization': dataGlobal.token},
        ),
      );

      return Either.success(ResApproveByConsultant.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResCheckSession>> checkSession(
      {String? token}) async {
    try {
      Response res = await dio.get(ApiEndpoint.checkSession,
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            headers: {'Authorization': dataGlobal.token},
          ));

      return Either.success(ResCheckSession.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

}
