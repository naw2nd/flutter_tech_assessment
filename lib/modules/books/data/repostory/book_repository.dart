import 'package:flutter_tech_assessment/core/base/entity/base_list_param_entity.dart';
import 'package:flutter_tech_assessment/core/base/entity/base_list_result_entity.dart';
import 'package:flutter_tech_assessment/core/base/request/base_list_request.dart';
import 'package:flutter_tech_assessment/core/base/response/base_list_response.dart';
import 'package:flutter_tech_assessment/core/utils/exception.dart';
import 'package:flutter_tech_assessment/core/utils/result.dart';
import 'package:flutter_tech_assessment/modules/books/data/data_source/book_local_data_source.dart';
import 'package:flutter_tech_assessment/modules/books/data/data_source/book_remote_data_source.dart';
import 'package:flutter_tech_assessment/modules/books/data/response/books_response.dart';
import 'package:flutter_tech_assessment/modules/books/domain/entity/book_detail_entity.dart';
import 'package:flutter_tech_assessment/modules/books/domain/entity/book_entity.dart';
import 'package:flutter_tech_assessment/modules/books/domain/interface/book_interface.dart';

class BookRepository implements BookInterface {
  final BookRemoteDataSource _remoteDataSource;
  final BookLocalDataSource _localDataSource;

  BookRepository({
    required BookRemoteDataSource remoteDataSource,
    required BookLocalDataSource localDataSource,
  }) : _remoteDataSource = remoteDataSource,
       _localDataSource = localDataSource;

  @override
  Future<Result<BaseListResultEntity<BookEntity>>> fetchBooks(
    BaseListParamEntity param,
  ) async {
    try {
      final request = BaseListRequest.fromEntity(param);

      final response = await _remoteDataSource.fetchBooks(request);
      final result = response.toEntity<BookEntity>((e) => e.toEntity());

      _setCachedBooks(request, response);

      return Result.ok(result);
    } on ServerException catch (e) {
      final request = BaseListRequest.fromEntity(param);
      return _getCachedBooks(request, e);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future _setCachedBooks(
    BaseListRequest request,
    BaseListResponse<BookResponse> response,
  ) async {
    try {
      await _localDataSource.setCachedBooks(request, response);
    } catch (e) {
      return;
    }
  }

  Future<Result<BaseListResultEntity<BookEntity>>> _getCachedBooks(
    BaseListRequest request,
    Exception prevE,
  ) async {
    try {
      final response = await _localDataSource.getCachedBooks(request);
      final result = response.toEntity<BookEntity>((e) => e.toEntity());

      return Result.ok(result);
    } on Exception {
      return Result.error(prevE);
    }
  }

  @override
  Future<Result<BookDetailEntity>> fetchBookDetail(String id) async {
    try {
      final response = await _remoteDataSource.fetchBookDetail(id);
      final result = response.toDetailEntity();

      _setCachedBookDetail(id, response);

      return Result.ok(result);
    } on ServerException catch (e) {
      return _getCachedBookDetail(id, e);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future _setCachedBookDetail(String id, BookResponse response) async {
    try {
      await _localDataSource.setCachedBookDetail(id, response);
    } catch (e) {
      return;
    }
  }

  Future<Result<BookDetailEntity>> _getCachedBookDetail(
    String id,
    Exception prevE,
  ) async {
    try {
      final response = await _localDataSource.getCachedBookDetail(id);
      final result = response.toDetailEntity();

      return Result.ok(result);
    } on Exception {
      return Result.error(prevE);
    }
  }

  @override
  Future addToFavorites(String id) async {
    try {
      final currentFavs = await _localDataSource.getBookIdFavorites();
      final favs = currentFavs.map((e) => e.toString()).toList();
      favs.add(id);

      await _localDataSource.setBookIdFavorites(
        favs.map((e) => int.parse(e)).toList(),
      );

      return Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<List<String>>> getBookIdFavorites() async {
    try {
      final response = await _localDataSource.getBookIdFavorites();
      final result = response.map((e) => e.toString()).toList();

      return Result.ok(result);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future removeFromFavorites(String id) async {
    try {
      final currentFavs = await _localDataSource.getBookIdFavorites();
      final favs = currentFavs.map((e) => e.toString()).toList();
      favs.remove(id);

      await _localDataSource.setBookIdFavorites(
        favs.map((e) => int.parse(e)).toList(),
      );

      return Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<bool>> isFavorite(String id) async {
    try {
      final response = await _localDataSource.getBookIdFavorites();
      final result = response.map((e) => e.toString()).toList();

      return Result.ok(result.contains(id));
    } on Exception catch (e) {
      return Result.error(e);
    }
  }
}
