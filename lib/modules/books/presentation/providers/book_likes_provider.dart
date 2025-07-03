import 'package:flutter/material.dart';
import 'package:flutter_tech_assessment/core/base/entity/base_list_param_entity.dart';
import 'package:flutter_tech_assessment/core/base/entity/base_list_result_entity.dart';
import 'package:flutter_tech_assessment/core/utils/data_state.dart';
import 'package:flutter_tech_assessment/core/utils/result.dart';
import 'package:flutter_tech_assessment/modules/books/domain/entity/book_entity.dart';
import 'package:flutter_tech_assessment/modules/books/domain/interface/book_interface.dart';

class BookLikesProvider extends ChangeNotifier {
  final BookInterface _bookInterface;

  String _errorMessage = '';
  DataState _state = DataState.initial;

  bool _isLoadingMore = false;
  BaseListParamEntity _param = BaseListParamEntity(page: 1);
  final List<BaseListResultEntity<BookEntity>> _booksPerPages = [];
  List<String> _favoriteIds = [];
  List<BookEntity> get _books =>
      List.unmodifiable(_booksPerPages.expand((e) => e.results).toList());

  List<BookEntity> get favBooks =>
      List.unmodifiable((_books).where((e) => _favoriteIds.contains(e.id)));
  String get errorMessage => _errorMessage;
  DataState get state => _state;
  bool get isLoadingMore => _isLoadingMore;
  bool get hasMore => _booksPerPages.last.hasMore;

  BookLikesProvider({required BookInterface bookInterface})
    : _bookInterface = bookInterface;

  fetchBooks() async {
    _booksPerPages.clear();
    _state = DataState.loading;
    _errorMessage = '';
    notifyListeners();

    await _getFavorites();
    if (_favoriteIds.isEmpty) {
      return;
    }

    _param = _param.copyWith(ids: _favoriteIds, page: 1);
    await _fetchBooks();

    notifyListeners();
  }

  Future<void> _fetchBooks() async {
    final result = await _bookInterface.fetchBooks(_param);

    switch (result) {
      case Ok<BaseListResultEntity<BookEntity>>():
        _booksPerPages.add(result.value);
        _state = DataState.success;

      case Error<BaseListResultEntity<BookEntity>>():
        _errorMessage = result.error.toString();
        _state = DataState.error;
    }
  }

  fetchMoreBook() async {
    if (!hasMore || _isLoadingMore) return;
    _isLoadingMore = true;
    notifyListeners();

    final currentPage = _param.page ?? 1;
    _param = _param.copyWith(page: currentPage + 1);
    await _fetchBooks();

    _isLoadingMore = false;
    notifyListeners();
  }

  _getFavorites() async {
    _favoriteIds.clear();
    final result = await _bookInterface.getBookIdFavorites();

    switch (result) {
      case Ok<List<String>>():
        _favoriteIds = result.value;

      case Error<List<String>>():
        _state = DataState.error;
        _errorMessage = result.error.toString();
        notifyListeners();
    }
  }
}
