import 'dart:convert';

import 'package:flutter_tech_assessment/core/base/request/base_list_request.dart';
import 'package:flutter_tech_assessment/core/base/response/base_list_response.dart';
import 'package:flutter_tech_assessment/core/service/storage/local_storage.dart';
import 'package:flutter_tech_assessment/core/service/storage/local_storage_key.dart';
import 'package:flutter_tech_assessment/core/utils/exception.dart';
import 'package:flutter_tech_assessment/modules/books/data/response/books_response.dart';

abstract class BookLocalDataSource {
  Future<List<int>> getBookIdFavorites();
  Future setBookIdFavorites(List<int> ids);
  Future<BaseListResponse<BookResponse>> getCachedBooks(
    BaseListRequest request,
  );
  Future setCachedBooks(
    BaseListRequest request,
    BaseListResponse<BookResponse> datas,
  );
  Future<BookResponse> getCachedBookDetail(String id);
  Future setCachedBookDetail(String id, BookResponse data);
}

class BookLocalDataSourceImpl implements BookLocalDataSource {
  final LocalStorage _localStorage;

  BookLocalDataSourceImpl({required LocalStorage localStorage})
    : _localStorage = localStorage;

  @override
  Future<List<int>> getBookIdFavorites() async {
    try {
      final data =
          await _localStorage.get(key: LocalStorageKey.favoriteBookIds)
              as String?;
      if (data == null) {
        return [];
      }

      final List<dynamic> decoded = jsonDecode(data);
      final result = decoded.map((e) => int.parse(e.toString())).toList();

      return result;
    } on Exception catch (e) {
      throw StorageException(e.toString());
    }
  }

  @override
  Future setBookIdFavorites(List<int> ids) async {
    try {
      final data = jsonEncode(ids);
      await _localStorage.set(
        key: LocalStorageKey.favoriteBookIds,
        value: data,
      );
    } on Exception catch (e) {
      throw StorageException(e.toString());
    }
  }

  @override
  Future<BaseListResponse<BookResponse>> getCachedBooks(
    BaseListRequest request,
  ) async {
    try {
      final key = request.toJson();
      final jsonKey = jsonEncode(key);

      final jsonResult = await _localStorage.get(
        key: LocalStorageKey.cachedBooks + jsonKey,
      );
      final mapResult = jsonDecode(jsonResult);
      final result = BaseListResponse<BookResponse>.fromJson(
        mapResult,
        (json) => BookResponse.fromJson(json),
      );

      return result;
    } on Exception catch (e) {
      throw StorageException(e.toString());
    }
  }

  @override
  Future setCachedBooks(
    BaseListRequest request,
    BaseListResponse<BookResponse> datas,
  ) async {
    try {
      final key = request.toJson();
      final jsonKey = jsonEncode(key);

      final value = datas.toJson((e) => e.toJson());
      final jsonValue = jsonEncode(value);

      await _localStorage.set(
        key: LocalStorageKey.cachedBooks + jsonKey,
        value: jsonValue,
      );
    } on Exception catch (e) {
      throw StorageException(e.toString());
    }
  }

  @override
  Future<BookResponse> getCachedBookDetail(String id) async {
    try {
      final key = id;
      final jsonKey = jsonEncode(key);

      final jsonResult = await _localStorage.get(
        key: LocalStorageKey.cachedBookDetail + jsonKey,
      );
      final mapResult = jsonDecode(jsonResult);
      final result = BookResponse.fromJson(mapResult);

      return result;
    } on Exception catch (e) {
      throw StorageException(e.toString());
    }
  }

  @override
  Future setCachedBookDetail(String id, BookResponse data) async {
    try {
      final key = id;
      final jsonKey = jsonEncode(key);

      final value = data.toJson();
      final jsonValue = jsonEncode(value);

      await _localStorage.set(
        key: LocalStorageKey.cachedBookDetail + jsonKey,
        value: jsonValue,
      );
    } on Exception catch (e) {
      throw StorageException(e.toString());
    }
  }
}
