import 'package:coolappflutter/data/data_global.dart';
import 'package:coolappflutter/data/helpers/either.dart';
import 'package:coolappflutter/data/helpers/failure.dart';
import 'package:coolappflutter/data/models/data_checkout_transaction.dart';
import 'package:coolappflutter/data/networks/dio_handler.dart';
import 'package:coolappflutter/data/networks/endpoint/api_endpoint.dart';
import 'package:coolappflutter/data/networks/error_handler.dart';
import 'package:coolappflutter/data/response/payments/res_create_data_topup_transaction.dart';
import 'package:coolappflutter/data/response/payments/res_get_amount_deposit.dart';
import 'package:coolappflutter/data/response/payments/res_get_data_top_up.dart';
import 'package:coolappflutter/data/response/payments/res_get_invoice_brain_activation.dart';
import 'package:coolappflutter/data/response/payments/res_history_brain_activation.dart';
import 'package:coolappflutter/data/response/payments/res_history_topup.dart';
import 'package:coolappflutter/data/response/payments/res_invoice_transaction.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RepoPayment {
  Future<Either<Failure, ResGetDataTopUp>> getListTopUp() async {
    try {
      Response res = await dio.get(ApiEndpoint.listTopUp,
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            headers: {'Authorization': dataGlobal.token},
          ));
      return Either.success(ResGetDataTopUp.fromJson(res.data));
    } catch (e) {
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResCreateTopupTransaction>> createTopupTransaction(
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
      return Either.success(ResCreateTopupTransaction.fromJson(res.data));
    } catch (e) {
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResGetAmountDeposit>> getShowDeposit() async {
    try {
      Response res = await dio.get(ApiEndpoint.showAmount,
          options: Options(
            headers: {'Authorization': dataGlobal.token},
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
          ));
      return Either.success(ResGetAmountDeposit.fromJson(res.data));
    } catch (e) {
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResHistoryTopup>> getHistoryTopup() async {
    try {
      Response res = await dio.get(ApiEndpoint.historyTopup,
          options: Options(
            headers: {'Authorization': dataGlobal.token},
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
          ));

      debugPrint("cek topup $res");
      return Either.success(ResHistoryTopup.fromJson(res.data));
    } catch (e) {
      debugPrint("cek topup $e");
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResInvoiceTransaction>> getInvoice(String? id) async {
    try {
      Response res = await dio.get(ApiEndpoint.invoice(id),
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            headers: {'Authorization': dataGlobal.token},
          ));
      return Either.success(ResInvoiceTransaction.fromJson(res.data));
    } catch (e) {
      debugPrint("cek top $e");
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResHistoryBrainActivation>>
      getHistoryBrainActivation() async {
    try {
      Response res = await dio.get(ApiEndpoint.historyBrainActivation,
          options: Options(
            headers: {'Authorization': dataGlobal.token},
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
          ));
      debugPrint("cek brain $res");
      return Either.success(ResHistoryBrainActivation.fromJson(res.data));
    } catch (e) {
      debugPrint("cek brain $e");
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResGetInvoiceBrainAcitovation>> getInvoiceBrain(
      String? id) async {
    try {
      Response res = await dio.get(ApiEndpoint.historyDetailBrain(id),
          options: Options(
            headers: {'Authorization': dataGlobal.token},
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
          ));
      return Either.success(ResGetInvoiceBrainAcitovation.fromJson(res.data));
    } catch (e) {
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }
}
