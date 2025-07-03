import 'package:equatable/equatable.dart';
import 'package:flutter_tech_assessment/core/base/entity/base_list_param_entity.dart';

class BaseListRequest extends Equatable {
  final int? page;
  final String? search;
  final List<String>? ids;

  const BaseListRequest({this.page, this.search, this.ids});

  Map<String, dynamic> toJson() {
    return {
      if (page != null) 'page': page,
      if (search != null) 'search': search,
      if (ids != null) 'ids': ids!.join(','),
    };
  }

  factory BaseListRequest.fromEntity(BaseListParamEntity entity) {
    return BaseListRequest(
      page: entity.page,
      search: entity.search,
      ids: entity.ids,
    );
  }

  @override
  List<Object?> get props => [page, search, ids];
}
