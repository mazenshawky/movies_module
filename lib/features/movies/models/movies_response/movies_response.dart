import 'package:json_annotation/json_annotation.dart';
import 'package:movies_module/features/movies/models/movie/movie.dart';

part 'movies_response.g.dart';

@JsonSerializable()
class MoviesResponse {
  @JsonKey(name: 'results')
  final List<Movie> movies;

  MoviesResponse({
    required this.movies,
  });

  factory MoviesResponse.fromJson(Map<String, dynamic> json) =>
      _$MoviesResponseFromJson(json);
}
