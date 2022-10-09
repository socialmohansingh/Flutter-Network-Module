class BaseURL {
  final String baseURL;
  final String baseVersionEndPath;
  BaseURL({
    required this.baseURL,
    this.baseVersionEndPath = "",
  });
}

class NetworkConfiguration {
  static NetworkConfiguration? config;

  final BaseURL baseURL;
  final double timeout;

  NetworkConfiguration({
    required this.baseURL,
    this.timeout = 5000,
  });
}
