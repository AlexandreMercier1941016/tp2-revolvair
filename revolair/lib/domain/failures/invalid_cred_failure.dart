import 'base_failure.dart';

class InvalidCredFailure extends BaseFailure {
  InvalidCredFailure({super.context, super.message});

  @override
  String toString() {
    return 'InvalidCredFailure:{ message: $message, context: $context }';
  }
}
