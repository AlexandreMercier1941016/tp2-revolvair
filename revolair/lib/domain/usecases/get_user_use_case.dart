import 'package:easy_localization/easy_localization.dart';
import 'package:revolvair/domain/failures/base_failure.dart';
import 'package:revolvair/domain/failures/usecase_failure.dart';
import 'package:revolvair/generated/locale_keys.g.dart';
import 'package:revolvair/infra/helpers/getExecutionContext.dart';
import 'package:revolvair/infra/repositories/user_repository.dart';

class GetUserUseCase {
  final UserRepository repo;

  GetUserUseCase({required this.repo});

  Future<Map<String,dynamic>> executeCreateUser(Map<String, dynamic> data) async{
    try {
      final user = await repo.createUser(data);
      return user;
    } on BaseFailure{
      rethrow;
    } catch (e) {
      throw UseCaseFailure(
        message: LocaleKeys.errors_useCaseErrorTitle.tr(),
        context: getExecutionContext());
    }
  }
}