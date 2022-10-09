enum HTTPMethod { get, post, put, delete }

extension HTTPMethodExtension on HTTPMethod {
  String value() {
    return toString().split(".").last.toUpperCase();
  }
}
