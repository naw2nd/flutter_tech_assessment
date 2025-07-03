import 'package:flutter_tech_assessment/core/service/api/api_client.dart';
import 'package:flutter_tech_assessment/core/service/storage/local_storage.dart';
import 'package:flutter_tech_assessment/modules/books/data/data_source/book_local_data_source.dart';
import 'package:flutter_tech_assessment/modules/books/data/data_source/book_remote_data_source.dart';
import 'package:mocktail/mocktail.dart';

class MockApiClient extends Mock implements ApiClient {}

class MockBookRemoteDataSource extends Mock implements BookRemoteDataSource {}

class MockLocalStorage extends Mock implements LocalStorage {}

class MockBookLocalDataSource extends Mock implements BookLocalDataSource {}
