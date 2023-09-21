import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_netwok_module/flutter_netwok_module.dart';

abstract class BaseNetworkClient {
  final NetworkService service;
  final NetworkConfiguration config;
  Future<Result<NetworkFailure, NetworkResponseModel<T>>>
      request<T extends Entity>(
    RequestApi api,
  );
  
  BaseNetworkClient({
    required this.service,
    required this.config,
  });
}

class NetworkClient extends BaseNetworkClient {
  NetworkClient._({
    required super.config,
    required super.service,
  });
  factory NetworkClient.fromConfig(NetworkConfiguration config) {
    final service = DIONetworkService(
      config: config,
    );
    return NetworkClient._(config: config, service: service);
  }

  factory NetworkClient.fromService(NetworkService service) {
    return NetworkClient._(config: service.config, service: service);
  }

  @override
  Future<Result<NetworkFailure, NetworkResponseModel<T>>>
      request<T extends Entity>(
    RequestApi api,
  ) async {
    //Handle Interceptors
    var interceptors = config.interceptors;
    NetworkFailure? interceptorFailure;
    for (var interceptor in interceptors) {
      var interceptRequest = await interceptor.onRequest(api, this);
      interceptRequest.fold((l) {
        interceptorFailure = l;
        return Failure(l);
      }, (r) {
        api = r;
      });
      if (interceptRequest.hasError()) {
        break;
      }
    }
    if (interceptorFailure != null) {
      return Failure(interceptorFailure!);
    }

    //Ntwork Client Request
    Result<NetworkFailure, NetworkResponseModel<T>> response;
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
      case HTTPMethod.patch:
        response = await service.patch(api);
        break;
    }

    response = response.fold((l) => Failure(l), (r) {
      final res = NetworkResponseModel<T>(
          api: api,
          statusCode: r.statusCode,
          message: r.message,
          rowObject: r.rowObject,
          object: api.parser != null
              ? api.parser!.parseObject(r.rowObject) as T
              : null);
      return Success(res);
    });

    //Handle Adapters
    var adapters = config.adapters;
    for (Adapter adapter in adapters) {
      Result<NetworkFailure, NetworkResponseModel<T>> aResponse =
          await adapter.onResponse(
        response,
        api,
        this,
      );
      if (aResponse.hasError()) {
        return aResponse;
      }
      response = aResponse;
    }

    return response;
  }
}
