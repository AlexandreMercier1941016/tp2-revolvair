import 'dart:io';
import 'base_failure.dart';

class HttpResponseFailure extends BaseFailure implements HttpException {
  HttpResponseFailure({super.context, super.message});

  @override
  String toString() {
    return 'HttpResponseFailure:{ message: $message, context: $context }';
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
