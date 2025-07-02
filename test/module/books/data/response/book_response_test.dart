import 'package:flutter_tech_assessment/modules/books/data/response/books_response.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../fakes/test_data/books_test_data.dart';

void main() {
  group('BookResponse fromJson', () {
    test('should return a valid BookResponse model from JSON', () async {
      // Arrange
      final json = (BooksTestData.jsonMapResult['results'] as List).first;

      // Act
      final result = BookResponse.fromJson(json);

      // Assert
      expect(result, equals(BooksTestData.bookResponses.first));
    });
  });

  group('BookResponse toEntity', () {
    test('should return a valid BookEntity model from BookResponse', () async {
      // Arrange
      final response = BooksTestData.bookResponses.first;

      // Act
      final result = response.toEntity();

      // Assert
      expect(result, equals(BooksTestData.listBookEntities.first));
    });

    test(
      'should return a valid BookDetailEntity model from BookResponse',
      () async {
        // Arrange
        final response = BooksTestData.bookResponses.first;

        // Act
        final result = response.toDetailEntity();

        // Assert
        expect(result, equals(BooksTestData.listBookDetailEntities.first));
      },
    );
  });
}
