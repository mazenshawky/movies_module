import 'package:dio/dio.dart';
import 'package:movies_module/core/di/dependency_injection.dart';
import 'package:movies_module/core/networking/api_constants.dart';
import 'package:movies_module/core/networking/api_service.dart';
import 'package:movies_module/features/movies/repo/movies_repo.dart';
import 'package:movies_module/features/movies/ui/business_logic/get_popular_movies/get_popular_movies_cubit.dart';

class TestEnvironment {
  static Future<void> setUp() async {
    // Configure Dio for testing
    final dio = Dio(BaseOptions(
      baseUrl: ApiConstants.baseImageUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    ));
    
    // Register dependencies
    getIt.registerLazySingleton<ApiService>(() => ApiService(dio));
    getIt.registerLazySingleton<MoviesRepo>(() => MoviesRepo(apiService: getIt()));
    getIt.registerFactory<GetPopularMoviesCubit>(() => GetPopularMoviesCubit(repo: getIt()));
  }
  
  static Future<void> tearDown() async {
    await getIt.reset();
  }
}