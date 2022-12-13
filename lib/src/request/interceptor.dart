import 'package:dartz/dartz.dart';
import 'package:flutter_netwok_module/src/base/network_failure.dart';
import 'package:flutter_netwok_module/src/base/network_api.dart';
import 'package:flutter_netwok_module/src/network_client.dart';

abstract class Interceptor {
  Future<Either<NetworkFailure, RequestApi>> onRequest(
    RequestApi api,
    NetworkClient client,
  );
}
