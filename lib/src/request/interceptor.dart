import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_netwok_module/src/network/network_failure.dart';
import 'package:flutter_netwok_module/src/request/request_api.dart';
import 'package:flutter_netwok_module/src/network/network_client.dart';

abstract class Interceptor {
  Future<Result<NetworkFailure, RequestApi>> onRequest(
    RequestApi api,
    NetworkClient client,
  );
}
