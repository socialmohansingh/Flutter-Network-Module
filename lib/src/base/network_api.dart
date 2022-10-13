import 'package:flutter_netwok_module/src/base/http_method.dart';

abstract class EndPathParam {
  final Map<String, dynamic> bodyParams;
  final Map<String, dynamic> queryParams;
  EndPathParam({
    required this.bodyParams,
    required this.queryParams,
  });
}

abstract class NetworkApi extends EndPathParam {
  final String? alterNativeBaseURL = "";
  final String endPath = "";
  final bool shouldRequireAccessToken = true;
  final HTTPMethod method = HTTPMethod.get;
  final Map<String, String>? headers = {};

  NetworkApi({
    super.bodyParams = const {},
    super.queryParams = const {},
  });
}
