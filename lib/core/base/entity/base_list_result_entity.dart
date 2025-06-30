class BaseListResultEntity<T> {
  final int count;
  final int page;
  final List<T> results;

  BaseListResultEntity({
    required this.count,
    required this.page,
    required this.results,
  });
}
