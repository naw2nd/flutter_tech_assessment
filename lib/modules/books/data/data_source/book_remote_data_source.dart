import 'package:flutter_tech_assessment/core/base/request/base_list_request.dart';
import 'package:flutter_tech_assessment/core/base/response/base_list_response.dart';
import 'package:flutter_tech_assessment/core/service/api/api_client.dart';
import 'package:flutter_tech_assessment/core/service/api/api_endpoint.dart';
import 'package:flutter_tech_assessment/core/utils/exception.dart';
import 'package:flutter_tech_assessment/modules/books/data/response/books_response.dart';

abstract class BookRemoteDataSource {
  Future<BaseListResponse<BookResponse>> fetchBooks(BaseListRequest request);
  Future<BookResponse> fetchBookDetail(String id);
}

class BookRemoteDataSourceImpl implements BookRemoteDataSource {
  BookRemoteDataSourceImpl({required ApiClient apiClient})
    : _apiClient = apiClient;
  final ApiClient _apiClient;

  @override
  Future<BaseListResponse<BookResponse>> fetchBooks(
    BaseListRequest request,
  ) async {
    try {
      final response = await _apiClient.get(
        ApiEndpoint.booksEndpoint,
        queryParameters: request.toJson(),
      );

      final result = BaseListResponse<BookResponse>.fromJson(
        response.data,
        (json) => BookResponse.fromJson(json),
      );

      return result;
    } on Exception catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<BookResponse> fetchBookDetail(String id) async {
    try {
      final response = await _apiClient.get('${ApiEndpoint.booksEndpoint}/$id');

      final result = BookResponse.fromJson(response.data);

      return result;
    } on Exception catch (e) {
      throw ServerException(e.toString());
    }
  }
}
