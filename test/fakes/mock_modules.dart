import 'package:flutter_tech_assessment/core/service/api/api_client.dart';
import 'package:flutter_tech_assessment/modules/books/data/data_source/book_remote_data_source.dart';
import 'package:mocktail/mocktail.dart';

class MockApiClient extends Mock implements ApiClient {}

class MockBookRemoteDataSource extends Mock implements BookRemoteDataSource {}
