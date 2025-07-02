import 'package:equatable/equatable.dart';
import 'package:flutter_tech_assessment/core/base/entity/base_list_param_entity.dart';

class BaseListRequest extends Equatable {
  final int? page;
  final String? search;

  const BaseListRequest({this.page, this.search});

  Map<String, dynamic> toJson() {
    return {
      if (page != null) 'page': page,
      if (search != null) 'search': search,
    };
  }

  factory BaseListRequest.fromEntity(BaseListParamEntity entity) {
    return BaseListRequest(page: entity.page, search: entity.search);
  }

  @override
  List<Object?> get props => [page, search];
}
