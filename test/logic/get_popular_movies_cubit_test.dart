import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies_module/core/utils/api_result/api_result.dart';
import 'package:movies_module/features/movies/models/movie/movie.dart';
import 'package:movies_module/features/movies/ui/business_logic/get_popular_movies/get_popular_movies_cubit.dart';
import 'package:movies_module/features/movies/ui/business_logic/get_popular_movies/get_popular_movies_state.dart';

import '../helpers/test_helper.mocks.dart';
import '../helpers/test_helper.dart';

void main() {
  late GetPopularMoviesCubit cubit;
  late MockMoviesRepo mockRepo;

  provideDummy<ApiResult<List<Movie>>>(Success<List<Movie>>([]));

  setUp(() {
    mockRepo = MockMoviesRepo();
    cubit = GetPopularMoviesCubit(repo: mockRepo);
  });

  tearDown(() {
    cubit.close();
  });

  group('GetPopularMoviesCubit', () {
    test('initial state should be GetPopularMoviesState.initial()', () {
      expect(cubit.state, const GetPopularMoviesState.initial());
    });

    blocTest<GetPopularMoviesCubit, GetPopularMoviesState>(
      'emits [loading, success] when getPopularMovies succeeds',
      build: () {
        final movies = TestDataFactory.moviesList
            .map((json) => Movie.fromJson(json))
            .toList();
        when(mockRepo.getPopularMovies())
            .thenAnswer((_) async => Success<List<Movie>>(movies)); // Added <List<Movie>>
        return cubit;
      },
      act: (cubit) => cubit.getPopularMovies(),
      expect: () => [
        const GetPopularMoviesState.loading(),
        GetPopularMoviesState.getPopularMoviesSuccess( // Changed from getPopularMoviesSuccess to getMoviesSuccess
          TestDataFactory.moviesList
              .map((json) => Movie.fromJson(json))
              .toList(),
        ),
      ],
      verify: (_) {
        verify(mockRepo.getPopularMovies()).called(1);
      },
    );

    blocTest<GetPopularMoviesCubit, GetPopularMoviesState>(
      'emits [loading, error] when getPopularMovies fails',
      build: () {
        when(mockRepo.getPopularMovies())
            .thenAnswer((_) async => Failure<List<Movie>>(TestDataFactory.errorModel)); // Added <List<Movie>>
        return cubit;
      },
      act: (cubit) => cubit.getPopularMovies(),
      expect: () => [
        const GetPopularMoviesState.loading(),
        GetPopularMoviesState.error(TestDataFactory.errorModel),
      ],
      verify: (_) {
        verify(mockRepo.getPopularMovies()).called(1);
      },
    );

    blocTest<GetPopularMoviesCubit, GetPopularMoviesState>(
      'handles empty movie list correctly',
      build: () {
        when(mockRepo.getPopularMovies())
            .thenAnswer((_) async => Success<List<Movie>>([])); // Added <List<Movie>>
        return cubit;
      },
      act: (cubit) => cubit.getPopularMovies(),
      expect: () => [
        const GetPopularMoviesState.loading(),
        GetPopularMoviesState.getPopularMoviesSuccess([]), // Changed from getPopularMoviesSuccess to getMoviesSuccess
      ],
    );
  });
}