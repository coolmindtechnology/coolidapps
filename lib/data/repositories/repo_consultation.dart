import 'package:coolappflutter/data/data_global.dart';
import 'package:coolappflutter/data/helpers/either.dart';
import 'package:coolappflutter/data/networks/dio_handler.dart';
import 'package:coolappflutter/data/networks/error_handler.dart';
import 'package:coolappflutter/data/response/consultation/res_list_consultation.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../helpers/failure.dart';
import '../networks/endpoint/api_endpoint.dart';

class RepoConsultation {


  Future<Either<Failure, ResponseListConsultation>> getlistConsultation(
      {String? parameter}) async {
    try {
      // Membentuk URL dengan menambahkan parameter category ke query string jika parameter tidak null
      String url =
          '${ApiEndpoint.getListConsultation}/?type=$parameter&type_sesion=consultation';

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
      return Either.success(ResponseListConsultation.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st); // Menampilkan error jika ada
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }
}
