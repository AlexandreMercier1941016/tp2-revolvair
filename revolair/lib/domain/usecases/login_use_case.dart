import 'package:easy_localization/easy_localization.dart';
import 'package:revolvair/domain/failures/base_failure.dart';
import 'package:revolvair/domain/failures/usecase_failure.dart';
import 'package:revolvair/generated/locale_keys.g.dart';
import 'package:revolvair/infra/helpers/getExecutionContext.dart';
import 'package:revolvair/infra/token/auth_service.dart';

class LoginUseCase {
  final AuthService authService;

  LoginUseCase({required this.authService});

  Future<void> execute(String email, String password) async {
    try{
      await authService.login(email, password);
    }
    on BaseFailure {
      rethrow;
    } catch (e) {
      throw UseCaseFailure(
          message: LocaleKeys.errors_useCaseErrorTitle.tr(),
          context: getExecutionContext());
    }
  }
}