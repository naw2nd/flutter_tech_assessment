import 'package:flutter/material.dart';
import 'package:flutter_tech_assessment/modules/books/domain/entity/book_entity.dart';

class BookDetailProvider extends ChangeNotifier {
  BookEntity? book;

  void fetchBook() {
    book = _sampleBook();
    notifyListeners();
  }

  BookEntity _sampleBook() => BookEntity(
    id: '2',
    title: 'To Kill a Mockingbird',
    author: ['Harper Lee'],
  );
}
