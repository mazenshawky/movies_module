import 'package:dio/dio.dart';

class MockHttpClient {
  static Dio createMockDio() {
    final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
    ));
    
    // Add mock interceptor
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Return mock responses based on the endpoint
        if (options.path.contains('popular')) {
          return handler.resolve(
            Response(
              requestOptions: options,
              data: {
                'page': 1,
                'results': [
                  {
                    'id': 640146,
                    'title': 'Ant-Man and the Wasp: Quantumania',
                    'original_title': 'Ant-Man and the Wasp: Quantumania',
                    'overview': 'Super-Hero partners Scott Lang and Hope van Dyne explore the Quantum Realm.',
                    'popularity': 8567.865,
                    'poster_path': '/ngl2FKBlU4fhbdsrtdom9LVLBXw.jpg',
                    'backdrop_path': '/gMJngTNfaqCSCqGD4y8lVMZXKDn.jpg',
                    'release_date': '2023-02-15',
                    'video': false,
                    'vote_average': 6.5,
                    'vote_count': 1886,
                  },
                  {
                    'id': 502356,
                    'title': 'The Super Mario Bros. Movie',
                    'original_title': 'The Super Mario Bros. Movie',
                    'overview': 'Brooklyn plumbers Mario and Luigi embark on an epic quest.',
                    'popularity': 6572.614,
                    'poster_path': '/qNBAXBIQlnOThrVvA6mA2B5ggV6.jpg',
                    'backdrop_path': '/iJQIbOPm81fPEGKt5BPuZmfnA54.jpg',
                    'release_date': '2023-04-05',
                    'video': false,
                    'vote_average': 7.5,
                    'vote_count': 1456,
                  },
                ],
                'total_pages': 38029,
                'total_results': 760569,
              },
              statusCode: 200,
            ),
          );
        }
        
        // Return error for unknown endpoints
        return handler.reject(
          DioException(
            requestOptions: options,
            response: Response(
              requestOptions: options,
              data: {'error': 'Not found'},
              statusCode: 404,
            ),
            type: DioExceptionType.badResponse,
          ),
        );
      },
    ));
    
    return dio;
  }

  static Dio createFailingDio() {
    final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
    ));
    
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        return handler.reject(
          DioException(
            requestOptions: options,
            type: DioExceptionType.connectionError,
            message: 'No internet connection',
          ),
        );
      },
    ));
    
    return dio;
  }
}