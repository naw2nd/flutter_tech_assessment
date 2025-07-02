import 'package:equatable/equatable.dart';

class BaseListResultEntity<T> extends Equatable {
  final int count;
  final int page;
  final List<T> results;

  const BaseListResultEntity({
    required this.count,
    required this.page,
    required this.results,
  });

  @override
  List<Object?> get props => [count, page, results];
}
