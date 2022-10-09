import 'package:dartz/dartz.dart';
import 'package:flutter_netwok_module/src/response/response_model.dart';
import 'package:flutter_netwok_module/src/base/network_failure.dart';
import 'package:flutter_netwok_module/src/base/network_route_end_path.dart';
import 'package:flutter_netwok_module/src/network_client.dart';

abstract class NetworkResponseAdapter {
  Future<Either<NetworkFailure, NetworkResponseModel>> onResponseAdapter(
    Either<NetworkFailure, NetworkResponseModel> response,
    NetworkRouteEndPath endPath,
    NetworkClient client,
  );
}
