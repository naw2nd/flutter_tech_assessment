import 'package:flutter_tech_assessment/core/base/response/base_list_response.dart';
import 'package:flutter_tech_assessment/modules/books/data/response/books_response.dart';
import 'package:flutter_tech_assessment/modules/books/domain/entity/book_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../fakes/test_data/books_test_data.dart';

void main() {
  group('BaseListResponse fromJson', () {
    test('should return a valid BaseListResponse model from JSON', () async {
      // Arrange
      final json = BooksTestData.jsonMapResult;

      // Act
      final result = BaseListResponse.fromJson(
        json,
        (e) => BookResponse.fromJson(e),
      );

      // Assert
      expect(result, equals(BooksTestData.baseListBookResponses));
    });
  });

  group('BaseListResponse toEntity', () {
    test(
      'should return a valid BaseListEntity model from BaseListResponse',
      () async {
        // Arrange
        final response = BooksTestData.baseListBookResponses;

        // Act
        final result = response.toEntity<BookEntity>((e) => e.toEntity());

        // Assert
        expect(result, equals(BooksTestData.baseListBookEntities));
      },
    );
  });
}
