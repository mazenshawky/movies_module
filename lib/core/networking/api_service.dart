import 'package:dio/dio.dart';
import 'package:movies_module/core/networking/api_constants.dart';
import 'package:movies_module/features/movies/models/movies_response/movies_response.dart';
import 'package:movies_module/features/movies/models/trailer_response/trailer_response.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseImageUrl)
abstract class ApiService {
  factory ApiService(
    Dio dio, {
    String? baseUrl,
    ParseErrorLogger? errorLogger,
  }) = _ApiService;

  @GET(ApiConstants.popularMoviesPath)
  Future<MoviesResponse> getPopularMovies();

  @GET(ApiConstants.movieTrailers)
  Future<TrailerResponse> getTrailers({@Path("movieId") required int movieId});
}
