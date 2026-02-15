import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies_module/core/networking/network_errors.dart';
import 'package:movies_module/core/utils/api_result/api_result.dart';
import 'package:movies_module/features/movies/models/movie/movie.dart';
import 'package:movies_module/features/movies/repo/movies_repo.dart';

import '../../helpers/test_helper.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockApiService mockApiService;
  late MoviesRepo moviesRepo;

  setUp(() {
    mockApiService = MockApiService();
    moviesRepo = MoviesRepo(apiService: mockApiService);
  });

  group('getPopularMovies', () {
    test('should return list of movies when API call is successful', () async {
      // Arrange
      when(
        mockApiService.getPopularMovies(),
      ).thenAnswer((_) async => TestDataFactory.moviesResponse);

      // Act
      final result = await moviesRepo.getPopularMovies();

      // Assert
      expect(result, isA<Success<List<Movie>>>());
      expect((result as Success<List<Movie>>).data.length, 2);
      expect(result.data.first.title, 'Ant-Man and the Wasp: Quantumania');
      verify(mockApiService.getPopularMovies()).called(1);
    });

    test('should return failure when API call throws DioException', () async {
      // Arrange
      final dioException = DioException(
        requestOptions: RequestOptions(path: ''),
        type: DioExceptionType.connectionTimeout,
      );

      when(mockApiService.getPopularMovies()).thenThrow(dioException);

      // Act
      final result = await moviesRepo.getPopularMovies();

      // Assert
      expect(result, isA<Failure<List<Movie>>>());
      expect(
        (result as Failure<List<Movie>>).errorModel.message,
        NetworkErrors.timeoutError,
      );
      verify(mockApiService.getPopularMovies()).called(1);
    });

    test(
      'should return failure when API call throws general exception',
      () async {
        // Arrange
        when(
          mockApiService.getPopularMovies(),
        ).thenThrow(Exception('Unknown error'));

        // Act
        final result = await moviesRepo.getPopularMovies();

        // Assert
        expect(result, isA<Failure<List<Movie>>>());
        expect(
          (result as Failure<List<Movie>>).errorModel.message,
          NetworkErrors.genericError,
        );
        verify(mockApiService.getPopularMovies()).called(1);
      },
    );
  });
}
