import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:movies_module/core/models/error_model/error_model.dart';
import 'package:movies_module/features/movies/models/movie/movie.dart';

part 'get_popular_movies_state.freezed.dart';

@freezed
class GetPopularMoviesState with _$GetPopularMoviesState {
  const factory GetPopularMoviesState.initial() = _Initial;
  const factory GetPopularMoviesState.loading() = GetPopularMoviesLoading;
  const factory GetPopularMoviesState.error(ErrorModel errorModel) = GetPopularMoviesError;
  const factory GetPopularMoviesState.getPopularMoviesSuccess(List<Movie> movies) = GetPopularMoviesSuccess;
}