import 'package:cool_app/data/data_global.dart';
import 'package:cool_app/data/helpers/either.dart';
import 'package:cool_app/data/helpers/failure.dart';
import 'package:cool_app/data/networks/dio_handler.dart';
import 'package:cool_app/data/networks/endpoint/api_endpoint.dart';
import 'package:cool_app/data/networks/error_handler.dart';
import 'package:cool_app/data/response/affiliate/res_history_outcome_real_money.dart';
import 'package:cool_app/data/response/affiliate/res_history_real_money.dart';
import 'package:cool_app/data/response/affiliate/res_invoice_realmooney.dart';
import 'package:cool_app/data/response/affiliate/res_invoice_witdraw.dart';
import 'package:cool_app/data/response/transaksi/res_create_withdraw.dart';
import 'package:cool_app/data/response/transaksi/res_get_affiliate_management.dart';
import 'package:cool_app/data/response/transaksi/res_get_single_total_saldo.dart';
import 'package:cool_app/data/response/transaksi/res_history_saldo_reduction.dart';
import 'package:cool_app/data/response/transaksi/res_history_topup_affiliate.dart';
import 'package:cool_app/data/response/transaksi/res_invoice_saldo.dart';
import 'package:cool_app/data/response/transaksi/res_transaction_topup_deposit.dart';
import 'package:cool_app/data/response/transaksi/res_update_transaction_saldo_with_real_money.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class RepoTransaksiAffiliate {
  Future<Either<Failure, ResHistoryTopupAffiliate>> getHistoryTopupAffiliate(
      int page, String filter) async {
    try {
      Response res = await dio.get(ApiEndpoint.affiliateHistoryTopup,
          queryParameters: {"page": page, "filter": filter},
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization': dataGlobal.token},
          ));

      return Either.success(ResHistoryTopupAffiliate.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResTransactionTopupDeposit>> transactionTopupDeposit(
      String id, String price, String source) async {
    try {
      Response res = await dio.post(ApiEndpoint.affiliateTransaction,
          data: {"id_user": id, "price": price, "source": source},
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization': dataGlobal.token},
          ));

      return Either.success(ResTransactionTopupDeposit.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResHistorySaldoReduction>> getHistorySaldoReduction(
      int page, String filter) async {
    try {
      Response res = await dio.get(ApiEndpoint.affiliateHistoryTopup,
          queryParameters: {"reduction": "1", "page": page, "filter": filter},
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization': dataGlobal.token},
          ));

      return Either.success(ResHistorySaldoReduction.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResGetSingleTotalSaldo>> getSingleTotalSaldo(
      bool isSaldo) async {
    try {
      Response res = await dio.get(
          "${ApiEndpoint.affiliateSingleTotalSaldo}?module=${isSaldo ? "total_saldo_affiliate" : "total_real_money"}",
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization': dataGlobal.token},
          ));

      return Either.success(ResGetSingleTotalSaldo.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResInvoiceSaldo>> getInvoiceSaldo(String id) async {
    try {
      Response res = await dio.get(ApiEndpoint.affiliateInvoiceSaldo,
          queryParameters: {"id_transaction": id},
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization': dataGlobal.token},
          ));

      return Either.success(ResInvoiceSaldo.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResUpdateTransactionSaldoWithRealMoney>>
      updateTransactionSaldoWithRealMoney(String id) async {
    try {
      Response res =
          await dio.post(ApiEndpoint.updateTransactionSaldoWithRealMoney,
              queryParameters: {"id_transaction": id},
              options: Options(
                validateStatus: (status) {
                  return status == 200 || status == 400;
                },
                contentType: Headers.jsonContentType,
                responseType: ResponseType.json,
                headers: {'Authorization': dataGlobal.token},
              ));

      return Either.success(
          ResUpdateTransactionSaldoWithRealMoney.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResHistoryRealMoney>> getHistoryRealMoney(
      int page, String filter) async {
    try {
      Response res = await dio.get(ApiEndpoint.apiHistoryRealMoney,
          queryParameters: {"type": "income", "page": page, "filter": filter},
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization': dataGlobal.token},
          ));

      return Either.success(ResHistoryRealMoney.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResHistoryOutcomeRealMoney>>
      getHistoryRealMoneyWithdrawal(int page, String filter) async {
    try {
      Response res = await dio.get(ApiEndpoint.getInvoiceWithdraw,
          queryParameters: {
            "id_user": dataGlobal.dataUser?.id,
            "page": page,
            "filter": filter
          },
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization': dataGlobal.token},
          ));

      return Either.success(ResHistoryOutcomeRealMoney.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResCreateWithdraw>> createWithdraw(
    String amount,
    String beneficiaryAccount,
    String beneficiaryName,
    String beneficiaryBank,
    String beneficiaryEmail,
  ) async {
    try {
      Response res = await dio.post(ApiEndpoint.createWithdraw,
          data: {
            "amount": amount,
            "beneficiary_account": beneficiaryAccount,
            "beneficiary_name": beneficiaryName,
            "beneficiary_bank": beneficiaryBank,
            "beneficiary_email": beneficiaryEmail,
          },
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization': dataGlobal.token},
          ));

      return Either.success(ResCreateWithdraw.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResGetAffiliateManagement>>
      getAffiliateManagement() async {
    try {
      Response res = await dio.get(ApiEndpoint.affiliateManagement,
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization': dataGlobal.token},
          ));

      return Either.success(ResGetAffiliateManagement.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResInvoiceWithdrawal>> getInvoiceWithdraw(
      String idVoucher) async {
    try {
      Response res = await dio.get(ApiEndpoint.getInvoiceWithdraw,
          queryParameters: {
            "id_user": dataGlobal.dataUser?.id,
            "id": idVoucher
          },
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization': dataGlobal.token},
          ));

      return Either.success(ResInvoiceWithdrawal.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResInvoiceRealMoney>> getInvoiceRealMoney(
      String idTr) async {
    try {
      Response res = await dio.get(ApiEndpoint.apiHistoryRealMoney,
          queryParameters: {"id_user": dataGlobal.dataUser?.id, "id": idTr},
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization': dataGlobal.token},
          ));

      return Either.success(ResInvoiceRealMoney.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResCreateWithdraw>> createTransactionLastWithdraw(
    String beneficiaryAccount,
    String beneficiaryName,
    String beneficiaryBank,
    String beneficiaryEmail,
  ) async {
    try {
      Response res = await dio.post(ApiEndpoint.transactionLastWithdraw,
          data: {
            "beneficiary_account": beneficiaryAccount,
            "beneficiary_name": beneficiaryName,
            "beneficiary_bank": beneficiaryBank,
            "beneficiary_email": beneficiaryEmail,
          },
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization': dataGlobal.token},
          ));

      return Either.success(ResCreateWithdraw.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }
}
