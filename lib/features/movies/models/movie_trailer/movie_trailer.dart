import 'package:json_annotation/json_annotation.dart';

part 'movie_trailer.g.dart';

@JsonSerializable()
class MovieTrailer {
  final String key;
  final String site;

  const MovieTrailer({
    required this.key,
    required this.site,
  });

  factory MovieTrailer.fromJson(Map<String, dynamic> json) =>
      _$MovieTrailerFromJson(json);
}
