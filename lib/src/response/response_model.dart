import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_netwok_module/src/request/request_api.dart';

class NetworkResponseModel<T extends Entity> {
  final RequestApi api;
  final int statusCode;
  final String message;
  final Map<String, dynamic> rowObject;
  T? object;

  NetworkResponseModel({
    required this.api,
    required this.statusCode,
    required this.message,
    required this.rowObject,
    this.object,
  });
}
