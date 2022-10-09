import 'package:flutter/material.dart';
import 'package:flutter_netwok_module/src/base/network_route_end_path.dart';

@immutable
class NetworkResponseModel {
  final NetworkRouteEndPath endPath;
  final int statusCode;
  final String message;
  final Map<String, dynamic> data;

  const NetworkResponseModel({
    required this.endPath,
    required this.statusCode,
    required this.message,
    required this.data,
  });
}
