import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movies_module/core/networking/api_service.dart';
import 'package:movies_module/core/networking/dio_factory.dart';
import 'package:movies_module/features/movies/repo/movies_repo.dart';
import 'package:movies_module/features/movies/ui/business_logic/get_a_trailer_youtube_key/get_a_trailer_youtube_key_cubit.dart';
import 'package:movies_module/features/movies/ui/business_logic/get_popular_movies/get_popular_movies_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  Dio dio = DioFactory.getDio();
  getIt.registerLazySingleton(() => dio);

  getIt.registerLazySingleton<ApiService>(() => ApiService(dio));

  getIt.registerFactory<MoviesRepo>(() => MoviesRepo(apiService: getIt()));
  getIt.registerFactory<GetPopularMoviesCubit>(
    () => GetPopularMoviesCubit(repo: getIt()),
  );
  getIt.registerFactory<GetATrailerYoutubeKeyCubit>(
    () => GetATrailerYoutubeKeyCubit(repo: getIt()),
  );
}
