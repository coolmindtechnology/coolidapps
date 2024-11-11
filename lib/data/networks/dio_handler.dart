// import 'package:dio/dio.dart';

// import 'package:pretty_dio_logger/pretty_dio_logger.dart';

// class DioHandler {
//   Dio dio = Dio(
//     BaseOptions(
//       responseType: ResponseType.json,
//     ),
//   )..interceptors.add(
//       PrettyDioLogger(
//         requestHeader: true,
//         requestBody: true,
//         responseBody: true,
//         responseHeader: false,
//         error: true,
//         compact: true,
//         maxWidth: 90,
//       ),
//     );

//   // Force HTTP/1.1 by not using Http2Adapter
// }

// Dio dio = DioHandler().dio;

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:flutter/foundation.dart'
    show kIsWeb; // Needed for platform check
import 'dart:io';

class DioHandler {
  Dio dio = Dio(
    BaseOptions(
      responseType: ResponseType.json,
    ),
  )..interceptors.add(PrettyDioLogger(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseBody: true,
    ));

  DioHandler() {
    if (!kIsWeb) {
      // Non-web platforms (Android/iOS)
      (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;

        // Force HTTP/1.1 by disabling HTTP/2
        client.connectionTimeout = const Duration(seconds: 15);
        return client;
      };
    }
    // No need to set the adapter for web, Dio will handle it automatically.
  }
}

Dio dio = DioHandler().dio;
