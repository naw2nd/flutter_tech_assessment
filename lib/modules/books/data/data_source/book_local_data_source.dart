import 'dart:convert';

import 'package:flutter_tech_assessment/core/service/storage/local_storage.dart';
import 'package:flutter_tech_assessment/core/service/storage/local_storage_key.dart';
import 'package:flutter_tech_assessment/core/utils/exception.dart';

abstract class BookLocalDataSource {
  Future<List<int>> getBookIdFavorites();
  Future setBookIdFavorites(List<int> ids);
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
              as String;

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
}
