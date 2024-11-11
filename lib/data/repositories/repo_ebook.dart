import 'package:coolappflutter/data/data_global.dart';
import 'package:coolappflutter/data/locals/shared_pref.dart';
import 'package:coolappflutter/data/networks/error_handler.dart';
import 'package:coolappflutter/data/response/payments/res_history_detail_ebook.dart';
import 'package:coolappflutter/data/response/payments/res_history_ebook.dart';
import 'package:coolappflutter/data/response/res_create_log_ebook.dart';
import 'package:coolappflutter/data/response/res_detail_ebook.dart';
import 'package:coolappflutter/data/response/res_list_ebook.dart';
import 'package:coolappflutter/data/response/res_pre_home.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../helpers/either.dart';
import '../helpers/failure.dart';
import '../networks/dio_handler.dart';
import '../networks/endpoint/api_endpoint.dart';
import '../response/res_transaksi_ebook.dart';

class RepoEbook {
  Future<Either<Failure, ResListEbook>> getListEbook() async {
    String? token = await Prefs().getToken();
    Response res = await dio.get(
      ApiEndpoint.listEbookHome,
      options: Options(
          validateStatus: (status) {
            return status == 200 || status == 400;
          },
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
          headers: {"Authorization": "Bearer $token"}),
    );
    try {
      return Either.success(ResListEbook.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResListEbook>> getAllBook() async {
    String? token = await Prefs().getToken();
    Response res = await dio.get(
      ApiEndpoint.listAllEbook,
      options: Options(
          validateStatus: (status) {
            return status == 200 || status == 400;
          },
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
          headers: {"Authorization": "Bearer $token"}),
    );
    try {
      return Either.success(ResListEbook.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResDetailEbook>> getDetailEbook(int id) async {
    String? token = await Prefs().getToken();
    Response res = await dio.get(
      ApiEndpoint.detailEbook(id),
      options: Options(
          validateStatus: (status) {
            return status == 200 || status == 400;
          },
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
          headers: {"Authorization": "Bearer $token"}),
    );
    try {
      return Either.success(ResDetailEbook.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResPreHome>> getPreHome() async {
    try {
      Response res = await dio.get(
        ApiEndpoint.apiPreHome,
        options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {"Authorization": dataGlobal.token}),
      );

      return Either.success(ResPreHome.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResCreateLogEbook>> createLogEbook(int idEbook) async {
    Response res = await dio.post(ApiEndpoint.createLogEbook,
        data: {
          "id_user": "${dataGlobal.dataUser?.id}",
          "id_ebook": idEbook,
        },
        options: Options(
          validateStatus: (status) {
            return status == 200 || status == 400;
          },
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
          headers: {'Authorization': dataGlobal.token},
        ));
    try {
      return Either.success(ResCreateLogEbook.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResTransaksiEbook>> paymentEbook(
      int idEbook, String price, String transactionTpye,
      {String? gateway}) async {
    Response res = await dio.post(ApiEndpoint.paymentTransaksiEbook,
        data: {
          "id_user": "${dataGlobal.dataUser?.id}",
          "id_ebook": idEbook,
          "discount": "0",
          "transaction_type": transactionTpye,
          "id_item_payments": "2",
          "qty": 1,
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
    try {
      return Either.success(ResTransaksiEbook.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResHistoryEbook>> getHistoryPaymentEbook() async {
    try {
      Response res = await dio.get(
        ApiEndpoint.historyEbook,
        options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {"Authorization": dataGlobal.token}),
      );

      return Either.success(ResHistoryEbook.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResDetailHistoryEbook>> gerhistoryDetailEbook(
      String? id) async {
    try {
      Response res = await dio.get(ApiEndpoint.historyDetailEbook(id),
          options: Options(
            headers: {'Authorization': dataGlobal.token},
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
          ));
      return Either.success(ResDetailHistoryEbook.fromJson(res.data));
    } catch (e) {
      debugPrint("cek ebook $e");
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }
}
