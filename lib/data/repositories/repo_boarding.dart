import 'dart:io';

import 'package:coolappflutter/data/helpers/either.dart';
import 'package:coolappflutter/data/helpers/failure.dart';
import 'package:coolappflutter/data/networks/dio_handler.dart';
import 'package:coolappflutter/data/networks/endpoint/api_endpoint.dart';
import 'package:coolappflutter/data/networks/error_handler.dart';
import 'package:coolappflutter/data/response/boarding/res_get_version_app.dart';
import 'package:coolappflutter/data/response/boarding/res_on_boarding.dart';
import 'package:coolappflutter/data/response/boarding/res_splash_screen.dart';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class RepoBoarding {
  Future<Either<Failure, ResSplashScreen>> getSplashLogo() async {
    try {
      Response res = await dio.get(
        ApiEndpoint.splashScreen,
        options: Options(
          validateStatus: (status) {
            return status != 401;
          },
          // Menambahkan header untuk CORS di Flutter Web
          headers: {
            'Access-Control-Allow-Origin':
                '*', // Mengizinkan permintaan dari semua asal
            'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
            'Access-Control-Allow-Headers': 'Origin, Content-Type',
          },
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ),
      );

      return Either.success(ResSplashScreen.fromJson(res.data));
    } catch (e, st) {
      debugPrint("Error ${st.toString()}");
      debugPrint("Error ${e.toString()}");
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResOnBoarding>> getOnBoarding() async {
    try {
      Response res = await dio.get(
        ApiEndpoint.onBoarding,
        options: Options(
          headers: {
            'Access-Control-Allow-Origin': '*',
            'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
            'Access-Control-Allow-Headers': 'Origin, Content-Type',
          },
          validateStatus: (status) {
            return status != 401;
          },
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ),
      );

      return Either.success(ResOnBoarding.fromJson(res.data));
    } catch (e, st) {
      debugPrint("Error ${st.toString()}");
      debugPrint("Error ${e.toString()}");
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResGetVersionApp>> getVersionApp() async {
    try {
      Response res = await dio.get(
        ApiEndpoint.versionApp,
        options: Options(
          headers: {
            'Access-Control-Allow-Origin': '*',
            'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
            'Access-Control-Allow-Headers': 'Origin, Content-Type',
          },
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ),
      );

      return Either.success(ResGetVersionApp.fromJson(res.data));
    } catch (e, st) {
      debugPrint("Error ${st.toString()}");
      debugPrint("Error ${e.toString()}");
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }
}
