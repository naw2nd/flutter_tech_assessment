import 'package:equatable/equatable.dart';

class BaseListParamEntity extends Equatable {
  final int? page;
  final String? search;
  final List<String>? ids;

  const BaseListParamEntity({this.page, this.search, this.ids});

  @override
  List<Object?> get props => [page, search, ids];

  BaseListParamEntity copyWith({int? page, String? search, List<String>? ids}) {
    return BaseListParamEntity(
      page: page ?? this.page,
      search: search ?? this.search,
      ids: ids ?? this.ids,
    );
  }
}
