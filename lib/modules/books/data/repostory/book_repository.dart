import 'package:flutter_tech_assessment/core/base/entity/base_list_param_entity.dart';
import 'package:flutter_tech_assessment/core/base/entity/base_list_result_entity.dart';
import 'package:flutter_tech_assessment/core/base/request/base_list_request.dart';
import 'package:flutter_tech_assessment/core/utils/result.dart';
import 'package:flutter_tech_assessment/modules/books/data/data_source/book_local_data_source.dart';
import 'package:flutter_tech_assessment/modules/books/data/data_source/book_remote_data_source.dart';
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

      return Result.ok(result);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<BookDetailEntity>> fetchBookDetail(String id) async {
    try {
      final response = await _remoteDataSource.fetchBookDetail(id);
      final result = response.toDetailEntity();

      return Result.ok(result);
    } on Exception catch (e) {
      return Result.error(e);
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
