import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:movies_module/core/models/error_model/error_model.dart';

part 'get_a_trailer_youtube_key_state.freezed.dart';

@freezed
class GetATrailerYoutubeKeyState with _$GetATrailerYoutubeKeyState {
  const factory GetATrailerYoutubeKeyState.initial() = _Initial;
  const factory GetATrailerYoutubeKeyState.loading() =
      GetATrailerYoutubeKeyLoading;
  const factory GetATrailerYoutubeKeyState.error(ErrorModel errorModel) =
      GetATrailerYoutubeKeyError;
  const factory GetATrailerYoutubeKeyState.getATrailerYoutubeKeySuccess(
    String trailerYoutubeKey,
  ) = GetATrailerYoutubeKeySuccess;
}
