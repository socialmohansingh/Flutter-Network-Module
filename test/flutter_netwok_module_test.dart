import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_netwok_module/flutter_netwok_module.dart';

void main() {
  _simpleGetRequest(); // sample get request
  _simpleInterceptorFailedGetRequest(); // interceptor can block your request
  _simpleInterceptorSuccessGetRequest(); // interceptor request
  _simpleAdapterSuccessGetRequest(); // interceptor request
}

void _simpleGetRequest() {
  test("Network request test", () async {
    NetworkConfiguration config = NetworkConfiguration(
        baseURL: BaseURL(
      baseURL: "https://pastebin.com/",
    ));
    NetworkClient client = NetworkClient(config: config);
    var res = await client.request(SamplePath());
    res.fold((l) => print(l.message), (r) => print(r.data));
  });
}

void _simpleInterceptorFailedGetRequest() {
  test("Network interceptor failed request test", () async {
    NetworkConfiguration config = NetworkConfiguration(
        baseURL: BaseURL(
      baseURL: "https://pastebin.com/",
    ));
    NetworkClient client = NetworkClient(config: config);
    client.addInterceptors([MyInterCeptorFailed()]);
    var res = await client.request(SamplePath());
    res.fold((l) => print(l.message), (r) => print(r.data));
  });
}

void _simpleInterceptorSuccessGetRequest() {
  test("Network interceptor success request test", () async {
    NetworkConfiguration config = NetworkConfiguration(
        baseURL: BaseURL(
      baseURL: "https://pastebin.com/",
    ));
    NetworkClient client = NetworkClient(config: config);
    client.addInterceptors([MyInterCeptorSuccess()]);
    var res = await client.request(SamplePath());
    res.fold((l) => print(l.message), (r) => print(r.data));
  });
}

void _simpleAdapterSuccessGetRequest() {
  test("Network Adapter success request test", () async {
    NetworkConfiguration config = NetworkConfiguration(
        baseURL: BaseURL(
      baseURL: "https://pastebin.com/",
    ));
    NetworkClient client = NetworkClient(config: config);
    client.addAdopters([MyAdapter()]);
    var res = await client.request(SamplePath());
    res.fold((l) => print(l.message), (r) => print(r.data));
  });
}

class SamplePath extends NetworkRouteEndPath {
  @override
  String get endPath => "raw/4Nngn37p";
}

class MyInterCeptorFailed extends Interceptor {
  @override
  Future<Either<NetworkFailure, NetworkRouteEndPath>> onRequest(
      NetworkRouteEndPath endPath, NetworkClient client) async {
    return const Left(
        NetworkFailure(statusCode: 300, message: "Failed from Interceptor"));
  }
}

class MyInterCeptorSuccess extends Interceptor {
  @override
  Future<Either<NetworkFailure, NetworkRouteEndPath>> onRequest(
      NetworkRouteEndPath endPath, NetworkClient client) async {
    return Right(endPath);
  }
}

class MyAdapter extends NetworkResponseAdapter {
  static bool isCalled = false;
  @override
  Future<Either<NetworkFailure, NetworkResponseModel>> onResponseAdapter(
      Either<NetworkFailure, NetworkResponseModel> response,
      NetworkRouteEndPath endPath,
      NetworkClient client) async {
    print(endPath.endPath);
    if (!MyAdapter.isCalled) {
      MyAdapter.isCalled = true;
      var res = await client.request(SamplePath());
      return res.fold((l) => Left(l), (r) => client.request(endPath));
    }

    return response;
  }
}

class MyFailedAdapter extends NetworkResponseAdapter {
  static bool isCalled = false;
  @override
  Future<Either<NetworkFailure, NetworkResponseModel>> onResponseAdapter(
      Either<NetworkFailure, NetworkResponseModel> response,
      NetworkRouteEndPath endPath,
      NetworkClient client) async {
    print(endPath.endPath);
    if (!MyAdapter.isCalled) {
      MyAdapter.isCalled = true;
      var res = await client.request(SamplePath());
      return res.fold((l) => Left(l), (r) => client.request(endPath));
    } else {
      return const Left(
          NetworkFailure(statusCode: 300, message: "Failed from Interceptor"));
    }
  }
}
