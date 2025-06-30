import 'package:coolappflutter/data/response/affiliate/res_bank_account.dart';
import 'package:coolappflutter/data/response/affiliate/res_check_topup_affiliate.dart';
import 'package:coolappflutter/data/response/affiliate/res_detail_activity.dart';
import 'package:coolappflutter/data/response/affiliate/res_detail_member.dart';
import 'package:coolappflutter/data/response/affiliate/res_list_activity.dart';
import 'package:coolappflutter/data/response/affiliate/res_list_bank.dart';
import 'package:coolappflutter/data/response/affiliate/res_list_member.dart';
import 'package:coolappflutter/data/response/affiliate/res_overview.dart';
import 'package:coolappflutter/data/response/affiliate/res_save_rekening.dart';
import 'package:coolappflutter/data/response/user/res_check_profile.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../data_global.dart';
import '../helpers/either.dart';
import '../helpers/failure.dart';
import '../networks/dio_handler.dart';
import '../networks/endpoint/api_endpoint.dart';
import '../networks/error_handler.dart';
import '../response/affiliate/res_home_affiliate.dart';

class RepoAffiliate {
  Future<Either<Failure, ResAffiliate>> getHomeAffiliate() async {
    try {
      Response res =
          await dio.get(ApiEndpoint.homeAffiliate(dataGlobal.dataUser?.id),
              // ApiEndpoint.homeAffiliate(843),
              options: Options(
                validateStatus: (status) {
                  return status == 200 || status == 400;
                },
                contentType: Headers.jsonContentType,
                responseType: ResponseType.json,
                headers: {'Authorization': dataGlobal.token},
              ));

      return Either.success(ResAffiliate.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResOverView>> getOverViewAffiliate() async {
    try {
      Response res =
          await dio.get(ApiEndpoint.homeAffiliate(dataGlobal.dataUser?.id),
              // ApiEndpoint.homeAffiliate(843),
              options: Options(
                validateStatus: (status) {
                  return status == 200 || status == 400;
                },
                contentType: Headers.jsonContentType,
                responseType: ResponseType.json,
                headers: {'Authorization': dataGlobal.token},
              ));

      return Either.success(ResOverView.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResSaveRekening>> saveRekening(
      String bankName, String bankNumber, String accountName) async {
    try {
      Response res = await dio.post(ApiEndpoint.apiSaveRek,
          data: {
            "id_user": dataGlobal.dataUser?.id.toString(),
            "bank_name": bankName,
            "bank_number": bankNumber,
            "bank_account_name": accountName
          },
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization': dataGlobal.token},
          ));

      return Either.success(ResSaveRekening.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResListBank>> getListBank() async {
    try {
      Response res = await dio.get(ApiEndpoint.apiListRek,
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization': dataGlobal.token},
          ));

      return Either.success(ResListBank.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResListMember>> getListMember() async {
    try {
      Response res = await dio.get('${ApiEndpoint.apiListMember}?s_all=true',
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization': dataGlobal.token},
          ));

      return Either.success(ResListMember.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResBankAccount>> getBankAccount(
      String bankCode, String accountNumber) async {
    try {
      Response res = await dio.get(ApiEndpoint.apiGetBankAccount,
          queryParameters: {"bank": bankCode, "account_no": accountNumber},
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization': dataGlobal.token},
          ));

      return Either.success(ResBankAccount.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResDetailMember>> getDetailMemberAffiliate(
      String idMember) async {
    try {
      Response res = await dio.get(ApiEndpoint.apiDetailMember(idMember),
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization': dataGlobal.token},
          ));

      return Either.success(ResDetailMember.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResListActivity>> getListActivity() async {
    try {
      Response res = await dio.get("${ApiEndpoint.apiListMember}?is_new=true",
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization': dataGlobal.token},
          ));

      return Either.success(ResListActivity.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResDetailActivity>> getDetailActivityAffiliate(
      String idActivity) async {
    try {
      Response res = await dio.get(ApiEndpoint.apiDetailActivity(idActivity),
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization': dataGlobal.token},
          ));

      return Either.success(ResDetailActivity.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResCheckTopupAffiliate>> checkTopupAffiliate(
      String idMember) async {
    debugPrint("gg ${ApiEndpoint.checkTopupAffiliate}/$idMember");
    try {
      Response res =
          await dio.get("${ApiEndpoint.checkTopupAffiliate}/$idMember",
              options: Options(
                validateStatus: (status) {
                  return status == 200 || status == 400;
                },
                contentType: Headers.jsonContentType,
                responseType: ResponseType.json,
                headers: {'Authorization': dataGlobal.token},
              ));
      debugPrint("${ApiEndpoint.checkTopupAffiliate}/$idMember");
      debugPrint("data cek topup $res");

      return Either.success(ResCheckTopupAffiliate.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResCheckTopupAffiliate>> updateNotifTopupAffiliate(
      String idMember) async {
    try {
      Response res = await dio.get("${ApiEndpoint.updateTopupNotif}/$idMember",
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization': dataGlobal.token},
          ));

      return Either.success(ResCheckTopupAffiliate.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResCheckProfile>> checkCompleteBank() async {
    try {
      Response res = await dio.get(ApiEndpoint.checkCompleteBank,
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 403;
            },
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization': dataGlobal.token},
          ));

      return Either.success(ResCheckProfile.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }
}
