import 'dart:convert';

import 'package:flutter_tech_assessment/core/service/storage/local_storage_key.dart';
import 'package:flutter_tech_assessment/core/utils/exception.dart';
import 'package:flutter_tech_assessment/modules/books/data/data_source/book_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fakes/mock_modules.dart';
import '../../../../fakes/test_data/books_test_data.dart';

void main() {
  late MockLocalStorage mockLocalStorage;
  late BookLocalDataSource dataSource;

  setUp(() {
    mockLocalStorage = MockLocalStorage();
    dataSource = BookLocalDataSourceImpl(localStorage: mockLocalStorage);
  });

  group('BookLocalDataSource getBookIdFavorites', () {
    test(
      'should return a list of book ids when the Storage call is successful',
      () async {
        // Arrange
        when(
          () => mockLocalStorage.get(key: LocalStorageKey.favoriteBookIds),
        ).thenAnswer((_) async {
          return BooksTestData.bookFavoriteIdsString;
        });

        // Act
        final result = await dataSource.getBookIdFavorites();

        // Assert
        expect(result, equals(BooksTestData.bookFavoriteIds));
      },
    );

    test(
      'throws StorageException when localStorage throws an exception',
      () async {
        // Arrange
        when(
          () => mockLocalStorage.get(key: LocalStorageKey.favoriteBookIds),
        ).thenThrow(Exception('Storage error'));

        // Act
        final call = dataSource.getBookIdFavorites();

        // Assert
        expect(() => call, throwsA(isA<StorageException>()));
      },
    );
  });

  group('BookLocalDataSource setBookIdFavorites', () {
    test(
      'should return a list of book ids when the Storage call is successful',
      () async {
        // Arrange
        String modifiedStringIds = BooksTestData.bookFavoriteIdsString;

        when(
          () => mockLocalStorage.set(
            key: LocalStorageKey.favoriteBookIds,
            value: BooksTestData.bookFavoriteIdsString,
          ),
        ).thenAnswer((_) async {
          modifiedStringIds = jsonEncode([...BooksTestData.bookFavoriteIds, 6]);
        });

        // Act
        await dataSource.setBookIdFavorites(BooksTestData.bookFavoriteIds);

        // Assert
        expect(
          jsonDecode(modifiedStringIds),
          equals([...BooksTestData.bookFavoriteIds, 6]),
        );
      },
    );

    test(
      'throws StorageException when localStorage throws an exception',
      () async {
        // Arrange
        when(
          () => mockLocalStorage.set(
            key: LocalStorageKey.favoriteBookIds,
            value: BooksTestData.bookFavoriteIdsString,
          ),
        ).thenThrow(Exception('Storage error'));

        // Act
        final call = dataSource.setBookIdFavorites(
          BooksTestData.bookFavoriteIds,
        );

        // Assert
        expect(() => call, throwsA(isA<StorageException>()));
      },
    );
  });
}
