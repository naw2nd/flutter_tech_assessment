import 'package:flutter_tech_assessment/core/base/request/base_list_request.dart';
import 'package:flutter_tech_assessment/core/base/response/base_list_response.dart';
import 'package:flutter_tech_assessment/core/service/api/api_endpoint.dart';
import 'package:flutter_tech_assessment/core/service/api/api_response.dart';
import 'package:flutter_tech_assessment/core/utils/exception.dart';
import 'package:flutter_tech_assessment/modules/books/data/data_source/book_remote_data_source.dart';
import 'package:flutter_tech_assessment/modules/books/data/response/books_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fakes/mock_modules.dart';
import '../../../../fakes/test_data/books_test_data.dart';

void main() {
  late MockApiClient mockApiClient;
  late BookRemoteDataSource dataSource;

  setUp(() {
    mockApiClient = MockApiClient();
    dataSource = BookRemoteDataSourceImpl(apiClient: mockApiClient);
  });

  group('BookRemoteDataSource fetchBooks', () {
    final tBookListResponse = BaseListResponse<BookResponse>.fromJson(
      BooksTestData.jsonMapResult,
      (json) => BookResponse.fromJson(json),
    );
    final path = ApiEndpoint.booksEndpoint;

    test(
      'should return a list of books when the API call is successful',
      () async {
        // Arrange
        final request = BaseListRequest();

        when(
          () => mockApiClient.get(path, queryParameters: request.toJson()),
        ).thenAnswer((_) async {
          return ApiResponse(data: BooksTestData.jsonMapResult);
        });

        // Act
        final result = await dataSource.fetchBooks(request);

        // Assert
        expect(result, equals(tBookListResponse));
      },
    );

    test(
      'should call apiClient.get with correct search query parameter',
      () async {
        // Arrange
        final request = BaseListRequest(search: 'Frank');

        when(
          () => mockApiClient.get(path, queryParameters: request.toJson()),
        ).thenAnswer((_) async {
          return ApiResponse(data: BooksTestData.jsonMapResult);
        });

        // Act
        final result = await dataSource.fetchBooks(request);

        // Assert
        expect(result, equals(tBookListResponse));
      },
    );

    test('throws ServerException when apiClient throws an exception', () async {
      // Arrange
      final request = BaseListRequest();

      when(
        () => mockApiClient.get(path, queryParameters: request.toJson()),
      ).thenThrow(Exception('Network error'));

      // Act
      final call = dataSource.fetchBooks(request);

      // Assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('BookRemoteDataSource fetchBookDetail', () {
    final id = '1';
    final path = '${ApiEndpoint.booksEndpoint}/$id';

    test(
      'should return a book detail when the API call is successful',
      () async {
        // Arrange
        final tBookDetailResult = BaseListResponse<BookResponse>.fromJson(
          BooksTestData.jsonMapResult,
          (json) => BookResponse.fromJson(json),
        ).results.first;
        final bookDetailResponse =
            (BooksTestData.jsonMapResult['results'] as List).first;

        when(() => mockApiClient.get(path)).thenAnswer((_) async {
          return ApiResponse(data: bookDetailResponse);
        });

        // Act
        final result = await dataSource.fetchBookDetail(id);

        // Assert
        expect(result, equals(tBookDetailResult));
      },
    );

    test('throws ServerException when apiClient throws an exception', () async {
      // Arrange
      when(() => mockApiClient.get(path)).thenThrow(Exception('Network error'));

      // Act
      final call = dataSource.fetchBookDetail(id);

      // Assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
