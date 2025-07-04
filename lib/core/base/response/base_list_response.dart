import 'package:equatable/equatable.dart';
import 'package:flutter_tech_assessment/core/base/entity/base_list_result_entity.dart';

class BaseListResponse<T> extends Equatable {
  final int count;
  final String? next;
  final String? previous;
  final List<T> results;

  const BaseListResponse({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory BaseListResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    return BaseListResponse<T>(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results: (json['results'] as List)
          .map((item) => fromJsonT(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T) toJsonT) {
    return {
      'count': count,
      'next': next,
      'previous': previous,
      'results': results.map((item) => toJsonT(item)).toList(),
    };
  }

  BaseListResultEntity<E> toEntity<E>(E Function(T) toEntityE) {
    final page = _getCurrentPage(next, previous);

    return BaseListResultEntity<E>(
      count: count,
      page: page,
      hasMore: next?.isNotEmpty == true,
      results: results.map(toEntityE).toList(),
    );
  }

  int _getCurrentPage(String? next, String? previous) {
    if (previous != null) {
      final uri = Uri.tryParse(previous);
      final prevPage = int.tryParse(uri?.queryParameters['page'] ?? '0') ?? 0;
      return prevPage + 1;
    } else if (next != null) {
      final uri = Uri.tryParse(next);
      final nextPage = int.tryParse(uri?.queryParameters['page'] ?? '2') ?? 2;
      return nextPage - 1;
    } else {
      return 1;
    }
  }

  @override
  List<Object?> get props => [count, next, previous, results];
}
