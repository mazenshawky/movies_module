import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies_module/features/movies/ui/widgets/movie_card.dart';
import 'package:movies_module/features/movies/models/movie/movie.dart';
import 'package:movies_module/features/movies/ui/business_logic/get_a_trailer_youtube_key/get_a_trailer_youtube_key_cubit.dart';

import '../../helpers/test_helper.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late Movie testMovie;
  late MockGetATrailerYoutubeKeyCubit mockTrailerCubit;

  setUp(() {
    testMovie = Movie.fromJson(TestDataFactory.movieJson);
    mockTrailerCubit = MockGetATrailerYoutubeKeyCubit();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: Scaffold(
        body: BlocProvider<GetATrailerYoutubeKeyCubit>.value(
          value: mockTrailerCubit,
          child: MovieCard(movie: testMovie, onTap: () {}),
        ),
      ),
    );
  }

  group('MovieCard Widget Tests', () {
    testWidgets('should display movie title correctly', (tester) async {
      // Arrange
      await tester.pumpWidget(createWidgetUnderTest());

      // Assert
      expect(find.text('Ant-Man and the Wasp: Quantumania'), findsOneWidget);
    });

    testWidgets('should display movie overview correctly', (tester) async {
      // Arrange
      await tester.pumpWidget(createWidgetUnderTest());

      // Assert
      expect(
        find.textContaining('Super-Hero partners Scott Lang'),
        findsOneWidget,
      );
    });

    testWidgets('should display vote average with star icon', (tester) async {
      // Arrange
      await tester.pumpWidget(createWidgetUnderTest());

      // Assert
      expect(find.byIcon(Icons.star), findsOneWidget);
      expect(find.text('6.5'), findsOneWidget);
    });

    testWidgets('should display release date when available', (tester) async {
      // Arrange
      await tester.pumpWidget(createWidgetUnderTest());

      // Assert
      expect(find.byIcon(Icons.calendar_today), findsOneWidget);
      expect(find.textContaining('2023'), findsOneWidget);
    });

    testWidgets('should call onTap when card is tapped', (tester) async {
      // Arrange
      var tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider<GetATrailerYoutubeKeyCubit>.value(
              value: mockTrailerCubit,
              child: MovieCard(movie: testMovie, onTap: () => tapped = true),
            ),
          ),
        ),
      );

      // Act
      await tester.tap(find.byType(InkWell));
      await tester.pump();

      // Assert
      expect(tapped, true);
    });

    testWidgets('should display popularity indicator', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byIcon(Icons.trending_up), findsOneWidget);
      expect(find.textContaining('Popularity:'), findsOneWidget);

      final popularityText = find.text('Popularity: 8568');
      expect(popularityText, findsOneWidget);
    });

    testWidgets('should format date correctly', (tester) async {
      // Arrange
      await tester.pumpWidget(createWidgetUnderTest());

      // Assert
      expect(find.text('15/2/2023'), findsOneWidget);
    });
  });
}
