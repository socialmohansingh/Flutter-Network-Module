import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class NetworkFailure extends NetworkError {
  final int statusCode;
  final Map<String, dynamic>? rowObject;
  const NetworkFailure({
    required this.statusCode,
    required super.message,
    this.rowObject,
  });
}

@immutable
abstract class NetworkError extends Equatable {
  final String message;

  const NetworkError({this.message = ""});

  @override
  List<Object> get props => [message];

  @override
  String toString() {
    if (message.isEmpty) {
      return "<<< No message provided for this Failure: ${this.runtimeType} >>>";
    }
    return message;
  }
}

// TODO: add Failure subtypes as needed, but these should be added in application layer,
// since Failures are related to errors specific to application domain.
