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
    var res = await client
        .request<SampleEntity>(SamplePath(parser: SampleEntityParser()));
    res.fold((l) => print(l.message), (r) => print(r.object));
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
    var res = await client
        .request<SampleEntity>(SamplePath(parser: SampleEntityParser()));
    res.fold((l) => print(l.message), (r) => print(r.rowObject));
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
    var res = await client
        .request<SampleEntity>(SamplePath(parser: SampleEntityParser()));
    res.fold((l) => print(l.message), (r) => print(r.object!.objectId));
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
    var res = await client.request(SamplePath(parser: SampleEntityParser()));
    res.fold((l) => print(l.message), (r) => print(r.rowObject));
  });
}

class SamplePath extends RequestApi {
  SamplePath({required super.parser});

  @override
  String get endPath => "raw/4Nngn37p";
}

class SampleEntity extends Entity {
  String objectId = "20";
}

class SampleEntityParser extends EntityParser<SampleEntity> {
  @override
  SampleEntity parseObject(Map<String, dynamic> json) {
    return SampleEntity();
  }
}

class MyInterCeptorFailed extends Interceptor {
  @override
  Future<Either<NetworkFailure, RequestApi>> onRequest(
      RequestApi endPath, NetworkClient client) async {
    return const Left(
        NetworkFailure(statusCode: 300, message: "Failed from Interceptor"));
  }
}

class MyInterCeptorSuccess extends Interceptor {
  @override
  Future<Either<NetworkFailure, RequestApi>> onRequest(
      RequestApi endPath, NetworkClient client) async {
    return Right(endPath);
  }
}

class MyAdapter extends NetworkResponseAdapter {
  static bool isCalled = false;
  @override
  Future<Either<NetworkFailure, NetworkResponseModel<T>>>
      onResponse<T extends Entity>(
          Either<NetworkFailure, NetworkResponseModel<T>> response,
          RequestApi endPath,
          NetworkClient client) async {
    print(endPath.endPath);
    if (!MyAdapter.isCalled) {
      MyAdapter.isCalled = true;
      var res = await client
          .request<SampleEntity>(SamplePath(parser: SampleEntityParser()));
      return res.fold((l) => Left(l), (r) => client.request(endPath));
    }

    return response;
  }
}

class MyFailedAdapter extends NetworkResponseAdapter {
  static bool isCalled = false;
  @override
  Future<Either<NetworkFailure, NetworkResponseModel<T>>>
      onResponse<T extends Entity>(
          Either<NetworkFailure, NetworkResponseModel<T>> response,
          RequestApi endPath,
          NetworkClient client) async {
    print(endPath.endPath);
    if (!MyAdapter.isCalled) {
      MyAdapter.isCalled = true;
      var res = await client
          .request<SampleEntity>(SamplePath(parser: SampleEntityParser()));
      return res.fold((l) => Left(l), (r) => client.request(endPath));
    } else {
      return const Left(
          NetworkFailure(statusCode: 300, message: "Failed from Interceptor"));
    }
  }
}
