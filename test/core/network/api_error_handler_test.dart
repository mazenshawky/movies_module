import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies_module/core/networking/api_error_handler.dart';
import 'package:movies_module/core/networking/network_errors.dart';

void main() {
  group('ApiErrorHandler', () {
    group('handle DioException', () {
      test('should handle connection error', () {
        // Arrange
        final dioException = DioException(
          requestOptions: RequestOptions(path: ''),
          type: DioExceptionType.connectionError,
        );

        // Act
        final result = ApiErrorHandler.handle(dioException);

        // Assert
        expect(result.message, NetworkErrors.noInternetConnection);
      });

      test('should handle connection timeout', () {
        // Arrange
        final dioException = DioException(
          requestOptions: RequestOptions(path: ''),
          type: DioExceptionType.connectionTimeout,
        );

        // Act
        final result = ApiErrorHandler.handle(dioException);

        // Assert
        expect(result.message, NetworkErrors.timeoutError);
      });

      test('should handle bad response with status code 400', () {
        // Arrange
        final response = Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 400,
          data: {'error': 'Bad request error message'},
        );
        
        final dioException = DioException(
          requestOptions: RequestOptions(path: ''),
          type: DioExceptionType.badResponse,
          response: response,
        );

        // Act
        final result = ApiErrorHandler.handle(dioException);

        // Assert
        expect(result.message, 'Bad request error message');
        expect(result.code, 400);
      });

      test('should handle bad response with status code 401', () {
        // Arrange
        final response = Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 401,
        );
        
        final dioException = DioException(
          requestOptions: RequestOptions(path: ''),
          type: DioExceptionType.badResponse,
          response: response,
        );

        // Act
        final result = ApiErrorHandler.handle(dioException);

        // Assert
        expect(result.message, NetworkErrors.invalidToken);
        expect(result.code, 401);
      });

      test('should handle bad response with status code 404', () {
        // Arrange
        final response = Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 404,
        );
        
        final dioException = DioException(
          requestOptions: RequestOptions(path: ''),
          type: DioExceptionType.badResponse,
          response: response,
        );

        // Act
        final result = ApiErrorHandler.handle(dioException);

        // Assert
        expect(result.message, NetworkErrors.notFound);
        expect(result.code, 404);
      });

      test('should handle bad response with status code 500', () {
        // Arrange
        final response = Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 500,
        );
        
        final dioException = DioException(
          requestOptions: RequestOptions(path: ''),
          type: DioExceptionType.badResponse,
          response: response,
        );

        // Act
        final result = ApiErrorHandler.handle(dioException);

        // Assert
        expect(result.message, NetworkErrors.serverError);
        expect(result.code, 500);
      });
    });

    group('handle non-Dio exceptions', () {
      test('should handle FormatException', () {
        // Arrange
        final formatException = FormatException('Invalid format');

        // Act
        final result = ApiErrorHandler.handle(formatException);

        // Assert
        expect(result.message, NetworkErrors.parsingError);
      });

      test('should handle TypeError', () {
        // Arrange
        final typeError = TypeError();

        // Act
        final result = ApiErrorHandler.handle(typeError);

        // Assert
        expect(result.message, NetworkErrors.parsingError);
      });

      test('should handle general exceptions', () {
        // Arrange
        final exception = Exception('Some error');

        // Act
        final result = ApiErrorHandler.handle(exception);

        // Assert
        expect(result.message, NetworkErrors.genericError);
      });
    });
  });
}