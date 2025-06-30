import 'package:flutter_tech_assessment/core/base/entity/base_list_param_entity.dart';

class BaseListRequest {
  final int? page;
  final String? search;

  BaseListRequest({this.page, this.search});

  Map<String, dynamic> toJson() {
    return {
      if (page != null) 'page': page,
      if (search != null) 'search': search,
    };
  }

  factory BaseListRequest.fromEntity(BaseListParamEntity entity) {
    return BaseListRequest(page: entity.page, search: entity.search);
  }
}
