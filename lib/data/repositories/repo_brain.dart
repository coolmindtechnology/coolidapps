import 'package:cool_app/data/models/subcribtion_brain_transaction_data_model.dart';
import 'package:cool_app/data/networks/error_handler.dart';
import 'package:cool_app/data/response/brain_activation/rec_cek_daily.dart';
import 'package:cool_app/data/response/brain_activation/res_check_allow_subcribe.dart';
import 'package:cool_app/data/response/brain_activation/res_list_brain_activation.dart';
import 'package:cool_app/data/response/brain_activation/res_list_subcription_all_item.dart';
import 'package:cool_app/data/response/brain_activation/res_list_subcription_per_item.dart';
import 'package:cool_app/data/response/brain_activation/res_show_price_subcribe_brain.dart';
import 'package:cool_app/data/response/brain_activation/res_subcribe_brain_transaction.dart';
import 'package:cool_app/data/response/payments/res_create_data_transaction.dart';
import 'package:cool_app/data/response/res_update_payment.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../data_global.dart';
import '../helpers/either.dart';
import '../helpers/failure.dart';
import '../networks/dio_handler.dart';
import '../networks/endpoint/api_endpoint.dart';
import '../response/brain_activation/res_timer_play.dart';
import '../response/brain_activation/res_transaksi_brain_activation.dart';

class RepoBrain {
  Future<Either<Failure, ResListBrainActivation>> getListBrain(
      String id) async {
    try {
      Response res = await dio.get(ApiEndpoint.listBrainActivation(id),
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization': dataGlobal.token},
          ));
      return Either.success(ResListBrainActivation.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResTransakasiBrainActivation>> paymentBrainActivation(
      int idBrain, String price, idLogProfiling,
      {String? gateway}) async {
    try {
      Response res = await dio.post(ApiEndpoint.transaksiBrainActivation,
          data: {
            "id_brain_activations": idBrain,
            "discount": "0",
            "id_log_profiling": idLogProfiling,
            "transaction_type": "Subscribes",
            "id_item_payments": "3",
            "price": price,
            "gateway": gateway
          },
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization': dataGlobal.token},
          ));
      return Either.success(ResTransakasiBrainActivation.fromJson(res.data));
    } on DioException catch (e) {
      return Either.error(ErrorHandler.handle(e).failure);
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResUpdatePayment>> updatePayment(
      String idOrder) async {
    Response res = await dio.get(ApiEndpoint.updatePayment(idOrder),
        options: Options(
          validateStatus: (status) {
            return status != 401;
          },
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
          headers: {'Authorization': dataGlobal.token},
        ));
    try {
      return Either.success(ResUpdatePayment.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResTimerPlay>> getDurationAudio(int idAudio) async {
    try {
      Response res = await dio.get(ApiEndpoint.timerPlayAudio(idAudio),
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization': dataGlobal.token},
          ));
      return Either.success(ResTimerPlay.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResCekDaily>> cekDaily(int idAudio) async {
    try {
      Response res = await dio.get(ApiEndpoint.apiCekDaily(idAudio),
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization': dataGlobal.token},
          ));
      return Either.success(ResCekDaily.fromJson(res.data));
    } on DioException catch (e) {
      return Either.error(ErrorHandler.handle(e).failure);
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResListSubcriptionPerItem>> gesListSubcriptionPerItem(
    String idLogProfiling,
  ) async {
    try {
      Response res = await dio.get(ApiEndpoint.getListSubscribePerItemV1,
          queryParameters: {"id_log_profiling": idLogProfiling},
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization': dataGlobal.token},
          ));
      return Either.success(ResListSubcriptionPerItem.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResListSubcriptionAllItem>>
      gesListSubcriptionAllItem() async {
    try {
      Response res = await dio.get(ApiEndpoint.getListSubscribeAllItem,
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization': dataGlobal.token},
          ));
      return Either.success(ResListSubcriptionAllItem.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResSubcribeBrainTransaction>>
      createTransactionSubcribeBrain(
          SubscribeBrainTransactionDataModel data) async {
    try {
      Response res =
          await dio.post(ApiEndpoint.transaksiSubscribeBrainActivation,
              data: data.toJson(),
              options: Options(
                validateStatus: (status) {
                  return status == 200 || status == 400;
                },
                contentType: Headers.jsonContentType,
                responseType: ResponseType.json,
                headers: {'Authorization': dataGlobal.token},
              ));
      return Either.success(ResSubcribeBrainTransaction.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResCheckAllowSubcribe>> checkAllowSubcribe(
      String? idLog) async {
    try {
      Response res = await dio.get(ApiEndpoint.checkAllowSubcribe(idLog),
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization': dataGlobal.token},
          ));
      return Either.success(ResCheckAllowSubcribe.fromJson(res.data));
    } on DioException catch (e) {
      return Either.error(ErrorHandler.handle(e).failure);
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResCreateDataTransaction>> subcribeBrainProfiling(
      SubscribeBrainTransactionDataModel data) async {
    try {
      Response res = await dio.post(ApiEndpoint.subcribeBrainProfiling,
          data: data.toJson(),
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization': dataGlobal.token},
          ));
      return Either.success(ResCreateDataTransaction.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResShowPriceBrainSubcribe>> getShowPrice(
    String idLogProfiling,
  ) async {
    try {
      Response res =
          await dio.get("${ApiEndpoint.getShowPrice}/$idLogProfiling",
              options: Options(
                validateStatus: (status) {
                  return status == 200 || status == 400;
                },
                contentType: Headers.jsonContentType,
                responseType: ResponseType.json,
                headers: {'Authorization': dataGlobal.token},
              ));
      return Either.success(ResShowPriceBrainSubcribe.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }
}
