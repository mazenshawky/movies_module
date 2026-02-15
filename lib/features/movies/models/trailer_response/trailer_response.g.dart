// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trailer_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrailerResponse _$TrailerResponseFromJson(Map<String, dynamic> json) =>
    TrailerResponse(
      trailers: (json['results'] as List<dynamic>)
          .map((e) => MovieTrailer.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
