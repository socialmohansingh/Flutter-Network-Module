import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_netwok_module/src/network/network_failure.dart';
import 'package:flutter_netwok_module/src/response/response_model.dart';
import 'package:flutter_netwok_module/src/config/network_configuration.dart';
import 'package:flutter_netwok_module/src/request/request_api.dart';

// TODO: should handle patch and download
abstract class NetworkService {
  final NetworkConfiguration config;
  NetworkService({required this.config});

  Future<Result<NetworkFailure, NetworkResponseModel<T>>> get<T extends Entity>(
      RequestApi api);

  Future<Result<NetworkFailure, NetworkResponseModel<T>>>
      post<T extends Entity>(RequestApi api);

  Future<Result<NetworkFailure, NetworkResponseModel<T>>> put<T extends Entity>(
      RequestApi api);

  Future<Result<NetworkFailure, NetworkResponseModel<T>>>
      delete<T extends Entity>(RequestApi api);
}
