import 'package:dartz/dartz.dart';
import 'package:flutter_netwok_module/src/base/network_failure.dart';
import 'package:flutter_netwok_module/src/base/network_route_end_path.dart';
import 'package:flutter_netwok_module/src/network_client.dart';

abstract class Interceptor {
  Future<Either<NetworkFailure, NetworkApi>> onRequest(
    NetworkApi endPath,
    NetworkClient client,
  );
}
