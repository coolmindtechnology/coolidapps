import 'package:coolappflutter/data/data_global.dart';
import 'package:coolappflutter/data/helpers/either.dart';
import 'package:coolappflutter/data/networks/dio_handler.dart';
import 'package:coolappflutter/data/networks/error_handler.dart';
import 'package:coolappflutter/data/response/consultation/res_list_consultation.dart';
import 'package:coolappflutter/data/response/meet/res_GetDetailMeet.dart';
import 'package:coolappflutter/data/response/meet/res_GetHistoryMeet.dart';
import 'package:coolappflutter/data/response/meet/res_GetListMeet.dart';
import 'package:coolappflutter/data/response/promotion/res_getlist_promotion.dart';
import 'package:coolappflutter/data/response/promotion/res_post_withdrawl_commision.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../helpers/failure.dart';
import '../networks/endpoint/api_endpoint.dart';

class RepoPromotion {

  Future<Either<Failure, ResListPromotion>> getlistMeet(
      {String? token}) async {
    try {
      Response res = await dio.get(ApiEndpoint.getoverviewpromotion,
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            headers: {'Authorization': dataGlobal.token},
          ));

      return Either.success(ResListPromotion.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResPostWithDrawlCommision>> postWithdrawl({
    required String email,
    required String amount,
  }) async {
    try {
      Response res = await dio.post(
        ApiEndpoint.WdPromotion, // Endpoint untuk withdrawal
        data: {
          "email": email,
          "amount": amount,
        },
        options: Options(
          validateStatus: (status) => status == 200 || status == 400,
          headers: {'Authorization': dataGlobal.token},
        ),
      );

      return Either.success(ResPostWithDrawlCommision.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print('Error in postWithdrawl: $e');
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

}
