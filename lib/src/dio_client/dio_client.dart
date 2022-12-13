import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_netwok_module/src/base/base_entity_model.dart';
import 'package:flutter_netwok_module/src/response/response_model.dart';
import 'package:flutter_netwok_module/src/base/network_failure.dart';
import 'package:flutter_netwok_module/src/base/network_api.dart';
import 'package:flutter_netwok_module/src/base/network_service.dart';

class DIONetworkService extends NetworkService {
  final Dio dioClient = Dio();

  DIONetworkService({required super.config});

  @override
  Future<Either<NetworkFailure, NetworkResponseModel<T>>> get<T extends Entity>(
      RequestApi api) async {
    try {
      String finalUrl = config.baseURL.baseURL +
          config.baseURL.baseVersionEndPath +
          api.endPath;

      Response<dynamic> response = await dioClient.get(
        finalUrl,
        queryParameters: api.queryParams,
        options: Options(
          headers: api.headers,
        ),
      );
      return Right(
        NetworkResponseModel(
          api: api,
          statusCode: response.statusCode ?? 0,
          message: response.statusMessage ?? "",
          rowObject: jsonDecode(response.data),
        ),
      );
    } catch (e) {
      //TODO: Handle Throw expection
      return Left(NetworkFailure(message: e.toString(), statusCode: 1));
    }
  }

  @override
  Future<Either<NetworkFailure, NetworkResponseModel<T>>>
      post<T extends Entity>(RequestApi api) async {
    try {
      String finalUrl = config.baseURL.baseURL +
          config.baseURL.baseVersionEndPath +
          api.endPath;
      Response<dynamic> response = await dioClient.post(
        finalUrl,
        queryParameters: api.queryParams,
        data: api.bodyParams,
        options: Options(
          headers: api.headers,
        ),
      );

      return Right(
        NetworkResponseModel(
          api: api,
          statusCode: response.statusCode ?? 200,
          message: response.statusMessage ?? "",
          rowObject: jsonDecode(response.data),
        ),
      );
    } catch (e) {
      return Left(NetworkFailure(message: e.toString(), statusCode: 400));
    }
  }

  @override
  Future<Either<NetworkFailure, NetworkResponseModel<T>>> put<T extends Entity>(
      RequestApi api) {
    // TODO: implement put
    throw UnimplementedError();
  }

  @override
  Future<Either<NetworkFailure, NetworkResponseModel<T>>>
      delete<T extends Entity>(RequestApi api) {
    // TODO: implement delete
    throw UnimplementedError();
  }
}
