import 'package:flutter_netwok_module/src/base/base_entity_model.dart';
import 'package:flutter_netwok_module/src/base/network_api.dart';

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
