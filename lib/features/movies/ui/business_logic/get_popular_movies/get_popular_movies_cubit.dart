import 'package:bloc/bloc.dart';
import 'package:movies_module/core/utils/api_result/api_result.dart';
import 'package:movies_module/features/movies/models/movie/movie.dart';
import 'package:movies_module/features/movies/repo/movies_repo.dart';
import 'package:movies_module/features/movies/ui/business_logic/get_popular_movies/get_popular_movies_state.dart';

class GetPopularMoviesCubit extends Cubit<GetPopularMoviesState> {
  GetPopularMoviesCubit({required MoviesRepo repo})
    : _repo = repo,
      super(const GetPopularMoviesState.initial());

  final MoviesRepo _repo;

  Future<void> getPopularMovies() async {
    emit(const GetPopularMoviesState.loading());
    ApiResult<List<Movie>> response = await _repo.getPopularMovies();
    switch (response) {
      case Success<List<Movie>>(:final data):
        emit(GetPopularMoviesState.getPopularMoviesSuccess(data));
      case Failure(:final errorModel):
        emit(GetPopularMoviesState.error(errorModel));
    }
  }
}
