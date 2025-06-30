
import 'package:coolappflutter/data/data_global.dart';
import 'package:coolappflutter/data/helpers/either.dart';
import 'package:coolappflutter/data/networks/endpoint/api_endpoint.dart';
import 'package:coolappflutter/data/networks/error_handler.dart';
import 'package:coolappflutter/data/response/curhat/res_create_curhat.dart';
import 'package:coolappflutter/data/response/curhat/res_getlist_curhat.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../helpers/failure.dart';
import '../networks/dio_handler.dart';

class RepoCurhat {
  Future<Either<Failure, ResGetListCurhat>> getlistCurhat(
      {String? parameter}) async {
    try {
      // Membentuk URL dengan menambahkan parameter category ke query string jika parameter tidak null
      String url =
          '${ApiEndpoint.getListConsultation}/?type=$parameter&type_session=curhat';

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
      return Either.success(ResGetListCurhat.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st); // Menampilkan error jika ada
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure,ResponseCreateCurhat>> CreateCurhat(
      String consultanId,String themeid,String time,{String? participantexplanation}) async {
    try {
      final data = {
        "consultation_id": consultanId,
        "theme_id" : themeid,
        "time" : time,
        "type_session" : "curhat",
        if (participantexplanation != null)
          "participant_explanation": participantexplanation, // Menambahkan hanya jika note tidak null
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

      return Either.success(ResponseCreateCurhat.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }
}