import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_netwok_module/src/network/network_failure.dart';
import 'package:flutter_netwok_module/src/response/response_model.dart';
import 'package:flutter_netwok_module/src/request/request_api.dart';
import 'package:flutter_netwok_module/src/network/network_client.dart';

abstract class Adapter {
  Future<Result<NetworkFailure, NetworkResponseModel<T>>>
      onResponse<T extends Entity>(
    Result<NetworkFailure, NetworkResponseModel<T>> response,
    RequestApi api,
    NetworkClient client,
  );
}
