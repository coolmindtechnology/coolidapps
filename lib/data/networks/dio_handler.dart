import 'package:dio/dio.dart';
import 'package:dio_http2_adapter/dio_http2_adapter.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioHandler {
  Dio dio = Dio(
    BaseOptions(
      // contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
      // validateStatus: (status) {
      //   return status != 401;
      // },
      // headers: {'connection': 'close'},
      // connectTimeout: Duration(seconds: 15),
      // receiveTimeout: Duration(seconds: 15),
      // sendTimeout: Duration(seconds: 15),
    ),
  )
    ..interceptors.add(PrettyDioLogger(
      request: true,
      requestHeader: true,
      requestBody: true,
      // responseHeader: true,
      responseBody: true,
    ))
    ..httpClientAdapter = Http2Adapter(
      ConnectionManager(idleTimeout: Duration(seconds: 15)),
    );
}

Dio dio = DioHandler().dio;
