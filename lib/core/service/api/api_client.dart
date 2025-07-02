import 'package:dio/dio.dart';
import 'package:flutter_tech_assessment/core/service/api/api_endpoint.dart';
import 'package:flutter_tech_assessment/core/service/api/api_response.dart';

class ApiClient {
  final _dio = Dio(
    BaseOptions(
      baseUrl: ApiEndpoint.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      contentType: Headers.jsonContentType,
    ),
  );

  Future<ApiResponse> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final result = await _dio.get(path, queryParameters: queryParameters);

    return ApiResponse(data: result.data);
  }
}
