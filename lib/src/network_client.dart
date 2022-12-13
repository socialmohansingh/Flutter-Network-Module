import 'package:dartz/dartz.dart';
import 'package:flutter_netwok_module/src/base/base_entity_model.dart';
import 'package:flutter_netwok_module/src/response/adapter.dart';
import 'package:flutter_netwok_module/src/response/response_model.dart';
import 'package:flutter_netwok_module/src/base/http_method.dart';
import 'package:flutter_netwok_module/src/base/network_configuration.dart';
import 'package:flutter_netwok_module/src/base/network_failure.dart';
import 'package:flutter_netwok_module/src/base/network_api.dart';
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

  Future<Either<NetworkFailure, NetworkResponseModel<T>>>
      request<T extends Entity>(
    RequestApi api,
  ) async {
    //Handle Interceptors
    NetworkFailure? interceptorFailure;
    for (var interceptor in _interceptors) {
      var interceptRequest = await interceptor.onRequest(api, this);
      interceptRequest.fold((l) {
        interceptorFailure = l;
        return Left(l);
      }, (r) {
        api = r;
      });
      if (interceptRequest.isLeft()) {
        break;
      }
    }
    if (interceptorFailure != null) {
      return Left(interceptorFailure!);
    }

    //Ntwork Client Request
    Either<NetworkFailure, NetworkResponseModel<T>> response;
    switch (api.method) {
      case HTTPMethod.get:
        response = await service.get(api);
        break;
      case HTTPMethod.post:
        response = await service.post(api);
        break;
      case HTTPMethod.put:
        response = await service.put(api);
        break;
      case HTTPMethod.delete:
        response = await service.delete(api);
        break;
    }

    response = response.fold((l) => Left(l), (r) {
      final res = NetworkResponseModel<T>(
          api: api,
          statusCode: r.statusCode,
          message: r.message,
          rowObject: r.rowObject,
          object: api.parser.parseObject(r.rowObject) as T);
      return Right(res);
    });

    //Handle Adapters
    for (NetworkResponseAdapter adapter in _adapters) {
      Either<NetworkFailure, NetworkResponseModel<T>> aResponse =
          await adapter.onResponse(
        response,
        api,
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
