import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_netwok_module/src/network/network_failure.dart';
import 'package:flutter_netwok_module/src/network/network_service.dart';
import 'package:flutter_netwok_module/src/response/response_model.dart';
import 'package:flutter_netwok_module/src/request/request_api.dart';

class DIONetworkService extends NetworkService {
  final Dio dioClient = Dio();

  DIONetworkService({required super.config});

  @override
  Future<Result<NetworkFailure, NetworkResponseModel<T>>> get<T extends Entity>(
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
      return Success(
        NetworkResponseModel(
          api: api,
          statusCode: response.statusCode ?? 0,
          message: response.statusMessage ?? "",
          rowObject: response.data,
        ),
      );
    } catch (e) {
      return await _parseError(e);
    }
  }

  @override
  Future<Result<NetworkFailure, NetworkResponseModel<T>>>
      post<T extends Entity>(RequestApi api) async {
    try {
      String finalUrl = config.baseURL.baseURL +
          config.baseURL.baseVersionEndPath +
          api.endPath;
      Response<dynamic> response = await dioClient.post(
        finalUrl,
        queryParameters: api.queryParams,
        data: api.formdata ?? api.bodyParams,
        options: Options(
          headers: api.headers,
        ),
      );
      return Success(
        NetworkResponseModel(
          api: api,
          statusCode: response.statusCode ?? 200,
          message: response.statusMessage ?? "",
          rowObject: response.data,
        ),
      );
    } catch (e) {
      return await _parseError(e);
    }
  }

  @override
  Future<Result<NetworkFailure, NetworkResponseModel<T>>> put<T extends Entity>(
      RequestApi api) async {
    try {
      String finalUrl = config.baseURL.baseURL +
          config.baseURL.baseVersionEndPath +
          api.endPath;
      Response<dynamic> response = await dioClient.put(
        finalUrl,
        queryParameters: api.queryParams,
        data: api.formdata ?? api.bodyParams,
        options: Options(
          headers: api.headers,
        ),
      );
      return Success(
        NetworkResponseModel(
          api: api,
          statusCode: response.statusCode ?? 200,
          message: response.statusMessage ?? "",
          rowObject: response.data,
        ),
      );
    } catch (e) {
      return await _parseError(e);
    }
  }

  @override
  Future<Result<NetworkFailure, NetworkResponseModel<T>>>
      delete<T extends Entity>(RequestApi api) async {
    try {
      String finalUrl = config.baseURL.baseURL +
          config.baseURL.baseVersionEndPath +
          api.endPath;
      Response<dynamic> response = await dioClient.delete(
        finalUrl,
        queryParameters: api.queryParams,
        data: api.formdata ?? api.bodyParams,
        options: Options(
          headers: api.headers,
        ),
      );
      return Success(
        NetworkResponseModel(
          api: api,
          statusCode: response.statusCode ?? 200,
          message: response.statusMessage ?? "",
          rowObject: response.data,
        ),
      );
    } catch (e) {
      return await _parseError(e);
    }
  }

  @override
  Future<Result<NetworkFailure, NetworkResponseModel<T>>>
      patch<T extends Entity>(RequestApi api) async {
    try {
      String finalUrl = config.baseURL.baseURL +
          config.baseURL.baseVersionEndPath +
          api.endPath;
      Response<dynamic> response = await dioClient.patch(
        finalUrl,
        queryParameters: api.queryParams,
        data: api.formdata ?? api.bodyParams,
        options: Options(
          headers: api.headers,
        ),
      );
      return Success(
        NetworkResponseModel(
          api: api,
          statusCode: response.statusCode ?? 200,
          message: response.statusMessage ?? "",
          rowObject: response.data,
        ),
      );
    } catch (e) {
      return await _parseError(e);
    }
  }

  Future<Result<NetworkFailure, NetworkResponseModel<T>>>
      _parseError<T extends Entity>(e) async {
    try {
      if (e is DioError) {
        if (e.response?.data != null) {
          final data = e.response?.data as Map<String, dynamic>;
          final error = data["message"] as String?;
          return Failure(NetworkFailure(
            message: error ?? e.toString(),
            statusCode: e.response?.statusCode ?? 400,
            rowObject: data,
          ));
        } else {
          final connection = await checkInternetConnection();
          if (connection) {
            return Failure(NetworkFailure(message: e.message, statusCode: 400));
          } else {
            return Failure(const NetworkFailure(
                message:
                    "Internet connection appears to be offline. Please check your internet connection.",
                statusCode: 522));
          }
        }
      } else {
        return Failure(NetworkFailure(message: e.toString(), statusCode: 400));
      }
    } catch (e) {
      return Failure(NetworkFailure(message: e.toString(), statusCode: 400));
    }
  }

  Future<bool> checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
  }
}
