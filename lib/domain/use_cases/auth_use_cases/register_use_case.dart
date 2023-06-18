import 'package:dartz/dartz.dart';
import 'package:noted/core/errors/failure.dart';
import 'package:noted/data/repos/user_repo_impl.dart';
import 'package:noted/domain/entities/user_entity.dart';
import 'package:noted/domain/use_cases/use_case.dart';

class RegisterUsecase extends UseCase<UserEntity, Map<String, dynamic>?> {
    final UserRepoImpl _userRepoImpl;

  RegisterUsecase(this._userRepoImpl);
  @override
  Future<Either<Failure, UserEntity>> execute(
      [Map<String, dynamic>? parameter]) async {
        return await _userRepoImpl.register(parameter!);
  }
}
