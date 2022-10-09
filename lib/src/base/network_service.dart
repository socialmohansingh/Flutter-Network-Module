import 'package:dartz/dartz.dart';
import 'package:flutter_netwok_module/src/adapter/response_model.dart';
import 'package:flutter_netwok_module/src/base/network_configuration.dart';
import 'package:flutter_netwok_module/src/base/network_failure.dart';
import 'package:flutter_netwok_module/src/base/network_route_end_path.dart';

// TODO: should handle patch and download
abstract class NetworkService {
  final NetworkConfiguration config;
  NetworkService({required this.config});

  Future<Either<NetworkFailure, NetworkResponseModel>> get(
      NetworkRouteEndPath endPath);

  Future<Either<NetworkFailure, NetworkResponseModel>> post(
      NetworkRouteEndPath endPath);

  Future<Either<NetworkFailure, NetworkResponseModel>> put(
      NetworkRouteEndPath endPath);

  Future<Either<NetworkFailure, NetworkResponseModel>> delete(
      NetworkRouteEndPath endPath);
}
