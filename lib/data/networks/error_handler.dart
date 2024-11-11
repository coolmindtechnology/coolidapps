import 'package:coolappflutter/data/helpers/failure.dart';
import 'package:coolappflutter/data/locals/shared_pref.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/auth/login_screen.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:dio/dio.dart';

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      // Handle Dio error, can be API response error or Dio itself error
      failure = _handleDioError(error);
    } else {
      // Handle other types of error
      failure = Failure(S.current.unknown_error);
    }
  }

  Failure _handleDioError(DioException error) {
    if (error.response?.statusCode == 401) {
      Prefs().clearSession();
      Nav.toAll(const LoginScreen());
    }

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return Failure(S.current.connection_lost);

      case DioExceptionType.sendTimeout:
        return Failure(S.current.request_timeout);

      case DioExceptionType.receiveTimeout:
        return Failure(S.current.response_timeout);

      case DioExceptionType.badResponse:
        return _handleBadResponse(error);

      case DioExceptionType.cancel:
        return Failure(S.current.request_cancelled);

      case DioExceptionType.unknown:
        return Failure(S.current.unknown_error_occurred);

      case DioExceptionType.badCertificate:
        return Failure(S.current.ssl_certificate_error);

      case DioExceptionType.connectionError:
        return Failure(S.current.connection_error);

      default:
        return Failure(S.current.unexpected_error);
    }
  }

  Failure _handleBadResponse(DioException error) {
    switch (error.response!.statusCode) {
      case 400:
        return Failure(S.current.invalid_request);

      case 401:
        Prefs().clearSession();
        Nav.toAll(const LoginScreen());
        return Failure(S.current.unauthorized);

      case 403:
        return Failure(
            error.response?.data["message"] ?? S.current.access_denied);

      case 404:
        return Failure(S.current.not_found);

      case 429:
        return Failure(S.current.too_many_requests);

      case 500:
        return Failure(S.current.internal_server_error);

      default:
        return Failure(S.current.unknown_error_occurred);
    }
  }
}
