import 'package:movies_module/core/networking/api_error_handler.dart';
import 'package:movies_module/core/networking/api_service.dart';
import 'package:movies_module/core/utils/api_result/api_result.dart';
import 'package:movies_module/features/movies/models/movie/movie.dart';
import 'package:movies_module/features/movies/models/movie_trailer/movie_trailer.dart';
import 'package:movies_module/features/movies/models/movies_response/movies_response.dart';
import 'package:movies_module/features/movies/models/trailer_response/trailer_response.dart';

class MoviesRepo {
  final ApiService _apiService;

  MoviesRepo({required ApiService apiService}) : _apiService = apiService;

  Future<ApiResult<List<Movie>>> getPopularMovies() async {
    try {
      final MoviesResponse response = await _apiService.getPopularMovies();
      return ApiResult<List<Movie>>.success(response.movies);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<String>> getATrailerYoutubeKey({
    required int movieId,
  }) async {
    try {
      final TrailerResponse response = await _apiService.getTrailers(
        movieId: movieId,
      );
      final MovieTrailer? youtubeTrailer = response.trailers
          .where((trailer) => trailer.site == "YouTube")
          .cast<MovieTrailer?>()
          .firstWhere((trailer) => trailer != null, orElse: () => null);

      if (youtubeTrailer == null) {
        return ApiResult.failure(
          ApiErrorHandler.handle("No YouTube trailer found"),
        );
      }

      return ApiResult.success(youtubeTrailer.key);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
