import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies_module/features/movies/models/movie/movie.dart';
import 'package:movies_module/features/movies/ui/business_logic/get_a_trailer_youtube_key/get_a_trailer_youtube_key_cubit.dart';
import 'package:movies_module/features/movies/ui/business_logic/get_popular_movies/get_popular_movies_cubit.dart';
import 'package:movies_module/features/movies/ui/business_logic/get_popular_movies/get_popular_movies_state.dart';
import 'package:movies_module/features/movies/ui/movies_screen.dart';
import 'package:movies_module/features/movies/ui/widgets/movie_card.dart';

import '../../helpers/test_helper.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetPopularMoviesCubit mockCubit;
  late MockGetATrailerYoutubeKeyCubit mockTrailerCubit;

  setUp(() {
    mockCubit = MockGetPopularMoviesCubit();
    mockTrailerCubit = MockGetATrailerYoutubeKeyCubit();

    when(mockTrailerCubit.stream).thenAnswer((_) => const Stream.empty());
  });

  Widget createWidgetUnderTest() {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetPopularMoviesCubit>.value(
          value: mockCubit,
        ),
        BlocProvider<GetATrailerYoutubeKeyCubit>.value(
          value: mockTrailerCubit,
        ),
      ],
      child: const MaterialApp(
        home: MoviesScreen(),
      ),
    );
  }

  group('MoviesScreen Widget Tests', () {
    testWidgets('should show loading indicator when state is loading', (tester) async {
      // Arrange
      when(mockCubit.state).thenReturn(const GetPopularMoviesState.loading());
      when(mockCubit.stream).thenAnswer((_) => Stream.value(const GetPopularMoviesState.loading()));

      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should show error message when state is error', (tester) async {
      // Arrange
      when(mockCubit.state).thenReturn(GetPopularMoviesState.error(TestDataFactory.errorModel));
      when(mockCubit.stream).thenAnswer((_) => Stream.value(GetPopularMoviesState.error(TestDataFactory.errorModel)));

      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Assert
      expect(find.text('Test error message'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.text('Try Again'), findsOneWidget);
    });

    testWidgets('should show movie list when state is success with movies', (tester) async {
      // Arrange
      final movies = TestDataFactory.moviesList
          .map((json) => Movie.fromJson(json))
          .toList();
      
      when(mockCubit.state).thenReturn(GetPopularMoviesState.getPopularMoviesSuccess(movies));
      when(mockCubit.stream).thenAnswer((_) => Stream.value(GetPopularMoviesState.getPopularMoviesSuccess(movies)));

      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Assert
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(MovieCard), findsNWidgets(2));
      expect(find.text('Ant-Man and the Wasp: Quantumania'), findsOneWidget);
      expect(find.text('The Super Mario Bros. Movie'), findsOneWidget);
    });

    testWidgets('should show empty state when movie list is empty', (tester) async {
      // Arrange
      when(mockCubit.state).thenReturn(GetPopularMoviesState.getPopularMoviesSuccess([]));
      when(mockCubit.stream).thenAnswer((_) => Stream.value(GetPopularMoviesState.getPopularMoviesSuccess([])));

      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Assert
      expect(find.text('No popular movies found'), findsOneWidget);
    });

    testWidgets('should retry loading when retry button is tapped', (tester) async {
      // Arrange
      when(mockCubit.state).thenReturn(GetPopularMoviesState.error(TestDataFactory.errorModel));
      when(mockCubit.stream).thenAnswer((_) => Stream.value(GetPopularMoviesState.error(TestDataFactory.errorModel)));

      // Act
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.tap(find.text('Try Again'));
      await tester.pump();

      // Assert
      verify(mockCubit.getPopularMovies()).called(1);
    });
  });
}