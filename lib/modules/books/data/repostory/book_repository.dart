import 'package:flutter_tech_assessment/core/base/entity/base_list_param_entity.dart';
import 'package:flutter_tech_assessment/core/base/entity/base_list_result_entity.dart';
import 'package:flutter_tech_assessment/core/base/request/base_list_request.dart';
import 'package:flutter_tech_assessment/core/utils/result.dart';
import 'package:flutter_tech_assessment/modules/books/data/data_source/book_remote_data_source.dart';
import 'package:flutter_tech_assessment/modules/books/domain/entity/book_detail_entity.dart';
import 'package:flutter_tech_assessment/modules/books/domain/entity/book_entity.dart';
import 'package:flutter_tech_assessment/modules/books/domain/interface/book_interface.dart';

class BookRepository implements BookInterface {
  final BookRemoteDataSource remoteDataSource;

  BookRepository({required this.remoteDataSource});

  @override
  Future<Result<BaseListResultEntity<BookEntity>>> fetchBooks(
    BaseListParamEntity param,
  ) async {
    try {
      final request = BaseListRequest.fromEntity(param);

      final response = await remoteDataSource.fetchBooks(request);
      final result = response.toEntity<BookEntity>((e) => e.toEntity());

      return Result.ok(result);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<BookDetailEntity>> fetchBookDetail(String id) async {
    try {
      final response = await remoteDataSource.fetchBookDetail(id);
      final result = response.toDetailEntity();

      return Result.ok(result);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future addToFavorites(String id) {
    // TODO: implement addToFavorites
    throw UnimplementedError();
  }

  @override
  Future<List<String>> getBookIdFavorites() {
    // TODO: implement getBookIdFavorites
    throw UnimplementedError();
  }

  @override
  Future removeFromFavorites(String id) {
    // TODO: implement removeFromFavorites
    throw UnimplementedError();
  }
}
