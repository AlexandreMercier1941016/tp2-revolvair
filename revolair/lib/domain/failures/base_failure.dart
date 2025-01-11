abstract class BaseFailure implements Exception {
  final String message;
  final String context;

  BaseFailure({this.context = '', this.message = ''});

  @override
  String toString() {
    return 'BaseFailure:{ message: $message, context: $context }';
  }
}
