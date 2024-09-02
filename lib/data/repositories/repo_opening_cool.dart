// import 'package:cool_app/data/response/res_opening_cool.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
//
// import '../helpers/either.dart';
// import '../helpers/failure.dart';
// import '../networks/dio_handler.dart';
// import '../networks/endpoint/api_endpoint.dart';
// import '../networks/error_handler.dart';
//
// class RepoOpeningCool {
//   Future<Either<Failure, ResOpeningCool>> getOpeningCool() async {
//     try {
//       Response res = await dio.get(ApiEndpoint.apiOpeningCool);
//       return Either.success(ResOpeningCool.fromJson(res.data));
//     } catch (e, st) {
//       if (kDebugMode) {
//         print(st);
//       }
//       return Either.error(ErrorHandler.handle(e).failure);
//     }
//   }
// }
