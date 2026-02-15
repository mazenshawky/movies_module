import 'package:bloc/bloc.dart';
import 'package:movies_module/core/utils/api_result/api_result.dart';
import 'package:movies_module/features/movies/repo/movies_repo.dart';
import 'package:movies_module/features/movies/ui/business_logic/get_a_trailer_youtube_key/get_a_trailer_youtube_key_state.dart';

class GetATrailerYoutubeKeyCubit extends Cubit<GetATrailerYoutubeKeyState> {
  GetATrailerYoutubeKeyCubit({required MoviesRepo repo})
    : _repo = repo,
      super(const GetATrailerYoutubeKeyState.initial());

  final MoviesRepo _repo;

  Future<void> getATrailerYoutubeKey({required int movieId}) async {
    emit(const GetATrailerYoutubeKeyState.loading());
    ApiResult<String> response = await _repo.getATrailerYoutubeKey(
      movieId: movieId,
    );
    switch (response) {
      case Success<String>(:final data):
        emit(GetATrailerYoutubeKeyState.getATrailerYoutubeKeySuccess(data));
      case Failure(:final errorModel):
        emit(GetATrailerYoutubeKeyState.error(errorModel));
    }
  }
}
