enum HTTPMethod { get, post, put, delete, patch }

extension HTTPMethodExtension on HTTPMethod {
  String value() {
    return toString().split(".").last.toUpperCase();
  }
}
