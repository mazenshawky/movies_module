import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_module/core/di/dependency_injection.dart';
import 'package:movies_module/core/routing/routes.dart';
import 'package:movies_module/features/movies/ui/business_logic/get_a_trailer_youtube_key/get_a_trailer_youtube_key_cubit.dart';
import 'package:movies_module/features/movies/ui/business_logic/get_popular_movies/get_popular_movies_cubit.dart';
import 'package:movies_module/features/movies/ui/movies_screen.dart';

class AppRouter {
  const AppRouter._();

  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.movies:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    getIt<GetPopularMoviesCubit>()..getPopularMovies(),
              ),
              BlocProvider(
                create: (context) => getIt<GetATrailerYoutubeKeyCubit>(),
              ),
            ],
            child: MoviesScreen(),
          ),
        );

      default:
        return null;
    }
  }
}
