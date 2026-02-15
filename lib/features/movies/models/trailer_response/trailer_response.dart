import 'package:json_annotation/json_annotation.dart';
import 'package:movies_module/features/movies/models/movie_trailer/movie_trailer.dart';

part 'trailer_response.g.dart';

@JsonSerializable()
class TrailerResponse {
  @JsonKey(name: "results")
  final List<MovieTrailer> trailers;

  TrailerResponse({required this.trailers});

  factory TrailerResponse.fromJson(Map<String, dynamic> json) =>
      _$TrailerResponseFromJson(json);
}
