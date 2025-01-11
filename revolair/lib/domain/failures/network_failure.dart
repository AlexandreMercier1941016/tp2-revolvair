import 'dart:io';
import 'base_failure.dart';

class NetworkFailure extends BaseFailure implements SocketException {
  NetworkFailure({super.context, super.message});

  @override
  String toString() {
    return 'NetworkFailure:{ message: $message, context: $context }';
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
