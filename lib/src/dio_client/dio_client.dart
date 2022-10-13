import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_netwok_module/src/response/response_model.dart';
import 'package:flutter_netwok_module/src/base/network_failure.dart';
import 'package:flutter_netwok_module/src/base/network_route_end_path.dart';
import 'package:flutter_netwok_module/src/base/network_service.dart';

class DIONetworkService extends NetworkService {
  final Dio dioClient = Dio();

  DIONetworkService({required super.config});

  @override
  Future<Either<NetworkFailure, NetworkResponseModel>> get(
      NetworkApi endPath) async {
    try {
      String finalUrl = config.baseURL.baseURL +
          config.baseURL.baseVersionEndPath +
          endPath.endPath;

      Response<dynamic> response = await dioClient.get(
        finalUrl,
        queryParameters: endPath.queryParams,
        options: Options(
          headers: endPath.headers,
        ),
      );
      return Right(
        NetworkResponseModel(
          endPath: endPath,
          statusCode: response.statusCode ?? 0,
          message: response.statusMessage ?? "",
          data: jsonDecode(response.data),
        ),
      );
    } catch (e) {
      //TODO: Handle Throw expection
      return Left(NetworkFailure(message: e.toString(), statusCode: 1));
    }
  }

  @override
  Future<Either<NetworkFailure, NetworkResponseModel>> post(
      NetworkApi endPath) async {
    try {
      String finalUrl = config.baseURL.baseURL +
          config.baseURL.baseVersionEndPath +
          endPath.endPath;
      Response<dynamic> response = await dioClient.post(
        finalUrl,
        queryParameters: endPath.queryParams,
        data: endPath.bodyParams,
        options: Options(
          headers: endPath.headers,
        ),
      );

      return Right(
        NetworkResponseModel(
          endPath: endPath,
          statusCode: response.statusCode ?? 200,
          message: response.statusMessage ?? "",
          data: jsonDecode(response.data),
        ),
      );
    } catch (e) {
      return Left(NetworkFailure(message: e.toString(), statusCode: 400));
    }
  }

  @override
  Future<Either<NetworkFailure, NetworkResponseModel>> put(NetworkApi endPath) {
    // TODO: implement put
    throw UnimplementedError();
  }

  @override
  Future<Either<NetworkFailure, NetworkResponseModel>> delete(
      NetworkApi endPath) {
    // TODO: implement delete
    throw UnimplementedError();
  }
}
