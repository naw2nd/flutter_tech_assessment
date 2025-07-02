import 'package:equatable/equatable.dart';

class BaseListParamEntity extends Equatable {
  final int? page;
  final String? search;

  const BaseListParamEntity({this.page, this.search});

  @override
  List<Object?> get props => [page, search];
}
