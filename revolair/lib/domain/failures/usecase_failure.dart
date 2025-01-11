class UseCaseFailure implements Exception {
  final String message;
  final String context;
  UseCaseFailure({this.message = '', this.context = ''});
}
