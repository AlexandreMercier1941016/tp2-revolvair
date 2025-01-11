import 'base_failure.dart';

class RepositoryFailure extends BaseFailure {
  RepositoryFailure({super.context, super.message});

  @override
  String toString() {
    return 'RepositoryFailure:{ message: $message, context: $context }';
  }
}
