import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_module/features/movies/ui/business_logic/get_a_trailer_youtube_key/get_a_trailer_youtube_key_cubit.dart';
import 'package:movies_module/features/movies/ui/business_logic/get_popular_movies/get_popular_movies_cubit.dart';
import 'package:movies_module/features/movies/ui/business_logic/get_popular_movies/get_popular_movies_state.dart';
import 'package:movies_module/features/movies/ui/widgets/movie_card.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        title: Text(
          'Popular Movies',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
            color: Colors.white
          ),
        ),
        backgroundColor: Colors.grey.shade900,
        elevation: 0,
      ),
      body: BlocBuilder<GetPopularMoviesCubit, GetPopularMoviesState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(
              child: Text(
                'Start searching for movies',
                style: TextStyle(color: Colors.white),
              ),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (errorModel) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 60, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    errorModel.message,
                    style: const TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<GetPopularMoviesCubit>().getPopularMovies();
                    },
                    child: const Text('Try Again'),
                  ),
                ],
              ),
            ),
            getPopularMoviesSuccess: (movies) {
              if (movies.isEmpty) {
                return const Center(
                  child: Text(
                    'No popular movies found',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.only(top: 8, bottom: 16),
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return MovieCard(movie: movie, onTap: () async {
                    await context.read<GetATrailerYoutubeKeyCubit>().getATrailerYoutubeKey(movieId: movie.id);
                  });
                },
              );
            },
          );
        },
      ),
    );
  }
}
