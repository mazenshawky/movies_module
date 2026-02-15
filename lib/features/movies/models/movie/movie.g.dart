// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) => Movie(
  backdropPath:
      json['backdrop_path'] as String? ?? "/eNJhWy7xFzR74SYaSJHqJZuroDm.jpg",
  id: (json['id'] as num).toInt(),
  originalTitle: json['original_title'] as String,
  overview: json['overview'] as String,
  popularity: (json['popularity'] as num).toDouble(),
  posterPath: json['poster_path'] as String?,
  releaseDate: json['release_date'] as String,
  title: json['title'] as String,
  video: json['video'] as bool,
  voteAverage: (json['vote_average'] as num).toDouble(),
);
