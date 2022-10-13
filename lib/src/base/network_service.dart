import 'package:dartz/dartz.dart';
import 'package:flutter_netwok_module/src/response/response_model.dart';
import 'package:flutter_netwok_module/src/base/network_configuration.dart';
import 'package:flutter_netwok_module/src/base/network_failure.dart';
import 'package:flutter_netwok_module/src/base/network_route_end_path.dart';

// TODO: should handle patch and download
abstract class NetworkService {
  final NetworkConfiguration config;
  NetworkService({required this.config});

  Future<Either<NetworkFailure, NetworkResponseModel>> get(NetworkApi endPath);

  Future<Either<NetworkFailure, NetworkResponseModel>> post(NetworkApi endPath);

  Future<Either<NetworkFailure, NetworkResponseModel>> put(NetworkApi endPath);

  Future<Either<NetworkFailure, NetworkResponseModel>> delete(
      NetworkApi endPath);
}
