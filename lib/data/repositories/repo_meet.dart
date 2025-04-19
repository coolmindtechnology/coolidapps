import 'package:coolappflutter/data/data_global.dart';
import 'package:coolappflutter/data/helpers/either.dart';
import 'package:coolappflutter/data/networks/dio_handler.dart';
import 'package:coolappflutter/data/networks/error_handler.dart';
import 'package:coolappflutter/data/response/consultation/res_list_consultation.dart';
import 'package:coolappflutter/data/response/meet/res_GetDetailMeet.dart';
import 'package:coolappflutter/data/response/meet/res_GetHistoryMeet.dart';
import 'package:coolappflutter/data/response/meet/res_GetListMeet.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../helpers/failure.dart';
import '../networks/endpoint/api_endpoint.dart';

class RepoMeet {


  Future<Either<Failure, ResGetListMeet>> getlistMeet(
      {String? token}) async {
    try {
      Response res = await dio.get(ApiEndpoint.getallsessionmeet,
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            headers: {'Authorization': dataGlobal.token},
          ));

      return Either.success(ResGetListMeet.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResGetDetailMeet>> GetDetailMeet(
      {String? token, String? id}) async {
    try {
      Response res = await dio.get('${ApiEndpoint.getallsessionmeet}?id=$id',
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            headers: {'Authorization': dataGlobal.token},
          ));

      return Either.success(ResGetDetailMeet.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResGetHistoryMeet>> getHistoryMeet(
      {String? token}) async {
    try {
      Response res = await dio.get(ApiEndpoint.getlogmeet,
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            headers: {'Authorization': dataGlobal.token},
          ));

      return Either.success(ResGetHistoryMeet.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

}
