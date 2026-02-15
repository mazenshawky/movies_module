import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:movies_module/core/models/error_model/error_model.dart';
import 'package:movies_module/core/networking/api_service.dart';
import 'package:movies_module/features/movies/models/movie/movie.dart';
import 'package:movies_module/features/movies/models/movies_response/movies_response.dart';
import 'package:movies_module/features/movies/repo/movies_repo.dart';
import 'package:movies_module/features/movies/ui/business_logic/get_a_trailer_youtube_key/get_a_trailer_youtube_key_cubit.dart';
import 'package:movies_module/features/movies/ui/business_logic/get_popular_movies/get_popular_movies_cubit.dart';

@GenerateNiceMocks([
  MockSpec<ApiService>(),
  MockSpec<MoviesRepo>(),
  MockSpec<GetPopularMoviesCubit>(),
  MockSpec<GetATrailerYoutubeKeyCubit>(),
  MockSpec<Dio>(),
  MockSpec<DioException>(as: #MockDioException),
])
void main() {}

// Test data factory
class TestDataFactory {
  static Map<String, dynamic> get movieJson => {
        'id': 640146,
        'title': 'Ant-Man and the Wasp: Quantumania',
        'original_title': 'Ant-Man and the Wasp: Quantumania',
        'overview': 'Super-Hero partners Scott Lang and Hope van Dyne, along with with Hope\'s parents Janet van Dyne and Hank Pym, and Scott\'s daughter Cassie Lang, find themselves exploring the Quantum Realm, interacting with strange new creatures and embarking on an adventure that will push them beyond the limits of what they thought possible.',
        'popularity': 8567.865,
        'poster_path': '/ngl2FKBlU4fhbdsrtdom9LVLBXw.jpg',
        'backdrop_path': '/gMJngTNfaqCSCqGD4y8lVMZXKDn.jpg',
        'release_date': '2023-02-15',
        'video': false,
        'vote_average': 6.5,
        'vote_count': 1886,
      };

  static Map<String, dynamic> get secondMovieJson => {
        'id': 502356,
        'title': 'The Super Mario Bros. Movie',
        'original_title': 'The Super Mario Bros. Movie',
        'overview': 'While working underground to fix a water main, Brooklyn plumbers—and brothers—Mario and Luigi are transported down a mysterious pipe and wander into a magical new world. But when the brothers are separated, Mario embarks on an epic quest to find Luigi.',
        'popularity': 6572.614,
        'poster_path': '/qNBAXBIQlnOThrVvA6mA2B5ggV6.jpg',
        'backdrop_path': '/iJQIbOPm81fPEGKt5BPuZmfnA54.jpg',
        'release_date': '2023-04-05',
        'video': false,
        'vote_average': 7.5,
        'vote_count': 1456,
      };

  static List<Map<String, dynamic>> get moviesList => [
        movieJson,
        secondMovieJson,
      ];

   static MoviesResponse get moviesResponse => MoviesResponse(
        movies: moviesList.map((json) => Movie.fromJson(json)).toList(),
      );

  static ErrorModel get errorModel => const ErrorModel(
        message: 'Test error message',
        code: 400,
      );
}

// Extension methods for easier mocking
extension MovieExtensions on Movie {
  Movie copyWith({
    int? id,
    String? title,
    String? originalTitle,
    String? overview,
    double? popularity,
    String? posterPath,
    String? backdropPath,
    String? releaseDate,
    bool? video,
    double? voteAverage,
    int? voteCount,
  }) {
    return Movie(
      id: id ?? this.id,
      title: title ?? this.title,
      originalTitle: originalTitle ?? this.originalTitle,
      overview: overview ?? this.overview,
      popularity: popularity ?? this.popularity,
      posterPath: posterPath ?? this.posterPath,
      backdropPath: backdropPath ?? this.backdropPath,
      releaseDate: releaseDate ?? this.releaseDate,
      video: video ?? this.video,
      voteAverage: voteAverage ?? this.voteAverage,
    );
  }
}

