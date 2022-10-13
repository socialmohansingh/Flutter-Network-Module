import 'package:dartz/dartz.dart';
import 'package:flutter_netwok_module/src/response/response_model.dart';
import 'package:flutter_netwok_module/src/base/network_failure.dart';
import 'package:flutter_netwok_module/src/base/network_api.dart';
import 'package:flutter_netwok_module/src/network_client.dart';

abstract class NetworkResponseAdapter {
  Future<Either<NetworkFailure, NetworkResponseModel>> onResponse(
    Either<NetworkFailure, NetworkResponseModel> response,
    NetworkApi endPath,
    NetworkClient client,
  );
}
