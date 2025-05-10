import 'dart:convert';
import 'dart:developer';

import 'package:coolappflutter/data/data_global.dart';
import 'package:coolappflutter/data/helpers/either.dart';
import 'package:coolappflutter/data/helpers/failure.dart';
import 'package:coolappflutter/data/networks/dio_handler.dart';
import 'package:coolappflutter/data/networks/endpoint/api_endpoint.dart';
import 'package:coolappflutter/data/networks/error_handler.dart';
import 'package:coolappflutter/data/response/auth/res_get_otp.dart';
import 'package:coolappflutter/data/response/auth/res_logout.dart';
import 'package:coolappflutter/data/response/auth/res_register.dart';
import 'package:coolappflutter/data/response/auth/res_resend_otp.dart';
import 'package:coolappflutter/data/response/auth/res_reset_password.dart';
import 'package:coolappflutter/data/response/auth/res_send_otp.dart';
import 'package:coolappflutter/data/response/auth/res_update_password.dart';
import 'package:coolappflutter/data/response/auth/res_verify_otp.dart';
import 'package:coolappflutter/data/response/auth/res_login.dart';
import 'package:coolappflutter/data/response/user/res_get_location_member.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class Authentication {
  /// Logs in a user with the provided phone number and password.
  ///
  /// Throws a [Failure] if an error occurs during the login process.
  ///
  /// Parameters:
  /// - [phoneNumber] (String): The user's phone number.
  /// - [password] (String): The user's password.
  ///
  /// Returns:
  /// - [Future<Either<Failure, ResLogin>>]: A future that resolves to either a
  ///   [Failure] or a [ResLogin] object.
  Future<Either<Failure, ResLogin>> login(
      {required String phoneNumber,
      required String password,
      required String fcmToken}) async {
    try {
      debugPrint("fcmm $fcmToken");
      Response res = await dio.post(ApiEndpoint.loginWithPhone,
          data: {
            'phone_number': phoneNumber,
            'password': password,
            'fcm_token': fcmToken
          },
          options: Options(
            validateStatus: (status) {
              return true;
            },
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization': dataGlobal.token},
          ));
      return Either.success(ResLogin.fromJson(res.data));
    } catch (e) {
      debugPrint("mm $e");
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  //register
  /// Registers a new user with the provided phone number, password, confirmation password,
  /// email, channel, and referral code.
  ///
  /// Returns a [Future] that resolves to either a [Failure] or a [ResRegister] object.
  ///
  /// Parameters:
  /// - [phoneNumber] (String): The user's phone number.
  /// - [password] (String): The user's password.
  /// - [confirmPassword] (String): The user's confirmation password.
  /// - [email] (String): The user's email.
  /// - [channel] (String): The channel of the user.
  /// - [codeReferal] (String?): The referral code of the user.
  ///
  /// Throws:
  /// - [Failure]: If an error occurs during the registration process.
  Future<Either<FailedModel, ResRegister>> register(
      {required String phoneNumber,
      required String password,
      required String confirmPassword,
      required String email,
      required String channel,
      required String countryId,
      required String stateId,
      required String cityId,
      required String districtId,
      required String longitude,
      required String latitude,
      String? codeReferal}) async {
    try {
      Response res = await dio.post(ApiEndpoint.register,
          data: {
            'phone_number': phoneNumber,
            'password': password,
            'password_confirmation': confirmPassword,
            'email': email,
            'channel': channel,
            'code_referal': codeReferal,
            "country": countryId,
            "state": stateId,
            "city": cityId,
            "district": districtId,
            "longitude": longitude,
            "latitude": latitude
          },
          options: Options(
            validateStatus: (status) {
              return status == 201 || status == 422 || status == 500;
            },
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json',
            },
          ));
      if (res.statusCode == 422 || res.statusCode == 500) {
        return Either.error(FailedModel.fromJson(jsonDecode(res.toString())));
      }
      return Either.success(ResRegister.fromJson(res.data));
    } catch (e, st) {
      debugPrint("cekk st $e");
      debugPrint("cekk stt $st");
      log(st.toString());
      if (kDebugMode) {
        print(st);
      }
      return Either.error(FailedModel.fromJson(jsonDecode(e.toString())));
    }
  }

  Future<Either<Failure, ResLogout>> logout() async {
    if (kDebugMode) {
      print(dataGlobal.token);
    }
    Response res = await dio.post(ApiEndpoint.logout,
        options: Options(
          validateStatus: (status) {
            return status == 200 || status == 400;
          },
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
          headers: {'Authorization': dataGlobal.token},
        ));
    try {
      return Either.success(ResLogout.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  // send otp
  Future<Either<Failure, ResGetOtp>> getOtp({
    required String idUser,
  }) async {
    Response res = await dio.post(ApiEndpoint.getOtp,
        data: {
          'id_user': idUser,
        },
        options: Options(
          validateStatus: (status) {
            return status == 200 || status == 400;
          },
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ));
    try {
      return Either.success(ResGetOtp.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  // verify otp
  Future<Either<Failure, ResVerifyOtp>> verifyOtp({
    required String idUser,
    required String otpCode,
  }) async {
    Response res = await dio.post(ApiEndpoint.verifyOtp,
        data: {
          'otp': otpCode,
          'id_user': idUser,
        },
        options: Options(
          validateStatus: (status) {
            return status == 200 || status == 400;
          },
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ));
    try {
      return Either.success(ResVerifyOtp.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  //resend otp
  Future<Either<Failure, ResResendOtp>> resendOtp({
    required String idUser,
    required String channel,
  }) async {
    Response res = await dio.post(ApiEndpoint.resendOtp,
        data: {
          'id_user': idUser,
          'channel': channel,
        },
        options: Options(
          validateStatus: (status) {
            return status == 200 || status == 400;
          },
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ));
    try {
      return Either.success(ResResendOtp.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  //update password
  Future<Either<Failure, ResUpdatePassword>> updatePassword(
      {required String oldPassword,
      required String newPassword,
      required String confirmNewPassword}) async {
    try {
      Response res = await dio.post(ApiEndpoint.updatePassword,
          data: {
            'old_password': oldPassword,
            'password': newPassword,
            'password_confirmation': confirmNewPassword,
          },
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization': dataGlobal.token},
          ));

      return Either.success(ResUpdatePassword.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  // send otp forgot password
  Future<Either<Failure, ResSendOtp>> sendOtp({
    String? phoneNumber,
    required String channel,
    String? email,
  }) async {
    try {
      Response res = await dio.post(ApiEndpoint.sendOtp,
          data: {
            'phone_number': phoneNumber,
            'channel': channel,
            'email': email
          },
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
          ));
      return Either.success(ResSendOtp.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  // send otp forgot password
  Future<Either<Failure, ResResetPassword>> resetPassword({
    // required String phoneNumber,
    required int idUser,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      Response res = await dio.post(ApiEndpoint.resetPassword,
          data: {
            // 'phone_number': phoneNumber,
            'password': password,
            'password_confirmation': confirmPassword,
            'id_user': idUser
          },
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
          ));
      return Either.success(ResResetPassword.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  // Asynchronously checks the country by making a GET request to the specified API endpoint.
  // Returns an Either object containing either a success response with a ResMemberArea object if the status is 200,
  // or an error response with a Failure object if an exception occurs during the process.
  Future<Either<Failure, ResMemberArea>> checkCountry() async {
    try {
      Response res = await dio.get(ApiEndpoint.checkCountry,
          options: Options(
            validateStatus: (status) {
              return status == 200;
            },
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
          ));
      return Either.success(ResMemberArea.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }
}
