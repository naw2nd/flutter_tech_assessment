import 'package:equatable/equatable.dart';

class BaseListResultEntity<T> extends Equatable {
  final int count;
  final int page;
  final bool hasMore;
  final List<T> results;

  const BaseListResultEntity({
    required this.count,
    required this.page,
    this.hasMore = false,
    required this.results,
  });

  @override
  List<Object?> get props => [count, page, results];
}
