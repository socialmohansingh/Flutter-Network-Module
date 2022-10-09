import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class NetworkFailure extends Failure {
  final int statusCode;
  const NetworkFailure({
    required this.statusCode,
    required super.message,
  });
}

@immutable
abstract class Failure extends Equatable {
  final String message;

  const Failure({this.message = ""});

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
