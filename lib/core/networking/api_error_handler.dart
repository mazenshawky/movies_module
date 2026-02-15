import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:movies_module/core/models/error_model/error_model.dart';
import 'package:movies_module/core/networking/network_errors.dart';
import 'package:movies_module/core/utils/strings/map_keys.dart';

class ApiErrorHandler {
  const ApiErrorHandler._();

  static ErrorModel handle(
    dynamic error, {
    bool isMrc = false,
    bool isSendOtp = false,
  }) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionError:
          return const ErrorModel(message: NetworkErrors.noInternetConnection);
        case DioExceptionType.cancel:
          return const ErrorModel(message: NetworkErrors.requestCancel);
        case DioExceptionType.connectionTimeout:
          return const ErrorModel(message: NetworkErrors.timeoutError);
        case DioExceptionType.unknown:
          return const ErrorModel(message: NetworkErrors.unknown);
        case DioExceptionType.receiveTimeout:
          return const ErrorModel(message: NetworkErrors.receiveTimeout);
        case DioExceptionType.badResponse:
          int? statusCode = error.response?.statusCode;
          if (statusCode == 400 || statusCode == 409) {
            final responseData = error.response?.data;
            if (responseData is String && isSendOtp) {
              try {
                final Map<String, dynamic> data = jsonDecode(responseData);
                return _handleBadRequestErrors(data, statusCode);
              } catch (_) {
                return const ErrorModel(message: NetworkErrors.genericError);
              }
            } else {
              return _handleBadRequestErrors(responseData, statusCode);
            }
          }
          return _handleStatusCode(statusCode);
        case DioExceptionType.sendTimeout:
          return const ErrorModel(message: NetworkErrors.sendTimeout);
        case DioExceptionType.badCertificate:
          return const ErrorModel(message: NetworkErrors.badCertificate);
      }
    }
    if (error is FormatException || error is TypeError) {
      return const ErrorModel(message: NetworkErrors.parsingError);
    }
    return const ErrorModel(message: NetworkErrors.genericError);
  }

  static ErrorModel _handleStatusCode(int? statusCode) {
    switch (statusCode) {
      case 204:
        return const ErrorModel(message: NetworkErrors.noContent, code: 204);
      case 401:
        return const ErrorModel(message: NetworkErrors.invalidToken, code: 401);
      case 404:
        return const ErrorModel(message: NetworkErrors.notFound, code: 404);
      case 500:
        return const ErrorModel(message: NetworkErrors.serverError, code: 500);
      default:
        return const ErrorModel(message: NetworkErrors.badResponse);
    }
  }

  static ErrorModel _handleBadRequestErrors(dynamic data, int? statusCode) {
    if (data is! Map<String, dynamic>) {
      return const ErrorModel(message: NetworkErrors.genericError);
    }
    final dynamic errorValue = data[MapKeys.error];

    if (errorValue is String && errorValue.trim().isNotEmpty) {
      return ErrorModel(message: errorValue, code: statusCode);
    }

    return const ErrorModel(message: NetworkErrors.genericError);
  }
}
