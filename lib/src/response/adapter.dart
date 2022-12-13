import 'package:dartz/dartz.dart';
import 'package:flutter_netwok_module/src/base/base_entity_model.dart';
import 'package:flutter_netwok_module/src/response/response_model.dart';
import 'package:flutter_netwok_module/src/base/network_failure.dart';
import 'package:flutter_netwok_module/src/base/network_api.dart';
import 'package:flutter_netwok_module/src/network_client.dart';

abstract class NetworkResponseAdapter {
  Future<Either<NetworkFailure, NetworkResponseModel<T>>>
      onResponse<T extends Entity>(
    Either<NetworkFailure, NetworkResponseModel<T>> response,
    RequestApi api,
    NetworkClient client,
  );
}
