import 'package:coolappflutter/data/helpers/check_language.dart';
import 'package:coolappflutter/data/locals/preference_handler.dart';
import 'package:coolappflutter/data/models/data_checkout_transaction.dart';
import 'package:coolappflutter/data/networks/error_handler.dart';
import 'package:coolappflutter/data/response/payments/res_transcation_profiling.dart';
import 'package:coolappflutter/data/response/profiling/res_add_profiling.dart';
import 'package:coolappflutter/data/response/profiling/res_check_maximum_profiling.dart';
import 'package:coolappflutter/data/response/profiling/res_create_multiple_profiling.dart';
import 'package:coolappflutter/data/response/profiling/res_detail_profiling.dart';
import 'package:coolappflutter/data/response/profiling/res_get_price.dart';
import 'package:coolappflutter/data/response/profiling/res_get_user_profiling.dart';
import 'package:coolappflutter/data/response/profiling/res_list_multiple_profiling.dart';
import 'package:coolappflutter/data/response/profiling/res_list_profiling.dart';
import 'package:coolappflutter/data/response/profiling/res_list_profiling_false.dart';
import 'package:coolappflutter/data/response/profiling/res_pay_profiling.dart';
import 'package:coolappflutter/data/response/profiling/res_permit_profiling.dart';
import 'package:coolappflutter/data/response/profiling/res_share_result_detail.dart';
import 'package:coolappflutter/data/response/profiling/res_show_detail.dart';
import 'package:coolappflutter/data/response/profiling/res_update_transaction_profiling.dart';
import 'package:coolappflutter/data/response/profiling/res_upgrade_member.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../data_global.dart';
import '../helpers/either.dart';
import '../helpers/failure.dart';
import '../networks/dio_handler.dart';
import '../networks/endpoint/api_endpoint.dart';

class RepoProfiling {
  Future<Either<Failure, ResListProfiling>> getProfiling() async {
    Response res = await dio.get("${ApiEndpoint.listProfiling}?is_home=true",
        options: Options(
          validateStatus: (status) {
            return status == 200 || status == 400;
          },
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
          headers: {'Authorization': dataGlobal.token},
        ));
    try {
      return Either.success(ResListProfiling.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ProfilingResponseFalse>> getFalseProfiling() async {
      Response res = await dio.get("${ApiEndpoint.listProfiling}?is_home=false",
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization': dataGlobal.token},
          ));
      try {
        return Either.success(ProfilingResponseFalse.fromJson(res.data));
      } catch (e, st) {
        if (kDebugMode) {
          print(st);
        }
        return Either.error(ErrorHandler.handle(e).failure);
      }
    }

  Future<Either<Failure, ResShowDetail>> getShowProfiling(String id) async {
    try {
      Response res = await dio.get(ApiEndpoint.showProfiling(id),
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization': dataGlobal.token},
          ));
      return Either.success(ResShowDetail.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResDetailProfiling>> getDetailProfiling(
      String id, String typemenu) async {
    String isEnglish = await LocaleChecker().cekLocale();
    String? isLanguage = await PreferenceHandler.retrieveId();
    String cekLanguage = isLanguage ?? "is_english";
    String menu = typemenu;
    try {
      Response res = await dio.get(ApiEndpoint.detailProfiling(id,menu),
          queryParameters: {cekLanguage: isEnglish},
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization': dataGlobal.token},
          ));
      return Either.success(ResDetailProfiling.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResAddProfiling>> addProfiling(
      String birthDate,
      String monthDate,
      String yearDate,
      String bloodDtype,
      String name,
      String domicile) async {
    try {
      Response res = await dio.post(ApiEndpoint.addProfiling,
          data: {
            "birth_date": birthDate,
            "month_date": monthDate,
            "year_date": yearDate,
            "blood_type": bloodDtype,
            "name": name,
            "domicile": domicile,
          },
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization': dataGlobal.token},
          ));
      return Either.success(ResAddProfiling.fromJson(res.data));
    } catch (e, st) {
      debugPrint("eeeee $e");
      debugPrint("eeeee $st");
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, dynamic>> getSertifikat(int id) async {
    Response res = await dio.get(ApiEndpoint.sertifikatProfiling(id),
        options: Options(
          validateStatus: (status) {
            return status == 200 || status == 400;
          },
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
          headers: {'Authorization': dataGlobal.token},
        ));
    try {
      return Either.success(res.data);
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResListProfiling>> getHistoryProfiling() async {
    Response res = await dio.get(ApiEndpoint.historyProfiling,
        options: Options(
          validateStatus: (status) {
            return status == 200 || status == 400;
          },
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
          headers: {'Authorization': dataGlobal.token},
        ));
    try {
      return Either.success(ResListProfiling.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResPayProfiling>> payProfiling(
      List<int> idLog, String discount, String transactionType, int qty,
      {String? gateway}) async {
    Map<String, dynamic> map = {};
    // for (int i = 0; i < idLog.length; i++) {
    // }
    map["id_logs"] = idLog;
    map["discount"] = discount;
    map["transaction_type"] = transactionType;
    map["id_item_payments"] = "1";
    map["qty"] = qty;
    map["gateway"] = gateway;

    Response res = await dio.post(ApiEndpoint.payProfiling,
        data: map,
        options: Options(
          validateStatus: (status) {
            return status == 200 || status == 400;
          },
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
          headers: {'Authorization': dataGlobal.token},
        ));
    try {
      return Either.success(ResPayProfiling.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResShareResultDetail>> shareResultDetail(
      String? shareCode) async {
    try {
      Response res = await dio.post(ApiEndpoint.shareResultDetail,
          data: {"share_code": shareCode},
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization': dataGlobal.token},
          ));
      return Either.success(ResShareResultDetail.fromJson(res.data));
    } catch (e) {
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResShareResultDetail>> shareCertificate(
      String? shareCode) async {
    try {
      Response res = await dio.post(ApiEndpoint.shareCertificate,
          data: {"share_code": shareCode},
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization': dataGlobal.token},
          ));
      return Either.success(ResShareResultDetail.fromJson(res.data));
    } catch (e) {
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResGetUserProfiling>> getUserProfiling() async {
    try {
      Response res = await dio.get(ApiEndpoint.getUserProfiling,
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization': dataGlobal.token},
          ));
      return Either.success(ResGetUserProfiling.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResTransactionProfiling>> createTransactionProfiling(
      DataCheckoutTransaction dataCheckoutTransaction) async {
    try {
      Response res = await dio.post(ApiEndpoint.transactionProfiling,
          data: dataCheckoutTransaction.toJson(),
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization': dataGlobal.token},
          ));
      debugPrint(" cek sini2 $res");
      return Either.success(ResTransactionProfiling.fromJson(res.data));
    } catch (e, st) {
      debugPrint(" cek sini $e");
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResPermiteProfiling>>
      cekAvailableLocationProfiling() async {
    try {
      Response res = await dio.get(ApiEndpoint.cekAvailableProfiling,
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization': dataGlobal.token},
          ));
      return Either.success(ResPermiteProfiling.fromJson(res.data));
    } on DioException catch (e) {
      return Either.error(ErrorHandler.handle(e).failure);
    } catch (e, st) {
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResCreateMultipleProfiling>> createMultipleProfiling(
      List<Map<String, dynamic>> formData) async {
    try {
      Response res = await dio.post(ApiEndpoint.createMultipleProfiling,
          data: formData,
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization': dataGlobal.token},
          ));
      return Either.success(ResCreateMultipleProfiling.fromJson(res.data));
    } catch (e) {
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResListMultipleProfiling>>
      getListMultipleProfiling() async {
    Response res = await dio.get(ApiEndpoint.listMultipleProfiling,
        options: Options(
          validateStatus: (status) {
            return status == 200 || status == 400;
          },
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
          headers: {'Authorization': dataGlobal.token},
        ));
    try {
      return Either.success(ResListMultipleProfiling.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResPayProfiling>> payMultipleProfiling(
      DataCheckoutTransaction dataCheckoutTransaction) async {
    try {
      Response res = await dio.post(ApiEndpoint.payProfiling,
          data: dataCheckoutTransaction.toJson(),
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization': dataGlobal.token},
          ));
      return Either.success(ResPayProfiling.fromJson(res.data));
    } catch (e) {
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResCheckMaximumCreateProfiling>>
      checkMaximumProfiling() async {
    Response res = await dio.get(ApiEndpoint.checkMaximumProfiling,
        options: Options(
          validateStatus: (status) {
            return status == 200 || status == 400;
          },
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
          headers: {'Authorization': dataGlobal.token},
        ));
    try {
      return Either.success(ResCheckMaximumCreateProfiling.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResUpdateTransactionProfiling>>
      updateTransactionProfiling(String id) async {
    try {
      Response res = await dio.post(ApiEndpoint.updateTransactionProfiling,
          data: {"id_deposit": id},
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization': dataGlobal.token},
          ));
      return Either.success(ResUpdateTransactionProfiling.fromJson(res.data));
    } catch (e) {
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResUpgradeMember>> upgradeToMember(
      String codeReferral) async {
    try {
      Response res = await dio.post(ApiEndpoint.upgradeToMember,
          data: {"code_referal": codeReferral},
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization': dataGlobal.token},
          ));
      return Either.success(ResUpgradeMember.fromJson(res.data));
    } catch (e) {
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResPriceProfiling>> getPriceProfiling(String qty) async {
    Response res = await dio.get(ApiEndpoint.getPriceProfiling+"?qty=$qty",
        options: Options(
          validateStatus: (status) {
            return status == 200 || status == 400;
          },
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
          headers: {'Authorization': dataGlobal.token},
        ));
    try {
      return Either.success(ResPriceProfiling.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }
}
