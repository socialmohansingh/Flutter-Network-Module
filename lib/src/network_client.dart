import 'package:dartz/dartz.dart';
import 'package:flutter_netwok_module/src/adapter/adapter.dart';
import 'package:flutter_netwok_module/src/adapter/response_model.dart';
import 'package:flutter_netwok_module/src/base/http_method.dart';
import 'package:flutter_netwok_module/src/base/network_configuration.dart';
import 'package:flutter_netwok_module/src/base/network_failure.dart';
import 'package:flutter_netwok_module/src/base/network_route_end_path.dart';
import 'package:flutter_netwok_module/src/base/network_service.dart';
import 'package:flutter_netwok_module/src/dio_client/dio_client.dart';
import 'package:flutter_netwok_module/src/request/interceptor.dart';

abstract class BaseNetworkClient {
  final NetworkConfiguration config;
  final NetworkService service;
  final List<Interceptor> _interceptors = [];
  final List<NetworkResponseAdapter> _adapters = [];

  BaseNetworkClient({
    required this.config,
    required this.service,
  });
}

class NetworkClient extends BaseNetworkClient {
  NetworkClient({NetworkConfiguration? config, NetworkService? networkService})
      : super(
          config: config ??
              NetworkConfiguration.config ??
              NetworkConfiguration(
                baseURL: BaseURL(
                  baseURL: "",
                ),
              ),
          service: networkService ??
              DIONetworkService(
                config: config ??
                    NetworkConfiguration.config ??
                    NetworkConfiguration(
                      baseURL: BaseURL(
                        baseURL: "",
                      ),
                    ),
              ),
        );

  Future<Either<NetworkFailure, NetworkResponseModel>> request<T>(
    NetworkRouteEndPath endPath,
  ) async {
    //Handle Interceptors
    NetworkFailure? interceptorFailure;
    for (var interceptor in _interceptors) {
      var interceptRequest = await interceptor.onRequest(endPath, this);
      interceptRequest.fold((l) {
        interceptorFailure = l;
        return Left(l);
      }, (r) {
        endPath = r;
      });
      if (interceptRequest.isLeft()) {
        break;
      }
    }
    if (interceptorFailure != null) {
      return Left(interceptorFailure!);
    }

    //Ntwork Client Request
    Either<NetworkFailure, NetworkResponseModel> response;
    switch (endPath.method) {
      case HTTPMethod.get:
        response = await service.get(endPath);
        break;
      case HTTPMethod.post:
        response = await service.post(endPath);
        break;
      case HTTPMethod.put:
        response = await service.put(endPath);
        break;
      case HTTPMethod.delete:
        response = await service.delete(endPath);
        break;
    }

    //Handle Adapters
    for (NetworkResponseAdapter adapter in _adapters) {
      Either<NetworkFailure, NetworkResponseModel> aResponse =
          await adapter.onResponseAdapter(
        response,
        endPath,
        this,
      );
      if (aResponse.isLeft()) {
        return aResponse;
      }
      response = aResponse;
    }

    return response;
  }

  void addInterceptors(List<Interceptor> interceptors) {
    _interceptors.addAll(interceptors);
  }

  void addAdopters(List<NetworkResponseAdapter> adaptors) {
    _adapters.addAll(adaptors);
  }
}
