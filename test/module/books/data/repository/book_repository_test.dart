import 'package:flutter_tech_assessment/core/base/entity/base_list_param_entity.dart';
import 'package:flutter_tech_assessment/core/base/request/base_list_request.dart';
import 'package:flutter_tech_assessment/core/utils/exception.dart';
import 'package:flutter_tech_assessment/core/utils/result.dart';
import 'package:flutter_tech_assessment/modules/books/data/data_source/book_remote_data_source.dart';
import 'package:flutter_tech_assessment/modules/books/data/repostory/book_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fakes/mock_modules.dart';
import '../../../../fakes/test_data/books_test_data.dart';

void main() {
  late BookRemoteDataSource mockBookRemoteDataSource;
  late BookRepository bookRepository;

  setUp(() {
    mockBookRemoteDataSource = MockBookRemoteDataSource();
    bookRepository = BookRepository(remoteDataSource: mockBookRemoteDataSource);
  });

  group('BookRepository fetchBooks', () {
    test('should return list of books when fetchBooks is called', () async {
      // Arrange
      final param = BaseListParamEntity();
      final request = BaseListRequest.fromEntity(param);

      when(() => mockBookRemoteDataSource.fetchBooks(request)).thenAnswer((
        _,
      ) async {
        return BooksTestData.baseListBookResponses;
      });

      // Act
      final result = await bookRepository.fetchBooks(param);

      // Assert
      expect(result, equals(Result.ok(BooksTestData.baseListBookEntities)));
    });

    test(
      'should return list of books when fetchBooks is called with param',
      () async {
        // Arrange
        final param = BaseListParamEntity(search: 'Frank');
        final request = BaseListRequest.fromEntity(param);

        when(() => mockBookRemoteDataSource.fetchBooks(request)).thenAnswer((
          _,
        ) async {
          return BooksTestData.baseListBookResponses;
        });

        // Act
        final result = await bookRepository.fetchBooks(param);

        // Assert
        expect(result, equals(Result.ok(BooksTestData.baseListBookEntities)));
      },
    );

    test('throws ServerException when apiClient throws an exception', () async {
      // Arrange
      final param = BaseListParamEntity();
      final request = BaseListRequest.fromEntity(param);
      final exception = ServerException('Network error');

      when(
        () => mockBookRemoteDataSource.fetchBooks(request),
      ).thenThrow(exception);

      // Act
      final result = await bookRepository.fetchBooks(param);

      // Assert
      expect(result, isA<Error>());
    });
  });

  group('BookRepository fetchBookDetail', () {
    final id = '1';

    test('should return book detail when fetchBookDetail is called', () async {
      // Arrange
      final tBookDetailResponse =
          BooksTestData.baseListBookResponses.results.first;
      final tBookDetailEntity =
          BooksTestData.baseListBookDetailEntities.results.first;

      when(() => mockBookRemoteDataSource.fetchBookDetail(id)).thenAnswer((
        _,
      ) async {
        return tBookDetailResponse;
      });

      // Act
      final result = await bookRepository.fetchBookDetail(id);

      // Assert
      expect(result, equals(Result.ok(tBookDetailEntity)));
    });

    test('throws ServerException when apiClient throws an exception', () async {
      // Arrange
      final exception = ServerException('Network error');

      when(
        () => mockBookRemoteDataSource.fetchBookDetail(id),
      ).thenThrow(exception);

      // Act
      final result = await bookRepository.fetchBookDetail(id);

      // Assert
      expect(result, isA<Error>());
    });
  });
}
