import 'package:flutter/material.dart';
import 'package:flutter_netwok_module/src/base/network_api.dart';

@immutable
class NetworkResponseModel {
  final NetworkApi endPath;
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
