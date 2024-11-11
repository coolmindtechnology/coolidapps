import 'dart:convert';

import 'package:coolappflutter/data/data_global.dart';
import 'package:coolappflutter/data/helpers/either.dart';
import 'package:coolappflutter/data/helpers/failure.dart';
import 'package:coolappflutter/data/networks/dio_handler.dart';
import 'package:coolappflutter/data/networks/endpoint/api_endpoint.dart';
import 'package:coolappflutter/data/networks/error_handler.dart';
import 'package:coolappflutter/data/response/affiliate/res_cek_is_affiliate.dart';
import 'package:coolappflutter/data/response/affiliate/res_register_affiliate.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class RepoAuthAffiliate {
  Future<Either<Failure, ResRegisterffiliate>> registerAffiliate(
      String codeReferal) async {
    try {
      debugPrint("masuk code ${codeReferal.toString()}");
      Response res = await dio.post(ApiEndpoint.affiliateRegister,
          data: {"code_referal": codeReferal},
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization': dataGlobal.token},
          ));
      // debugPrint("masuk code ${jsonDecode(res.data)}");

      return Either.success(ResRegisterffiliate.fromJson(res.data));
    } catch (e, st) {
      debugPrint("masuk code ${e.toString()} ${st.toString()}");
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResCekIsAffiliate>> checkIsAffiliate() async {
    try {
      Response res = await dio.get(ApiEndpoint.checkIsAffiliate,
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization': dataGlobal.token},
          ));

      return Either.success(ResCekIsAffiliate.fromJson(res.data));
    } catch (e, st) {
      debugPrint(" cek affiliate $e");
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }
}
