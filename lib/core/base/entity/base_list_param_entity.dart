import 'package:equatable/equatable.dart';

class BaseListParamEntity extends Equatable {
  final int? page;
  final String? search;

  const BaseListParamEntity({this.page, this.search});

  @override
  List<Object?> get props => [page, search];

  BaseListParamEntity copyWith({int? page, String? search}) {
    return BaseListParamEntity(
      page: page ?? this.page,
      search: search ?? this.search,
    );
  }
}
