import 'package:flutter_netwok_module/flutter_netwok_module.dart';
import 'package:flutter_netwok_module/src/request/network_type.dart';
import 'package:flutter_netwok_module/src/request/request.dart';

class BaseURL {
  String baseURL;
  String baseVersionEndPath;
  BaseURL({
    required this.baseURL,
    this.baseVersionEndPath = "",
  });
}

abstract class NetworkConfiguration {
  BaseURL baseURL;
  double timeout;
  RequestType networkRequestType;
  List<AppInterceptor> interceptors;
  List<Adapter> adapters;

  NetworkConfiguration({
    required this.baseURL,
    this.interceptors = const [],
    this.adapters = const [],
    this.timeout = 70,
    this.networkRequestType = RequestType.rest,
  });
}
