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
  Future<Either<Failure, ResponseListConsultation>>
      getListColcultation() async {
    Response res = await dio.get(ApiEndpoint.getListConsultation,
        options: Options(
          validateStatus: (status) {
            return status == 200 || status == 400;
          },
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
          headers: {'Authorization': dataGlobal.token},
        ));
    try {
      return Either.success(ResponseListConsultation.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }
}
