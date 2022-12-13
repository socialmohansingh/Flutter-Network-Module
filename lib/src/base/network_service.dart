import 'package:dartz/dartz.dart';
import 'package:flutter_netwok_module/src/base/base_entity_model.dart';
import 'package:flutter_netwok_module/src/response/response_model.dart';
import 'package:flutter_netwok_module/src/base/network_configuration.dart';
import 'package:flutter_netwok_module/src/base/network_failure.dart';
import 'package:flutter_netwok_module/src/base/network_api.dart';

// TODO: should handle patch and download
abstract class NetworkService {
  final NetworkConfiguration config;
  NetworkService({required this.config});

  Future<Either<NetworkFailure, NetworkResponseModel<T>>> get<T extends Entity>(
      RequestApi api);

  Future<Either<NetworkFailure, NetworkResponseModel<T>>>
      post<T extends Entity>(RequestApi api);

  Future<Either<NetworkFailure, NetworkResponseModel<T>>> put<T extends Entity>(
      RequestApi api);

  Future<Either<NetworkFailure, NetworkResponseModel<T>>>
      delete<T extends Entity>(RequestApi api);
}
