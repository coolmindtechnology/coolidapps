import 'package:cool_app/data/helpers/either.dart';
import 'package:cool_app/data/helpers/failure.dart';
import 'package:cool_app/data/networks/dio_handler.dart';
import 'package:cool_app/data/networks/endpoint/api_endpoint.dart';
import 'package:cool_app/data/networks/error_handler.dart';
import 'package:cool_app/data/response/boarding/res_get_version_app.dart';
import 'package:cool_app/data/response/boarding/res_on_boarding.dart';
import 'package:cool_app/data/response/boarding/res_splash_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class RepoBoarding {
  Future<Either<Failure, ResSplashScreen>> getSplashLogo() async {
    Response res = await dio.get(ApiEndpoint.splashScreen,
        options: Options(
          validateStatus: (status) {
            return status != 401;
          },
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ));
    try {
      return Either.success(ResSplashScreen.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResOnBoarding>> getOnBoarding() async {
    Response res = await dio.get(ApiEndpoint.onBoarding,
        options: Options(
          validateStatus: (status) {
            return status != 401;
          },
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ));
    try {
      return Either.success(ResOnBoarding.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResGetVersionApp>> getVersionApp() async {
    try {
      Response res = await dio.get(ApiEndpoint.versionApp,
          options: Options(
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
          ));
      return Either.success(ResGetVersionApp.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }
}
