import 'package:flutter_netwok_module/src/base/base_entity_model.dart';
import 'package:flutter_netwok_module/src/base/http_method.dart';

abstract class EndPathParam {
  final Map<String, dynamic> bodyParams;
  final Map<String, dynamic> queryParams;
  EndPathParam({
    required this.bodyParams,
    required this.queryParams,
  });
}

abstract class RequestApi extends EndPathParam {
  final String? alterNativeBaseURL = "";
  final String endPath = "";
  final bool shouldRequireAccessToken = true;
  final HTTPMethod method = HTTPMethod.get;
  final Map<String, String>? headers = {};
  final EntityParser parser;

  RequestApi({
    required this.parser,
    super.bodyParams = const {},
    super.queryParams = const {},
  });
}
