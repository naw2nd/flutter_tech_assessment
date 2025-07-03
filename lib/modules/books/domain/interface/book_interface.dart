import 'package:flutter_tech_assessment/core/base/entity/base_list_param_entity.dart';
import 'package:flutter_tech_assessment/core/base/entity/base_list_result_entity.dart';
import 'package:flutter_tech_assessment/core/utils/result.dart';
import 'package:flutter_tech_assessment/modules/books/domain/entity/book_detail_entity.dart';
import 'package:flutter_tech_assessment/modules/books/domain/entity/book_entity.dart';

abstract class BookInterface {
  Future<Result<BaseListResultEntity<BookEntity>>> fetchBooks(
    BaseListParamEntity param,
  );
  Future<Result<BookDetailEntity>> fetchBookDetail(String id);
}
