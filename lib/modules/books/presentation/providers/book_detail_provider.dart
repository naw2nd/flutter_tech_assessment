import 'package:flutter/material.dart';
import 'package:flutter_tech_assessment/core/utils/data_state.dart';
import 'package:flutter_tech_assessment/core/utils/result.dart';
import 'package:flutter_tech_assessment/modules/books/domain/entity/book_detail_entity.dart';
import 'package:flutter_tech_assessment/modules/books/domain/interface/book_interface.dart';

class BookDetailProvider extends ChangeNotifier {
  final BookInterface _bookInterface;

  String _errorMessage = '';
  DataState _state = DataState.initial;
  BookDetailEntity? _bookDetail;

  String get errorMessage => _errorMessage;
  DataState get state => _state;
  BookDetailEntity? get bookDetail => _bookDetail;

  BookDetailProvider({required BookInterface bookInterface})
    : _bookInterface = bookInterface;

  fetchBookDetail(String id) async {
    _bookDetail = null;
    _state = DataState.loading;
    _errorMessage = '';
    notifyListeners();

    final result = await _bookInterface.fetchBookDetail(id);

    switch (result) {
      case Ok<BookDetailEntity>():
        _bookDetail = result.value;
        _state = DataState.success;

      case Error<BookDetailEntity>():
        _errorMessage = result.error.toString();
        _state = DataState.error;
    }

    notifyListeners();
  }
}
