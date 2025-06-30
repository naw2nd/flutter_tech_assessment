import 'package:flutter/material.dart';
import 'package:flutter_tech_assessment/modules/books/domain/entity/book_entity.dart';

class BookLikesProvider extends ChangeNotifier {
  List<BookEntity> books = [];

  void fetchBooks() {
    books = _sampleBooks();
    notifyListeners();
  }

  List<BookEntity> _sampleBooks() {
    return [
      BookEntity(id: '1', title: '1984', author: ['George Orwell']),
      BookEntity(
        id: '2',
        title: 'To Kill a Mockingbird',
        author: ['Harper Lee'],
      ),
      BookEntity(
        id: '3',
        title: 'The Great Gatsby',
        author: ['F. Scott Fitzgerald'],
      ),
    ];
  }
}
